From: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Subject: Re: Hotplug drives on vt8251 with ahci module
Date: Sat, 24 Jun 2006 20:02:53 +0200
Message-ID: <1151172173.4307.0.camel@anja>
References: <200606210942.33578.boac@wanadoo.nl> <44995139.30808@gmail.com>
	 <200606221500.25056.boac@wanadoo.nl>  <449B6583.1090303@gmail.com>
Reply-To: aalderd.boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp04.wanadoo.nl ([194.134.35.144]:42527 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S1750997AbWFXSA0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 14:00:26 -0400
In-Reply-To: <449B6583.1090303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: boac@wanadoo.nl, linux-ide@vger.kernel.org

The dmesg will say enough I think:

libata version 1.30 loaded.
ahci 0000:00:0f.0: version 1.3
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> GSI 10 (level,
low) -> IRQ 10
ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA
mode
ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum part
ata1: SATA max UDMA/133 cmd 0xE0488D00 ctl 0x0 bmdma 0x0 irq 10
ata2: SATA max UDMA/133 cmd 0xE0488D80 ctl 0x0 bmdma 0x0 irq 10
ata3: SATA max UDMA/133 cmd 0xE0488E00 ctl 0x0 bmdma 0x0 irq 10
ata4: SATA max UDMA/133 cmd 0xE0488E80 ctl 0x0 bmdma 0x0 irq 10
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: ST3808110AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
ReiserFS: sda5: found reiserfs format "3.6" with standard journal
ReiserFS: sda5: using ordered data mode
ReiserFS: sda5: journal params: device sda5, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda5: checking transaction log (sda5)
ReiserFS: sda5: Using r5 hash to sort names
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
ata2: exception Emask 0x10 SAct 0x0 SErr 0x30000 action 0x2 frozen
ata2: (irq_stat 0x04400000, PHY RDY changed)
ata2: soft resetting port
ata2: SATA link down (SStatus 1 SControl 300)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 300)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link down (SStatus 0 SControl 300)
ata2.00: disabled
ata2: EH complete
ata2.00: detaching (SCSI 1:0:0:0)
ata2: exception Emask 0x10 SAct 0x0 SErr 0x4060000 action 0x2 frozen
ata2: (irq_stat 0x00000040, connection status changed)
ata2: waiting for device to spin up (8 secs)
ata2: soft resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: softreset failed (device not ready)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: softreset failed (device not ready)
ata2: follow-up softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient
ata2: port failed to respond (30 secs)
ata2: softreset failed (device not ready)
ata2: reset failed, giving up
ata2: EH complete
ata1.00: disabled
ACPI: PCI interrupt for device 0000:00:0f.0 disabled

Aalderd.

