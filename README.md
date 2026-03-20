# AddStuff
> A Jahia module that allows injecting HTML code into the HEAD or BODY of any page.

## Requirements

- Jahia 8.0 or higher

## Installation

Please read the dedicated tutorial on https://academy.jahia.com/training-kb/tutorials/administrators/installing-a-module and select the AddStuff module from the store.

## Usage

AddStuff allows editors to inject custom HTML (CSS, JavaScript, tracking scripts, etc.) at four specific locations in a page, without modifying any template or existing module.

> **Note:** The injected code is only visible in **preview** or **live** mode. Nothing will appear in edit mode — this is by design, as the module works as a render filter applied at page rendering time.

There are 4 injection points:

```html
<!doctype html>
<html lang="en">
  <head>
    <!-- Top of the HEAD — injected right after <head> -->

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hello, world!</title>
    <link href="/modules/anyModule/css/mystyle.css" rel="stylesheet">
    <script src="/modules/anyModule/javascript/my.js"></script>

    <!-- End of the HEAD — injected right before </head> -->
  </head>
  <body>
    <!-- Top of the BODY — injected right after <body> -->

    <h1>Hello, world!</h1>
    <p>Some content here...</p>

    <!-- End of the BODY — injected right before </body> -->
  </body>
</html>
```

### Scope: site-wide vs single page

You can configure AddStuff at two levels. Both can be active at the same time — site-level content is injected first, then page-level content is appended at the same location.

#### Site-wide (all pages)

Choose this if you need to inject code on **every page of your site** (e.g. a global analytics script).

In edit mode, right-click your site node in the left panel and choose `Edit`. Under the `Options` tab, enable `Add stuff in your HTML code (only for preview/live mode)` to reveal the 4 fields. Fill in the relevant fields and save.

> The site node is auto-published — no publication workflow is needed.

#### Single page

Choose this if you need to inject code **on one specific page only**.

In edit mode, right-click the page node in the left panel and choose `Edit`. Under the `Options` tab, enable `Add stuff in your HTML code (only for preview/live mode)` to reveal the 4 fields. Fill in the relevant fields and save.

> Page changes require a publication workflow to appear in live mode. You can use preview mode to verify the result first.

## Examples

### CSS injection

To override existing styles on all pages, use the **End of the HEAD** field at site level (so your rules load after existing stylesheets):

```html
<style>
.header {
    background-color: #e9e9e9;
    padding: 10px;
}
</style>
```

### JavaScript injection — Google Tag Manager

GTM requires code in two locations. At site level, fill in:

**Top of the HEAD:**
```html
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-123456');</script>
<!-- End Google Tag Manager -->
```

**Top of the BODY:**
```html
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-123456"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
```
