From: Levente Kurusa <levex@linux.com>
Subject: [PATCH] BIOS SATA legacy mode failure
Date: Sun, 08 Sep 2013 08:35:49 +0200
Message-ID: <522C1AC5.4080105@linux.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:55797 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3IHGfx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Sep 2013 02:35:53 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so2448199eek.4
        for <linux-ide@vger.kernel.org>; Sat, 07 Sep 2013 23:35:52 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, levex@linux.com

Hi,

I have been testing the Linux Kernel on a two year Toshiba NB100
netbook of mine, however when I enabled SATA compatibility/legacy mode
instead of AHCI mode in the BIOS, the kernel got stuck. I have pasted
the relevant dmesg piece along with a patch that fixes it temporarily.
What I suspect to be the cause is that the BIOS sets the device into
IDE mode, but it will report it as a SATA device and hence libata tries
to send ATA commands to it, which obviously makes it go bad. The patch
fixes it, by adding a new field to ata_device called exce_cnt, which
counts how many exceptions have occured. After three exceptions, it
automatically disables the device. Also, please note this is my first
ever patch for the kernel :-)

The following dmesg is stuck in an infinite loop.
dmesg:
ata3: lost interrupt (Status 0x50)
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata3.00: failed command: READ DMA
ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
               res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.00: status: { DRDY }
ata3: soft resetting link
ata3.00: configured for UDMA/33 (no error)
ata3.00: device reported invalid CHS sector 0
ata3: EH complete

Patch that fixes the infinite loop:
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f9476fb..eeedf80 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2437,6 +2437,14 @@ static void ata_eh_link_report(struct ata_link *link)
                             ehc->i.action, frozen, tries_buf);
                 if (desc)
                         ata_dev_err(ehc->i.dev, "%s\n", desc);
+               ehc->i.dev->exce_cnt ++;
+               ata_dev_warn(ehc->i.dev, "Number of exceptions: %d\n", 
ehc->i.dev->exce_cnt);
+               /**
+                  * The device is failing terribly,
+                 * disable it to prevent damage.
+                 */
+               if(ehc->i.dev->exce_cnt > 2)
+                       ata_dev_disable(ehc->i.dev);
         } else {
                 ata_link_err(link, "exception Emask 0x%x "
                              "SAct 0x%x SErr 0x%x action 0x%x%s%s\n",
diff --git a/include/linux/libata.h b/include/linux/libata.h
index eae7a05..fa52ee6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -660,7 +660,8 @@ struct ata_device {
         u8                      devslp_timing[ATA_LOG_DEVSLP_SIZE];

         /* error history */
-       int                     spdn_cnt;
+       int                     spdn_cnt; /* Number of speed_downs */
+       int                     exce_cnt; /* Number of exceptions that 
happenned */
         /* ering is CLEAR_END, read comment above CLEAR_END */
         struct ata_ering        ering;
  };

Regards,
Levente Kurusa
