From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Subject: RE: SATA intel High loads due to writes vs ata_piix switch
Date: Thu, 17 May 2007 12:57:07 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7033AB60B@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
References: <8E8F647D7835334B985D069AE964A4F7028FE7F0@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <20070516214236.08dd02c9@the-village.bc.nu> <8E8F647D7835334B985D069AE964A4F7033AB605@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <8E8F647D7835334B985D069AE964A4F7033AB60A@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:54018 "EHLO
	ecqcmtlbh.quebec.int.ec.gc.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754561AbXEQQ53 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 May 2007 12:57:29 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE <linux-ide@vger.kernel.org>

> > 
> > > -----Message d'origine-----
> > > De : Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> > > 
> 
> BTW, here is the hdparm using the old driver:

Wrong key... Here is the output of hdparm:

OLD DRIVER:
-----------
[root@kayak /root]# hdparm -T -t /dev/hda

/dev/hda:
 Timing cached reads:   4816 MB in  2.00 seconds = 2408.44 MB/sec
 Timing buffered disk reads:   12 MB in  3.23 seconds =   3.72 MB/sec


LIBATA:
-------
[root@kayak /root]# hdparm -T -t /dev/sda

/dev/sda:
 Timing cached reads:   4960 MB in  2.00 seconds = 2480.38 MB/sec
 Timing buffered disk reads:  168 MB in  3.00 seconds =  55.94 MB/sec


And Alan, you where right... The load average did grew up has much using
libata vs old-ide... The main difference was that the system was still
responsive (unles trying to make a parallel write/read on that same
disk) and it actually finished up writing 10000 1mb file a few mins
(instead of me stopping the test after 15 minutes and only around 1500
files written down).

- vin
