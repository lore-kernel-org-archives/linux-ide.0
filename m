From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: sx8 driver
Date: Thu, 2 Mar 2006 16:22:25 +0200
Message-ID: <5d96567b0603020622v5c846b0br6b634188bc14e68b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:24294 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751360AbWCBOW0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Mar 2006 09:22:26 -0500
Received: by wproxy.gmail.com with SMTP id 50so415638wri
        for <linux-ide@vger.kernel.org>; Thu, 02 Mar 2006 06:22:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

had anyone here managed to compile sx8 ( carmel ) driver ?
i am failing to do so in  2.6.15 .

make  -C /usr/kernels/linux-2.6.15 SUBDIRS=`pwd` modules


/usr/kernels/linux-2.6.15/drivers/scsi/hosts.h:1:2: warning: #warning
"This file is obsolete, please use <scsi/scsi_host.h> instead"
/usr/download/cml26x20050104_1.1.0.18/carmel.c:255: error: syntax
error before '*' token
/usr/download/cml26x20050104_1.1.0.18/carmel.c:255: warning: function
declaration isn't a prototype
/usr/download/cml26x20050104_1.1.0.18/carmel.c:262: error: syntax
error before '*' token
/usr/download/cml26x20050104_1.1.0.18/carmel.c:262: warning: function
declaration isn't a prototype
/usr/download/cml26x20050104_1.1.0.18/carmel.c:346: error: syntax
error before "driver_template"
/usr/download/cml26x20050104_1.1.0.18/carmel.c:346: warning: type
defaults to `int' in declaration of `driver_template'
/usr/download/cml26x20050104_1.1.0.18/carmel.c:347: error: field name
not in record or union initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:347: error: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:347: warning:
initialization makes integer from pointer without a cast
/usr/download/cml26x20050104_1.1.0.18/carmel.c:348: error: field name
not in record or union initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:348: error: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:348: warning: excess
elements in scalar initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:348: warning: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:349: error: field name
not in record or union initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:349: error: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:349: warning: excess
elements in scalar initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:349: warning: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:350: error: field name
not in record or union initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:350: error: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:350: warning: excess
elements in scalar initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:350: warning: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:351: error: field name
not in record or union initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:351: error: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:351: warning: excess
elements in scalar initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:351: warning: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:352: error: field name
not in record or union initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:352: error: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:352: warning: excess
elements in scalar initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:352: warning: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:353: error: field name
not in record or union initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:353: error: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:353: warning: excess
elements in scalar initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:353: warning: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:354: error: field name
not in record or union initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:354: error: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:354: warning: excess
elements in scalar initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:354: warning: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:355: error: field name
not in record or union initializer
/usr/download/cml26x20050104_1.1.0.18/carmel.c:355: error: (near
initialization for `driver_template')
/usr/download/cml26x20050104_1.1.0.18/carmel.c:355: warning: excess
elements in scalar initializer

--
Raz
