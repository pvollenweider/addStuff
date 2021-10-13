package org.jahia.modules.addStuff;

import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import net.htmlparser.jericho.*;
import org.apache.commons.lang.StringUtils;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.filter.AbstractFilter;
import org.jahia.services.render.filter.RenderChain;
import org.jahia.services.render.filter.cache.AggregateCacheFilter;
import org.slf4j.*;
import org.slf4j.Logger;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;

public class AddStuff extends AbstractFilter implements ApplicationListener<ApplicationEvent> {

    private static Logger logger = LoggerFactory.getLogger(AddStuff.class);

    @Override
    public String execute(String previousOut, RenderContext renderContext, Resource resource, RenderChain chain) throws Exception {
        String out = previousOut;

        Set<JCRNodeWrapper> nodesToCheck = new HashSet<JCRNodeWrapper>();
        nodesToCheck.add(renderContext.getSite());
        nodesToCheck.add(resource.getNode());

        Iterator<JCRNodeWrapper> i = nodesToCheck.iterator();

        while (i.hasNext()) {
            JCRNodeWrapper node = i.next();
            if (node.isNodeType("jmix:addStuff")) {

                String addStuffHeadTop = node.hasProperty("addStuffHeadTop") ? node.getProperty("addStuffHeadTop").getString() : null;
                String addStuffHead = node.hasProperty("addStuffHead") ? node.getProperty("addStuffHead").getString() : null;
                String addStuffBodyTop = node.hasProperty("addStuffBodyTop") ? node.getProperty("addStuffBodyTop").getString() : null;
                String addStuffBody = node.hasProperty("addStuffBody") ? node.getProperty("addStuffBody").getString() : null;

                if (StringUtils.isNotEmpty(addStuffHeadTop) || StringUtils.isNotEmpty(addStuffHead) || StringUtils.isNotEmpty(addStuffBodyTop) || StringUtils.isNotEmpty(addStuffBody)) {
                    Source source = new Source(out);
                    OutputDocument outputDocument = new OutputDocument(source);
                    if (StringUtils.isNotBlank(addStuffHeadTop)) {
                        List<Element> headElementList = source.getAllElements(HTMLElementName.HEAD);
                        for (Element element : headElementList) {
                            final StartTag headStartTag = element.getStartTag();
                            outputDocument.replace(headStartTag.getBegin() + headStartTag.toString().indexOf(">"), headStartTag.getBegin() + headStartTag.toString().indexOf(">") + 1,
                                    ">\n" + AggregateCacheFilter.removeCacheTags(addStuffHeadTop) + "\n");
                            break; // avoid to loop if for any reasons multiple body in the page
                        }
                    }
                    if (StringUtils.isNotBlank(addStuffHead)) {
                        List<Element> headElementList = source.getAllElements(HTMLElementName.HEAD);
                        for (Element element : headElementList) {
                            final EndTag headEndTag = element.getEndTag();
                            outputDocument.replace(headEndTag.getBegin(), headEndTag.getBegin() + 1,
                                    "\n" + AggregateCacheFilter.removeCacheTags(addStuffHead) + "\n<");
                            break; // avoid to loop if for any reasons multiple body in the page
                        }
                    }
                    if (StringUtils.isNotBlank(addStuffBodyTop)) {
                        List<Element> bodyElementList = source.getAllElements(HTMLElementName.BODY);
                        for (Element element : bodyElementList) {
                            final StartTag bodyStartTag = element.getStartTag();
                            outputDocument.replace(bodyStartTag.getBegin() + bodyStartTag.toString().indexOf(">"), bodyStartTag.getBegin() + bodyStartTag.toString().indexOf(">") + 1,
                                    ">\n" + AggregateCacheFilter.removeCacheTags(addStuffBodyTop) + "\n");
                            break; // avoid to loop if for any reasons multiple body in the page
                        }
                    }
                    if (StringUtils.isNotBlank(addStuffBody)) {
                        List<Element> bodyElementList = source.getAllElements(HTMLElementName.BODY);
                        for (Element element : bodyElementList) {
                            final EndTag bodyEndTag = element.getEndTag();
                            outputDocument.replace(bodyEndTag.getBegin(), bodyEndTag.getBegin() + 1, "\n" + AggregateCacheFilter.removeCacheTags(addStuffBody) + "\n<");
                            break; // avoid to loop if for any reasons multiple body in the page
                        }
                    }
                    out = outputDocument.toString().trim();
                }
            }
        }
        return out;
    }

    public void onApplicationEvent(ApplicationEvent event) {
    }
}

