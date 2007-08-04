From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS P5W motherboard PMP
Date: Sat, 04 Aug 2007 17:48:03 +0900
Message-ID: <46B43D43.7000107@gmail.com>
References: <ec7e30370708031753m668f68a2kd67ad8278eb78675@mail.gmail.com>	 <46B414C0.2060606@gmail.com> <ec7e30370708032338x250c4689j49aabfcac373837f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020502020706020701010906"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:39173 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbXHDItE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 04:49:04 -0400
Received: by rv-out-0910.google.com with SMTP id k20so848649rvb
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 01:49:04 -0700 (PDT)
In-Reply-To: <ec7e30370708032338x250c4689j49aabfcac373837f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Madsen <david.madsen@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020502020706020701010906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David Madsen wrote:
> Yes, I patched the 2.6.22.1 vanilla kernel with the libata patch from here.
> 
> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.22.1-20070803.tar.bz2

Hmmm... Can you please apply the attached patch on top of libata-tj and
report the kernel boot log?

-- 
tejun

--------------020502020706020701010906
Content-Type: text/x-patch;
 name="debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug.patch"

---
 drivers/ata/ahci.c        |    5 ++++-
 drivers/ata/libata-core.c |    6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -691,17 +691,17 @@ unsigned int ata_dev_classify(const stru
 	 * identifies a port multiplier and 0x3c/0xc3 a SEMB device.
 	 */
 	if ((tf->lbam == 0) && (tf->lbah == 0)) {
-		DPRINTK("found ATA device by sig\n");
+		printk("found ATA device by sig\n");
 		return ATA_DEV_ATA;
 	}
 
 	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb)) {
-		DPRINTK("found ATAPI device by sig\n");
+		printk("found ATAPI device by sig\n");
 		return ATA_DEV_ATAPI;
 	}
 
 	if ((tf->lbam == 0x69) && (tf->lbah == 0x96)) {
-		DPRINTK("found PMP device by sig\n");
+		printk("found PMP device by sig\n");
 		return ATA_DEV_PMP;
 	}
 
Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -972,6 +972,9 @@ static unsigned int ahci_dev_classify(st
 	tf.lbal		= (tmp >> 8)	& 0xff;
 	tf.nsect	= (tmp)		& 0xff;
 
+	ata_port_printk(ap, KERN_INFO, "XXX sig %02x:%02x:%02x %02x\n",
+			tf.lbal, tf.lbam, tf.lbah, tf.nsect);
+
 	return ata_dev_classify(&tf);
 }
 
@@ -1072,7 +1075,7 @@ static int ahci_do_softreset(struct ata_
 	struct ata_taskfile tf;
 	int rc;
 
-	DPRINTK("ENTER\n");
+	ata_link_printk(link, KERN_INFO, "XXX softresetting pmp=%d\n", pmp);
 
 	if (ata_link_offline(link)) {
 		DPRINTK("PHY reports no device\n");

--------------020502020706020701010906--
