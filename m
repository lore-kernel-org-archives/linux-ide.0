From: Tejun Heo <tj@kernel.org>
Subject: Re: sata-sil drive detection issues.
Date: Thu, 17 Feb 2011 10:58:15 +0100
Message-ID: <20110217095815.GN19830@htj.dyndns.org>
References: <4D5C92F4.5000906@crc.id.au>
 <4D5CA2B1.8020905@crc.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61106 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab1BQJ6U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2011 04:58:20 -0500
Received: by fxm20 with SMTP id 20so2401338fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 17 Feb 2011 01:58:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5CA2B1.8020905@crc.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Haigh <netwiz@crc.id.au>
Cc: linux-ide@vger.kernel.org

Hello,

On Thu, Feb 17, 2011 at 03:23:13PM +1100, Steven Haigh wrote:
> I might have acted a bit prematurely on this. After booting off the
> CentOS 5.5 installation DVD, I noticed that the esata drive at the
> same problem. After lots of cable swapping and testing, I have found
> that the esata cable may be faulty as a direct SATA -> drive
> connection works perfectly.
> 
> I am unsure however why my previous test of plugging the esata drive
> directly to the onboard SATA controller worked - however now this
> also fails.
> 
> I shall attempt to try some different eSATA cables and report back
> if I manage to isolate the issue directly to the sata_sil module.

It's probably dependent on timing and not completely reliable.  It's
rather complicated.  The AC_ERR_NODEV_HINT thing is there primarily
for PATA controllers so that they don't spend time trying to probe
empty ports.

Does the following patch resolve the problem?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d4e52e2..d08383f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1908,7 +1908,13 @@ retry:
 		err_mask = ata_do_dev_read_id(dev, &tf, id);
 
 	if (err_mask) {
-		if (err_mask & AC_ERR_NODEV_HINT) {
+		/*
+		 * AC_ERR_NODEV_HINT is primarily used to detect empty PATA
+		 * ports.  Some SATA devices incorrectly trigger it.
+		 * Ignore if the physical link is positively online.
+		 */
+		if ((err_mask & AC_ERR_NODEV_HINT) &&
+		    !ata_phys_link_online(ata_dev_phys_link(dev))) {
 			ata_dev_printk(dev, KERN_DEBUG,
 				       "NODEV after polling detection\n");
 			return -ENOENT;


-- 
tejun
