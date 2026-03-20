package org.jahia.modules.addStuff.sitesettings;

import org.apache.commons.lang.StringUtils;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.decorator.JCRSiteNode;
import org.jahia.services.render.RenderContext;
import org.springframework.webflow.execution.RequestContext;

import javax.jcr.RepositoryException;
import java.io.Serializable;

/**
 * Spring Webflow handler for the AddStuff site settings panel.
 * Reads and saves the four HTML injection properties on the site node.
 */
public class AddStuffSiteSettingsFlowHandler implements Serializable {

    public JCRSiteNode getSiteNode(RequestContext ctx) throws RepositoryException {
        return getRenderContext(ctx).getSite();
    }

    public void saveSettings(RequestContext ctx,
                             String addStuffHeadTop,
                             String addStuffHead,
                             String addStuffBodyTop,
                             String addStuffBody) throws RepositoryException {
        JCRSiteNode site = getRenderContext(ctx).getSite();

        if (!site.isNodeType("jmix:addStuff")) {
            site.addMixin("jmix:addStuff");
        }

        setOrRemove(site, "addStuffHeadTop", addStuffHeadTop);
        setOrRemove(site, "addStuffHead",    addStuffHead);
        setOrRemove(site, "addStuffBodyTop", addStuffBodyTop);
        setOrRemove(site, "addStuffBody",    addStuffBody);

        site.saveSession();
    }

    private void setOrRemove(JCRNodeWrapper node, String property, String value) throws RepositoryException {
        if (StringUtils.isNotBlank(value)) {
            node.setProperty(property, value);
        } else if (node.hasProperty(property)) {
            node.getProperty(property).remove();
        }
    }

    private RenderContext getRenderContext(RequestContext ctx) {
        return (RenderContext) ctx.getExternalContext().getRequestMap().get("renderContext");
    }
}
