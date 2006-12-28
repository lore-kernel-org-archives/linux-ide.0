From: Tejun Heo <htejun@gmail.com>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Thu, 28 Dec 2006 12:51:06 +0900
Message-ID: <45933F2A.5070304@gmail.com>
References: <20060924221020.GB2080@artsapartment.org> <4562C65C.2010802@gmail.com> <20061206181652.GA3107@artsapartment.org> <45779852.1030909@gmail.com> <20061207105525.4ebb4547@localhost.localdomain> <45780AF5.2020605@gmail.com> <20061208010626.GA1856@artsapartment.org> <45927532.3060404@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040804090401030005030406"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:13220 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964913AbWL1DvU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Dec 2006 22:51:20 -0500
Received: by wx-out-0506.google.com with SMTP id h27so4440490wxd
        for <linux-ide@vger.kernel.org>; Wed, 27 Dec 2006 19:51:19 -0800 (PST)
In-Reply-To: <45927532.3060404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040804090401030005030406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Art Haas wrote:
>> Sorry to report that patch did not work. I applied the patch against
>> Linus's tree this morning, built and installed that kernel, and
>> the CD-ROM was not found. I also tried the patch with an update
>> from Linus's tree from this evening, and again the same result.
> 
> Hello, Art.
> 
> Can you please test the attached patch?  The patch is against 2.6.19.
> Please give me my late christmas gift.

Please test this patch too.  TIA.

-- 
tejun

--------------040804090401030005030406
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/include/linux/libata.h b/include/linux/libata.h
index abd2deb..7a4cf9e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1166,6 +1166,14 @@ static inline u8 ata_irq_on(struct ata_port *ap)
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
+	ap->ops->dev_select(ap, 1);
+	if (ap->flags & ATA_FLAG_MMIO)
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
+	else
+		outb(ap->ctl, ioaddr->ctl_addr);
+	tmp = ata_wait_idle(ap);
+
+	ap->ops->dev_select(ap, 0);
 	if (ap->flags & ATA_FLAG_MMIO)
 		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 	else

--------------040804090401030005030406--
