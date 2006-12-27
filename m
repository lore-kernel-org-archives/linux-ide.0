From: Tejun Heo <htejun@gmail.com>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Wed, 27 Dec 2006 22:29:22 +0900
Message-ID: <45927532.3060404@gmail.com>
References: <20060924221020.GB2080@artsapartment.org> <4562C65C.2010802@gmail.com> <20061206181652.GA3107@artsapartment.org> <45779852.1030909@gmail.com> <20061207105525.4ebb4547@localhost.localdomain> <45780AF5.2020605@gmail.com> <20061208010626.GA1856@artsapartment.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060309070206070008030601"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:21990 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932789AbWL0N3f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Dec 2006 08:29:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3876326uga
        for <linux-ide@vger.kernel.org>; Wed, 27 Dec 2006 05:29:34 -0800 (PST)
In-Reply-To: <20061208010626.GA1856@artsapartment.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------060309070206070008030601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Art Haas wrote:
> Sorry to report that patch did not work. I applied the patch against
> Linus's tree this morning, built and installed that kernel, and
> the CD-ROM was not found. I also tried the patch with an update
> from Linus's tree from this evening, and again the same result.

Hello, Art.

Can you please test the attached patch?  The patch is against 2.6.19.
Please give me my late christmas gift.

Thanks.

-- 
tejun

--------------060309070206070008030601
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- tree0/drivers/ata/libata-sff.c.orig	2006-12-27 22:26:03.000000000 +0900
+++ tree0/drivers/ata/libata-sff.c	2006-12-27 22:26:15.000000000 +0900
@@ -662,6 +662,7 @@
  */
 void ata_bmdma_freeze(struct ata_port *ap)
 {
+#if 0
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	ap->ctl |= ATA_NIEN;
@@ -671,6 +672,7 @@
 		writeb(ap->ctl, (void __iomem *)ioaddr->ctl_addr);
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
+#endif
 }
 
 /**

--------------060309070206070008030601--
