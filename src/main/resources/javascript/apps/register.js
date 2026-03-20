(function () {
    var contextPath = window.contextJsParameters.contextPath;
    var cmBase = contextPath + '/modules/addstuff/javascript/codemirror';
    var REACT_ELEMENT = Symbol.for('react.element');

    // Inject CodeMirror CSS into jContent context immediately
    [
        cmBase + '/codemirror.min.css',
        cmBase + '/addon/fold/foldgutter.min.css'
    ].forEach(function (href) {
        var link = document.createElement('link');
        link.rel = 'stylesheet';
        link.href = href;
        document.head.appendChild(link);
    });

    function loadScript(src) {
        return new Promise(function (resolve, reject) {
            var s = document.createElement('script');
            s.src = src;
            s.onload = resolve;
            s.onerror = reject;
            document.head.appendChild(s);
        });
    }

    function moonIcon(IconComp) {
        return {
            $$typeof: REACT_ELEMENT,
            type: IconComp,
            key: null,
            ref: null,
            props: {},
            _owner: null,
            _store: {}
        };
    }

    /** Minimal React element factory — no React import needed. */
    function h(type, props, key, ref) {
        return {
            $$typeof: REACT_ELEMENT,
            type: type,
            key: key !== undefined ? String(key) : null,
            ref: ref || null,
            props: props || {},
            _owner: null,
            _store: {}
        };
    }

    /**
     * CodeMirror selectorType component.
     * API matches Jahia content-editor selectorType convention: { field, id, value, onChange }
     * - field:    content editor field definition (field.selectorOptions for future extensibility)
     * - id:       HTML id for the editor container
     * - value:    current field value
     * - onChange: callback(newValue) to propagate changes to content editor
     */
    function CodeMirrorAddStuffCmp(props) {
        var value = props.value || '';
        var onChange = props.onChange;
        var id = props.id || 'cm';

        return h('div', {
            style: {border: '1px solid #ddd', borderRadius: '3px'}
        }, id, function (domEl) {
            if (!domEl) {
                return;
            }

            if (!domEl._cm) {
                // Initial mount — create CodeMirror instance
                var cm = CodeMirror(domEl, {
                    value: value,
                    mode: 'htmlmixed',
                    lineNumbers: true,
                    lineWrapping: true,
                    smartIndent: true,
                    autoCloseTags: true,
                    autoCloseBrackets: true,
                    matchBrackets: true,
                    foldGutter: true,
                    gutters: ['CodeMirror-linenumbers', 'CodeMirror-foldgutter'],
                    theme: 'default',
                    tabSize: 2
                });
                domEl._cm = cm;
                domEl._cmValue = value;

                cm.on('change', function (editor) {
                    domEl._cmValue = editor.getValue();
                    if (onChange) {
                        onChange(editor.getValue());
                    }
                });
            } else if (value !== domEl._cmValue) {
                // Value updated externally (e.g. language switch) — sync editor
                domEl._cm.setValue(value);
                domEl._cmValue = value;
            }
        });
    }

    CodeMirrorAddStuffCmp.displayName = 'CodeMirrorAddStuffCmp';

    // ── Load i18n and CodeMirror in parallel ─────────────────────────────────

    var i18nReady = window.jahia.i18n.loadNamespaces('addstuff');

    var cmReady = loadScript(cmBase + '/codemirror.min.js')
        .then(function () {
            return Promise.all([
                loadScript(cmBase + '/mode/xml/xml.min.js'),
                loadScript(cmBase + '/mode/javascript/javascript.min.js'),
                loadScript(cmBase + '/mode/css/css.min.js'),
                loadScript(cmBase + '/addon/fold/foldcode.min.js'),
                loadScript(cmBase + '/addon/fold/xml-fold.min.js')
            ]);
        })
        .then(function () {
            return Promise.all([
                loadScript(cmBase + '/mode/htmlmixed/htmlmixed.min.js'),
                loadScript(cmBase + '/addon/edit/closetag.min.js'),
                loadScript(cmBase + '/addon/edit/closebrackets.min.js'),
                loadScript(cmBase + '/addon/edit/matchbrackets.min.js'),
                loadScript(cmBase + '/addon/fold/foldgutter.min.js'),
                loadScript(cmBase + '/addon/fold/brace-fold.min.js'),
                loadScript(cmBase + '/addon/fold/comment-fold.min.js')
            ]);
        });

    // ── Admin route: site-level settings panel (iframe) ──────────────────────

    i18nReady.then(function () {
        window.jahia.uiExtender.registry.add('adminRoute', 'addStuffSiteSettings', {
            targets: ['administration-sites:100'],
            requiredPermission: 'siteAdminUsers',
            label: 'addstuff:addstuff.siteSettings.title',
            icon: moonIcon(window.jahia.moonstone.Code),
            isSelectable: true,
            iframeUrl: contextPath + '/cms/editframe/default/$lang/sites/$site-key.addStuff.html'
        });
    });

    // ── selectorType: CodeMirror field renderer for Content Editor ────────────

    cmReady.then(function () {
        window.jahia.uiExtender.registry.add('selectorType', 'CodeMirrorAddStuff', {
            cmp: CodeMirrorAddStuffCmp,
            supportMultiple: false
        });
        console.debug('%c AddStuff CodeMirror selectorType registered', 'color: #3c8cba');
    });

}());
