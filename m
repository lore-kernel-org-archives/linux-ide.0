From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata dev_config call order wrong.
Date: Sun, 29 Aug 2004 14:25:03 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41321F7F.7050300@pobox.com>
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060908080205050906030907"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24276 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268259AbUH2SZT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Aug 2004 14:25:19 -0400
In-Reply-To: <4132198B.8000504@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060908080205050906030907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> me either, unless I can figure out a way to detect that a disk is PATA 
> not SATA.  Nothing is obvious from the specs on www.t13.org, but who knows.

According to the Serial ATA docs, IDENTIFY DEVICE word 93 will be zero 
if it's Serial ATA.  Who knows if that's true, given the wierd wild 
world of ATA devices.

So, given the attached patch, you could try and create a generic 
ata_dev_config that all drivers call, that does something like

	/* limit bridge transfers to udma5, 200 sectors */
	if ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev))) {
                 printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
                        ap->id, dev->devno);
		ap->udma_mask &= ATA_UDMA5;
                 ap->host->max_sectors = ATA_MAX_SECTORS;
                 ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
                 dev->flags |= ATA_DFLAG_LOCK_SECTORS;
	}

Regards,

	Jeff



--------------060908080205050906030907
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== include/linux/ata.h 1.17 vs edited =====
--- 1.17/include/linux/ata.h	2004-08-18 01:47:22 -04:00
+++ edited/include/linux/ata.h	2004-08-29 14:18:02 -04:00
@@ -218,6 +218,7 @@
 };
 
 #define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
+#define ata_id_is_sata(dev)	((dev)->id[93] == 0)
 #define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
 #define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
 #define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))

--------------060908080205050906030907--
