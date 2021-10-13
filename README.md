# AddStuff
> A Jahia module that allow to inject HTML code in the HEAD or BODY part.

## Installation

Please read the dedicated tutorial on https://academy.jahia.com/training-kb/tutorials/administrators/installing-a-module and select the AddStuff module from the store.

## Usage

The idea of this module is to allow any editor to inject some code in the HEAD or the BODY part of a page, without doing anything to your template set or any existing modules.
As an example, you can add a JavaScript snippet on the bottom of the BODY, or some CSS inline style in the HEAD section.

There is 4 different placeholders to inject your code:

- Top of the HEAD
- End of the HEAD
- Top of the BODY
- End of the BODY

In term of HTML, here are the different placeholders:

```html
<!doctype html>
<html lang="en">
  <head>
    <!-- Top of the HEAD -->

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hello, world!</title>

    <!-- Some CSS or JavaScript comming from the template:addResource tag -->
    <link href="/modules/anyModule/css/mystyle.css" rel="stylesheet">
    <script src="/modules/anyModule/jacasvript/my.js"></script>

    <!-- End of the HEAD -->
  </head>
  <body>
     <!-- Top of the BODY -->
     <h1>Hello, world!</h1>
     <p>Some content here...</p>

     
     <!-- End of the BODY -->
  </body>
</html>
```

You can do it using two different ways, the global (site) way or the single page way.

### The global (site) way

You will choose the **global way** if you need to **inject some code on all pages of your site**.

On Edit mode, on the left panel, you need to right-click on your site node and choose the `edit` action.

Then, under the `option` part, you will need to enable the `Add stuff in your HTML code (only for preview/live mode)`. Once it’s done, you will see the 4 placeholders.

You can insert your code in the chosen part, then save it.

As the site node is an auto-published node, you don’t need to start a public workflow. 

### The page way

If you need to inject some code **only on a single page**, you can edit your page node from the left panel and enable the `Add stuff in your HTML code (only for preview/live mode)` in the `option` part. Once it’s done, you will see the 4 placeholders. You can insert your code in the chosen part, then save it.

On the page way, you can preview this page to see the result (the code is only injected in preview or live mode), and you will need to start a publication workflow to view the result on live mode.

## Examples

### CSS injection

If you need to inject some inline CSS classes on all pages, you can choose the global way, then enable the option and insert your code at the `End of the HEAD section`, so this code will override all your CSS assets coming from your existing modules or template set.

```css
.header {
    background-color: #e9e9e9;
    padding: 10px; 
}
```
If you only need to insert some CSS on a single page, then you will need to do it on the page node instead of the site node.

### JavaScript injection

For many reasons, you may want to inject some JavaScript into a page. This can be done at many places, on the HEAD or on the BODY part. 

For instance, if you want to integrate a Google Tag Manager, you will need to add code on two different parts. The first part  should be added **as high in the <head> of the page as possible**, so you will choose the `Top of the HEAD section`
```javascript
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-123456');</script>
<!-- End Google Tag Manager -->
```
And Additionally, you will need to paste some code **immediately after the opening <body> tag**, so you will choose the
`Top of the BODY section`
```javascript
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-123456"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
```
