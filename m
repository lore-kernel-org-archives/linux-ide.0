From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED (resolved)
Date: Thu, 05 Aug 2010 23:03:26 -0600
Message-ID: <4C5B979E.8050606@gmail.com>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com> <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se> <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se> <Pine.LNX.4.61.1007171422530.24693@envy.nxs.se> <Pine.LNX.4.61.1007211404480.24693@envy.nxs.se> <Pine.LNX.4.61.1007211433360.24693@envy.nxs.se> <4C531A40.6080804@gmail.com> <Pine.LNX.4.61.1008011625490.24693@envy.nxs.se> <AANLkTikCqugAgM7zd=8H-hchN8b8tmZsP=NHgf+mNvc0@mail.gmail.com> <Pine.LNX.4.61.1008020720250.24693@envy.nxs.se> <AANLkTi=YDuEYt4BK4T4bJH3cY5GujC-tCV4D-ORcbDVT@mail.gmail.com> <Pine.LNX.4.61.1008030732251.24693@envy.nxs.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38214 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0HFFDm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Aug 2010 01:03:42 -0400
Received: by yxg6 with SMTP id 6so2732735yxg.19
        for <linux-ide@vger.kernel.org>; Thu, 05 Aug 2010 22:03:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.1008030732251.24693@envy.nxs.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomas Lund <tlund@nxs.se>
Cc: linux-ide@vger.kernel.org

On 08/02/2010 11:33 PM, Tomas Lund wrote:
> On Mon, 2 Aug 2010, Robert Hancock wrote:
> 
>> On Mon, Aug 2, 2010 at 1:21 AM, Tomas Lund <tlund@nxs.se> wrote:
>>
>>> I have unlocked and tested a total of 4 disks now, both the samsung 1TB and 3 of the WDC 2TB disks. Thank you very much! Left to do: test that everything is working with the PMP aswell.
>>
>> Good to hear.
> 
> I now have all of my drives up and working, running on the PMP and everything is looking perfectly. Thanks again for your help.
> 
>>> Question: Would it be unreasonable to request that the kernel would issue the apropriate ATA-commands to a disk as soon as it is detected, and not try to read from it if it is locked? It would have been really, really nice to just get the error message "drive is locked".
>>
>> It should be possible to indicate that, yes. I'll look into it when I get a chance, if someone doesn't beat me to it..
> 
> Perfect!
> 
> //tlund

Can you test this patch out, assuming you still have anything left that's locked
(or can relock one of them to try it out)? It should print out a warning in
dmesg upon recognizing the device if it's in the security locked state.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ddf8e48..d4ec163 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2561,6 +2561,11 @@ int ata_dev_configure(struct ata_device *dev)
                                       dma_dir_string);
        }
 
+       if (print_info && ata_id_security_locked(dev->id))
+               ata_dev_printk(dev, KERN_WARNING,
+                       "appears to have ATA security enabled and locked - "
+                       "media may be inaccessible until unlocked\n");
+
        /* determine max_sectors */
        dev->max_sectors = ATA_MAX_SECTORS;
        if (dev->flags & ATA_DFLAG_LBA48)
diff --git a/include/linux/ata.h b/include/linux/ata.h
index fe6e681..f2359fa 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -684,6 +684,22 @@ static inline int ata_id_hpa_enabled(const u16 *id)
        return id[ATA_ID_COMMAND_SET_1] & (1 << 10);
 }
 
+static inline int ata_id_security_locked(const u16 *id)
+{
+       /* Yes children, word 83 valid bits cover word 82 data */
+       if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
+               return 0;
+       /* And 87 covers 85-87 */
+       if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
+               return 0;
+       /* Check command sets enabled as well as supported */
+       if ((id[ATA_ID_CFS_ENABLE_1] & (1 << 1)) == 0)
+               return 0;
+       if ((id[ATA_ID_COMMAND_SET_1] & (1 << 1)) == 0)
+               return 0;
+       return (id[ATA_ID_DLF] & 0x0007) == 0x0007;
+}
+
 static inline int ata_id_has_wcache(const u16 *id)
 {
        /* Yes children, word 83 valid bits cover word 82 data */

