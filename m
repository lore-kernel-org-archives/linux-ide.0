From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_via: ata1 failed to respond
Date: Thu, 25 Mar 2004 12:03:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <406310CB.4010404@pobox.com>
References: <20040325164441.GP1756@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040325164441.GP1756@master.mivlgu.local>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Sergey Vlasov wrote:
> Hello!
> 
> I have another report about nonworking sata_via in 2.4.25-libata9
> plus the probing bug fix (so sata_via was identical to the version
> in 2.4.25-libata12).  The drive was not recognised with these
> messages:
> 
> libata version 1.02 loaded.
> sata_via version 0.20
> sata_via(00:0f.0): routed to hard irq line 10
> ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xA400 irq 20
> ata2: SATA max UDMA/133 cmd 0xB000 ctl 0xA802 bmdma 0xA408 irq 20
> ata1 is slow to respond, please be patient
> ata1 failed to respond (30 secs)
> 
> The hardware was: ASUS A7V600 motherboard, Seagate ST3120026AS hard
> drive.  2.4.25-libata1 worked fine.
> 
> acpi=off and noapic options did not help.  However, replacing
> sata_via.c with the version from 2.4.25-libata1 (with removed
> ".phy_config = pata_phy_config" line to make it compile) allowed the
> detection to succeed.
> 
> I tried to replace ATA_FLAG_SATA_RESET with ATA_FLAG_SRST in the new
> driver - with this change detection also succeeds:
> 
> --- kernel-source-2.4.25/drivers/scsi/sata_via.c.via-srst	2004-03-24 16:27:50 +0300
> +++ kernel-source-2.4.25/drivers/scsi/sata_via.c	2004-03-25 18:51:19 +0300
> @@ -203,7 +203,7 @@ static int svia_init_one (struct pci_dev
>  	INIT_LIST_HEAD(&probe_ent->node);
>  	probe_ent->pdev = pdev;
>  	probe_ent->sht = &svia_sht;
> -	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
> +	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SRST |
>  				ATA_FLAG_NO_LEGACY;
>  	probe_ent->port_ops = &svia_sata_ops;
>  	probe_ent->n_ports = 2;
> 
> Here is the full dmesg output from boot with the above change:


Man, you are full of useful bug reports ;-)

Thanks much for testing.  It looks like there are still some bugs in my 
SATA reset routine, since it was hoped that that code works universally.

I'll try to come up with an alternate patch that fixes sata_phy_reset(). 
  If I fail, we will use your patch as the fallback.

	Jeff
