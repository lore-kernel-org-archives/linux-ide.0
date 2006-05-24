From: Tejun Heo <htejun@gmail.com>
Subject: Re: hotplug works, but newly plug not
Date: Wed, 24 May 2006 13:51:03 -0700
Message-ID: <4474C737.9000600@gmail.com>
References: <1148484316.26093.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010802030703000006030709"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:14050 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932387AbWEXUvU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 May 2006 16:51:20 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1976356ugf
        for <linux-ide@vger.kernel.org>; Wed, 24 May 2006 13:51:18 -0700 (PDT)
In-Reply-To: <1148484316.26093.72.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mingz@ele.uri.edu
Cc: linux-ide-list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

This is a multi-part message in MIME format.
--------------010802030703000006030709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ming Zhang wrote:
> Hi All
> 
> I use the libata patch from
> http://home-tj.org/wiki/index.php/Libata-tj-stable with my supermicro MB
> ( ICH7R chip). The AHCI works as desired in most of the time.
> 
> If I have disk(s) plugged in during boot. Then after boot, I kept unplug
> and plug many times and it works fine.
> 
> but i noticed that if I have the disk(s) unplugged during boot, then
> after boot, I plug the disk and nothing shows. if I try to do rescan by
> run the rescan lun script, i saw these from dmesg.
> 
> Anything clue ? Thanks!
> 
> Ming
> 
> ---------------------------------------
> ata4: soft resetting port
> ata4: SATA link down (SStatus 0 SControl 0)
> ata4: EH complete
> ata3: soft resetting port
> ata3: SATA link down (SStatus 0 SControl 0)
> ata3: EH complete
> ata4: soft resetting port
> ata4: SATA link down (SStatus 0 SControl 0)
> ata4: EH complete
> ata3: soft resetting port
> ata3: SATA link down (SStatus 0 SControl 0)
> ata3: EH complete
> ata4: soft resetting port
> ata4: SATA link down (SStatus 0 SControl 0)
> ata4: EH complete

Hello,

That never happened to me on AHCI mode but I experienced similar thing 
with piix mode.  It might be that your BIOS doesn't turn on PCS enable 
bits for empty ports and thus the empty ports cannot be used after boot. 
Can you try the attached patch?  (only compile-tested, be cautious)

-- 
tejun

--------------010802030703000006030709
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 45fd71d..83751dd 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1306,6 +1306,15 @@ static int ahci_init_one (struct pci_dev
 		have_msi = 0;
 	}
 
+	{
+		u8 orig_pcs, pcs;
+		pci_read_config_byte(pdev, 0x92, &orig_pcs);
+		pci_write_config_byte(pdev, 0x92, 0xf);
+		pci_read_config_byte(pdev, 0x92, &pcs);
+		dev_printk(KERN_INFO, &pdev->dev, "pcs 0x%x->0x%x\n",
+			   orig_pcs, pcs);
+	}
+
 	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;

--------------010802030703000006030709--
