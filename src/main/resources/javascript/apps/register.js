window.jahia.i18n.loadNamespaces('addstuff');

window.jahia.uiExtender.registry.add('adminRoute', 'addStuffSiteSettings', {
    targets: ['administration-sites:100'],
    requiredPermission: 'siteAdminUsers',
    label: 'addstuff:addstuff.siteSettings.title',
    isSelectable: true,
    iframeUrl: window.contextJsParameters.contextPath + '/cms/editframe/default/$lang/sites/$site-key.addStuff.html'
});
