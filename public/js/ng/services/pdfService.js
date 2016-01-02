/**
 * PDF service
 * @param rs
 * @param $filter
 */
var pdfService = function($filter, $q) {

    var self = this;

    this.noneImg = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2P8DwQACgAD/il4QJ8AAAAASUVORK5CYII=';
    this.hr_image = 'data:image/png;base64,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';
    this.report_image = '';
    this.client_image = '';
    this.pet_image = '';

    this.styles = {
        header: {
            fontSize: 18,
                bold: true,
                margin: [0, 2, 0, 2],
        },
        subheader: {
            fontSize: 11,
                bold: true,
                margin: [0, 2, 0, 2],
                color: 'gray'
        },
        reportImage:    {width: 400, height: 70, margin: [0, 0, 0, 20]},
        tableExample:   {fontSize: 11, margin: [0, 5, 0, 15]},
        tableHeader:    {fontSize: 12, bold: true,  color: 'black'},
        topTitle:       {fontSize: 26, bold: true, margin: [0, 10, 0, 10],  color: 'red'},
        topTitle2:      {fontSize: 18, bold: true, margin: [0, 10, 0, 10],  color: 'red'},
        topTitle3:      {fontSize: 14, bold: true, margin: [0, 10, 0, 10],  color: 'black'},
        subTitle:       {fontSize: 11, bold: true, margin: [0, 2, 0, 2], color: 'gray'},
        subTitle2:      {fontSize: 14, bold: true, margin: [0, 2, 0, 15], color: 'gray'},
        subTitle3:      {fontSize: 12, bold: true, color: 'black'},
        subTitle4:      {fontSize: 11, italics: true, color: 'gray'},

    };

    this.initImages = function() {
        self.makeImage(rs, 'settings', 'report_image_id', 'report_image', 'path_thumb');
    };

    /**
     * Convert an image
     * to a base64 string
     * @param  {String}   url
     * @param  {Function} callback
     * @param  {String}   [outputFormat=image/png]
     */
    this.convertImgToBase64 = function(url, callback, outputFormat){
        var canvas = document.createElement('CANVAS'),
            ctx = canvas.getContext('2d'),
            img = new Image;
            img.crossOrigin = 'Anonymous';
            img.src = url;
        img.onload = function(){
            var dataURL;
            canvas.height = img.height;
            canvas.width = img.width;
            ctx.drawImage(img, 0, 0);
            dataURL = canvas.toDataURL(outputFormat);
            callback.call(this, dataURL);
            canvas = null;
        };
    };

    this.makeImage = function(scope, t, n, tt, path) {
        var deffered = $q.defer();
        var img_image = '';
        if (scope[t][n]) {
            if (rs.files[scope[t][n]]) {
                self.convertImgToBase64($filter('l')(rs.files[scope[t][n]][path]), function(base64img){
                    self[tt] = base64img;
                    deffered.resolve(base64img);
                });
            } else {
                self[tt] = self.noneImg;
                deffered.resolve(self.noneImg);
            }
        } else {
            self[tt] = self.noneImg;
            deffered.resolve(self.noneImg);
        }
        return deffered.promise;
    };

    /**
     * docDefinition
     * @param type
     * @param docDefinition
     * @param report_name
     */
    this.options = function(type, docDefinition, report_name) {
        switch (type) {
            case 'screen':   pdfMake.createPdf(docDefinition).open(); break;
            case 'print':    pdfMake.createPdf(docDefinition).print(); break;
            case 'download': pdfMake.createPdf(docDefinition).download(report_name); break;
        }
    };

    this.contactInfoHeader = function() {
        return [
            {
                image: self.report_image,
                style: 'reportImage'
            },
            {
                columns: [
                    {
                        stack: [
                            {text: (rs.settings.business_name || ''), style: 'header'},
                            {text: (rs.settings.business_address ? rs.l.l('address')+': ' + rs.settings.business_address : '')}
                        ]
                    },
                    {
                        stack: [
                            {
                                text: (rs.settings.business_main_phone ? rs.l.l('phone')+': ' + rs.settings.business_main_phone : ''),
                                style: 'subheader'
                            },
                            {
                                text: (rs.settings.business_extra_phone ? rs.l.l('contact')+': ' + rs.settings.business_extra_phone : ''),
                                style: 'subheader'
                            },
                            {text: (rs.settings.business_email ? rs.l.l('email')+': ' + rs.settings.business_email : ''), style: 'subheader'}
                        ]
                    }
                ]
            },
            {text: "\n\n"}
        ];
    }

};