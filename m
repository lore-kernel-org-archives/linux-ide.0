From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Re: Linux v2.6.22-rc3
Date: Wed, 06 Jun 2007 17:46:30 +0900
Message-ID: <46667466.4010500@gmail.com>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org>	 <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com>	 <466196AD.3090502@garzik.org> <9d2cd630706031046n2bd77585o7c0df1c5fea5167f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010506040506040407080802"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:31144 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbXFFIqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jun 2007 04:46:38 -0400
Received: by wa-out-1112.google.com with SMTP id v27so88122wah
        for <linux-ide@vger.kernel.org>; Wed, 06 Jun 2007 01:46:38 -0700 (PDT)
In-Reply-To: <9d2cd630706031046n2bd77585o7c0df1c5fea5167f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregor Jasny <gjasny@googlemail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------010506040506040407080802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gregor Jasny wrote:
> 2007/6/2, Jeff Garzik <jeff@garzik.org>:
>> Does this patch change the behavior at all?
> 
> No. It still times out. I've raised the first timeout to 60 seconds
> but still no luck.

Let's see where we're failing.  Please apply the attached patch and
report what kernel says.

Thanks.

-- 
tejun

--------------010506040506040407080802
Content-Type: text/x-patch;
 name="srst-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="srst-debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4733f00..ae6f177 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3053,8 +3053,11 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	if (dev0) {
 		rc = ata_wait_ready(ap, deadline);
 		if (rc) {
-			if (rc != -ENODEV)
+			if (rc != -ENODEV) {
+				ata_port_printk(ap, KERN_WARNING,
+						"ata_bus_post_reset: EXIT0\n");
 				return rc;
+			}
 			ret = rc;
 		}
 	}
@@ -3070,15 +3073,21 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 		lbal = ioread8(ioaddr->lbal_addr);
 		if ((nsect == 1) && (lbal == 1))
 			break;
-		if (time_after(jiffies, deadline))
+		if (time_after(jiffies, deadline)) {
+			ata_port_printk(ap, KERN_WARNING,
+					"ata_bus_post_reset: EXIT1\n");
 			return -EBUSY;
+		}
 		msleep(50);	/* give drive a breather */
 	}
 	if (dev1) {
 		rc = ata_wait_ready(ap, deadline);
 		if (rc) {
-			if (rc != -ENODEV)
+			if (rc != -ENODEV) {
+				ata_port_printk(ap, KERN_WARNING,
+						"ata_bus_post_reset: EXIT2\n");
 				return rc;
+			}
 			ret = rc;
 		}
 	}
@@ -3090,6 +3099,7 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	if (dev0)
 		ap->ops->dev_select(ap, 0);
 
+	ata_port_printk(ap, KERN_WARNING, "ata_bus_post_reset: EXIT3\n");
 	return ret;
 }
 

--------------010506040506040407080802--