On Fri, 2006-06-23 at 12:52 +0900, Tejun Heo wrote:
> [CC'ing Bastiaan Jacques]
> 
> Hello, Aalderd.
> 
> Aalderd Bouwman wrote:
> > The same turn on/off action with rmmod ahci will work properly I think:
> > (I have test that action 3 times)
> 
> Great.
> 
> > As you see the disconnect of a drive is detected.
> > Is the message: 'failed to recover some devices' correct?
> > This message apears twice.
> 
> AFAICS, libata EH is behaving as expected.  The problem, again, is that 
> more often than not, the via controller seems to lock up after certain 
> events.  In the message you just posted, ata14 fails to recover after 
> power-on.
> 
> Hmmm.. Looking at the log, it occurs to me that it might be because the 
> controller can't receive D2H FIS after hardreset.  Can you try the 
> attached patch?
> 
> Bastiaan, I'm shooting in the dark, so please don't hesitate to step in.
> 
> plain text document attachment (patch)
> diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
> index e261b37..fe12927 100644
> --- a/drivers/scsi/ahci.c
> +++ b/drivers/scsi/ahci.c
> @@ -164,6 +164,7 @@ enum {
>  
>  	/* ap->flags bits */
>  	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
> +	AHCI_FLAG_NO_HRST_D2H_FIS	= (1 << 25),
>  };
>  
>  struct ahci_cmd_hdr {
> @@ -277,7 +278,8 @@ static const struct ata_port_info ahci_p
>  		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>  				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
>  				  ATA_FLAG_SKIP_D2H_BSY |
> -				  AHCI_FLAG_RESET_NEEDS_CLO,
> +				  AHCI_FLAG_RESET_NEEDS_CLO |
> +				  AHCI_FLAG_NO_HRST_D2H_FIS,
>  		.pio_mask	= 0x1f, /* pio0-4 */
>  		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
>  		.port_ops	= &ahci_ops,
> @@ -703,14 +705,18 @@ static int ahci_hardreset(struct ata_por
>  	tf.command = 0xff;
>  	ata_tf_to_fis(&tf, d2h_fis, 0);
>  
> -	rc = sata_std_hardreset(ap, class);
> -
> -	ahci_start_engine(ap);
> +	if (!(ap->flags & AHCI_FLAG_NO_HRST_D2H_FIS)) {
> +		rc = sata_std_hardreset(ap, class);
> +		ahci_start_engine(ap);
>  
> -	if (rc == 0 && ata_port_online(ap))
> -		*class = ahci_dev_classify(ap);
> -	if (*class == ATA_DEV_UNKNOWN)
> -		*class = ATA_DEV_NONE;
> +		if (rc == 0 && ata_port_online(ap))
> +			*class = ahci_dev_classify(ap);
> +		if (*class == ATA_DEV_UNKNOWN)
> +			*class = ATA_DEV_NONE;
> +	} else {
> +		rc = sata_do_hardreset(ap);
> +		ahci_start_engine(ap);
> +	}
>  
>  	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
>  	return rc;
> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 89c3fbe..9d6ed7e 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -2517,6 +2517,46 @@ int sata_phy_resume(struct ata_port *ap,
>  	return sata_phy_debounce(ap, params);
>  }
>  
> +int sata_do_hardreset(struct ata_port *ap)
> +{
> +	u32 scontrol;
> +	int rc;
> +
> +	if (sata_set_spd_needed(ap)) {
> +		/* SATA spec says nothing about how to reconfigure
> +		 * spd.  To be on the safe side, turn off phy during
> +		 * reconfiguration.  This works for at least ICH7 AHCI
> +		 * and Sil3124.
> +		 */
> +		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
> +			return rc;
> +
> +		scontrol = (scontrol & 0x0f0) | 0x302;
> +
> +		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
> +			return rc;
> +
> +		sata_set_spd(ap);
> +	}
> +
> +	/* issue phy wake/reset */
> +	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
> +		return rc;
> +
> +	scontrol = (scontrol & 0x0f0) | 0x301;
> +
> +	if ((rc = sata_scr_write_flush(ap, SCR_CONTROL, scontrol)))
> +		return rc;
> +
> +	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
> +	 * 10.4.2 says at least 1 ms.
> +	 */
> +	msleep(1);
> +
> +	/* bring phy back */
> +	return sata_phy_resume(ap, sata_deb_timing_eh);
> +}
> +
>  static void ata_wait_spinup(struct ata_port *ap)
>  {
>  	struct ata_eh_context *ehc = &ap->eh_context;
> @@ -2670,44 +2710,16 @@ int ata_std_softreset(struct ata_port *a
>   */
>  int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
>  {
> -	u32 scontrol;
>  	int rc;
>  
>  	DPRINTK("ENTER\n");
>  
> -	if (sata_set_spd_needed(ap)) {
> -		/* SATA spec says nothing about how to reconfigure
> -		 * spd.  To be on the safe side, turn off phy during
> -		 * reconfiguration.  This works for at least ICH7 AHCI
> -		 * and Sil3124.
> -		 */
> -		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
> -			return rc;
> -
> -		scontrol = (scontrol & 0x0f0) | 0x302;
> -
> -		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
> -			return rc;
> -
> -		sata_set_spd(ap);
> -	}
> -
> -	/* issue phy wake/reset */
> -	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
> -		return rc;
> -
> -	scontrol = (scontrol & 0x0f0) | 0x301;
> -
> -	if ((rc = sata_scr_write_flush(ap, SCR_CONTROL, scontrol)))
> +	/* reset the phy */
> +	rc = sata_do_hardreset(ap);
> +	if (rc) {
> +		ata_port_printk(ap, KERN_ERR, "COMRESET failed (%d)\n", rc);
>  		return rc;
> -
> -	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
> -	 * 10.4.2 says at least 1 ms.
> -	 */
> -	msleep(1);
> -
> -	/* bring phy back */
> -	sata_phy_resume(ap, sata_deb_timing_eh);
> +	}
>  
>  	/* TODO: phy layer with polling, timeouts, etc. */
>  	if (ata_port_offline(ap)) {
> @@ -5833,6 +5845,7 @@ EXPORT_SYMBOL_GPL(sata_phy_resume);
>  EXPORT_SYMBOL_GPL(sata_phy_reset);
>  EXPORT_SYMBOL_GPL(__sata_phy_reset);
>  EXPORT_SYMBOL_GPL(ata_bus_reset);
> +EXPORT_SYMBOL_GPL(sata_do_hardreset);
>  EXPORT_SYMBOL_GPL(ata_std_prereset);
>  EXPORT_SYMBOL_GPL(ata_std_softreset);
>  EXPORT_SYMBOL_GPL(sata_std_hardreset);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 6b3c3af..533ed44 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -631,6 +631,7 @@ extern void ata_bus_reset(struct ata_por
>  extern int sata_set_spd(struct ata_port *ap);
>  extern int sata_phy_debounce(struct ata_port *ap, const unsigned long *param);
>  extern int sata_phy_resume(struct ata_port *ap, const unsigned long *param);
> +extern int sata_do_hardreset(struct ata_port *ap);
>  extern int ata_std_prereset(struct ata_port *ap);
>  extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
>  extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
> diff --git a/patches/series b/patches/series
> index 9415c25..84b70e4 100644

