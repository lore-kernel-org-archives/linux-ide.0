From: "Trent George" <trent@norwalkdist.com>
Subject: Re: dvd-r detection problem with port multiplier
Date: Tue, 26 Sep 2006 23:58:20 -0700
Message-ID: <KMS--2023338046-2588@mail.norwalkdist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-64-165-178-101.dsl.lsan03.pacbell.net ([64.165.178.101]:47631
	"EHLO mail.norwalkdist.com") by vger.kernel.org with ESMTP
	id S965400AbWI0G5u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Sep 2006 02:57:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


sorry to be a pest with this.
Hopefully this helps though..

> Can you please test the following patch?  The spec says that clearing
> PMP status should be followed by port initialization and I missed that
> before.
> 
> Index: work1/drivers/scsi/sata_sil24.c
> ===================================================================
> --- work1.orig/drivers/scsi/sata_sil24.c	2006-09-27 11:35:00.000000000 +0900
> +++ work1/drivers/scsi/sata_sil24.c	2006-09-27 11:35:04.000000000 +0900
> @@ -594,15 +594,17 @@ static int sil24_init_port(struct ata_po
>  	struct sil24_port_priv *pp = ap->private_data;
>  	u32 tmp;
>  
> +	if (ap->nr_pmp_links) {
> +		/* clear PMP error status */
> +		sil24_clear_pmp(ap);
> +	}
> +
>  	writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
>  	ata_wait_register(port + PORT_CTRL_STAT,
>  			  PORT_CS_INIT, PORT_CS_INIT, 10, 100);
>  	tmp = ata_wait_register(port + PORT_CTRL_STAT,
>  				PORT_CS_RDY, 0, 10, 100);
>  
> -	/* clear PMP error status */
> -	sil24_clear_pmp(ap);
> -
>  	if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY) {
>  		pp->do_port_rst = 1;
>  		ap->link.eh_context.i.action |= ATA_EH_HARDRESET;
> @@ -916,12 +918,12 @@ static void sil24_irq_clear(struct ata_p
>  static void sil24_pmp_attach(struct ata_port *ap)
>  {
>  	sil24_config_pmp(ap, 1);
> -	sil24_clear_pmp(ap);
> +	sil24_init_port(ap);
>  }
>  
>  static void sil24_pmp_detach(struct ata_port *ap)
>  {
> -	sil24_clear_pmp(ap);
> +	sil24_init_port(ap);
>  	sil24_config_pmp(ap, 0);
>  }
>  
> 

that patch did not work for me.

this folling patch did work for me. (I moved the one line fix
into the sil24_init_port function, compared to before)

I wonder if the processer speed makes a difference ?
I'am on a intel 820 D dual core 2.8ghz

I believe the problem is based on a failing PRB_CTRL_SRST, 
while the PORT_CS_INIT is still in progress.
Even though the PORT_CS_RDY comes ready quickly.
I think you can not send another pmp command until the last 
one completes (seems the init is slow on some bridgeboards)
the plextor finsihed in 12/250 seconds, the pioneer in 84/250 sec
The other option is a msleep(1000); in the do_softrest after
the init_port.

It seems you can also monitor the PORT_SACTIVE register with a 
ata_wait_register(port + PORT_SACTIVE, 1, 1, 10, 1000);
to do the same thing.

all in all, it is VERY hard to fix without the same revision
hardware, as if you can't duplicate it, you cant fix it.
The spec does not really tell you what will happen on a init
while in pmp mode. it shows a different enumeration method
than the driver uses for pmp ...

Plus the plextor is very fast, and one slow device, messes it
up for all the other devices.

it seems this may not be optimum on non-pmp hardware though.
my vote would be for the msleep for compatability

Index: drivers/scsi/sata_sil24.c
===================================================================
--- drivers/scsi/sata_sil24.c.orig   2006-09-26 20:34:03.000000000 -0700
+++ drivers/scsi/sata_sil24.c        2006-09-26 21:46:39.000000000 -0700
@@ -595,15 +595,20 @@
        struct sil24_port_priv *pp = ap->private_data;
        u32 tmp;

+       if (ap->nr_pmp_links) {
+               /* clear PMP error status */
+               sil24_clear_pmp(ap);
+       }
+
        writel(PORT_CS_INIT, port + PORT_CTRL_STAT);
        ata_wait_register(port + PORT_CTRL_STAT,
                          PORT_CS_INIT, PORT_CS_INIT, 10, 100);
        tmp = ata_wait_register(port + PORT_CTRL_STAT,
                                PORT_CS_RDY, 0, 10, 100);

-       /* clear PMP error status */
-       sil24_clear_pmp(ap);
-
+       ata_wait_register(port + PORT_CTRL_STAT,
+                               0x1f0000, 0x1f0000, 10, 1000);
+
        if ((tmp & (PORT_CS_INIT | PORT_CS_RDY)) != PORT_CS_RDY) {
                pp->do_port_rst = 1;
                ap->link.eh_context.i.action |= ATA_EH_HARDRESET;
@@ -917,12 +922,12 @@
 static void sil24_pmp_attach(struct ata_port *ap)
 {
        sil24_config_pmp(ap, 1);
-       sil24_clear_pmp(ap);
+       sil24_init_port(ap);
 }

 static void sil24_pmp_detach(struct ata_port *ap)
 {
-       sil24_clear_pmp(ap);
+       sil24_init_port(ap);
        sil24_config_pmp(ap, 0);
 }


here is a dmesg output of the bad and good version
the bad version, just cycles through reseting seamingly "forever"

bad:
------------
sata_sil24 0000:01:00.0: version 0.3
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:01:00.0 to 64
ata5: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 169
ata6: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 169
scsi4 : sata_sil24
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : sata_sil24
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
ata6.00: hard resetting port
ata6.00: SATA link down (SStatus 0 SControl 310)
ata6.01: hard resetting port
ata6.01: SATA link down (SStatus 0 SControl 300)
ata6.02: hard resetting port
ata6.02: softreset failed (SRST command error)
ata6.02: follow-up softreset failed, retrying in 5 secs
ata6.02: hard resetting port
ata6.03: hard resetting port
ata6.03: COMRESET failed (errno=-16)
ata6.03: hardreset failed, retrying in 5 secs
ata6.03: hard resetting port
ata6.03: COMRESET failed (errno=-16)
ata6.03: reset failed, giving up
ata6.15: hard resetting port
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: hard resetting port
ata6.00: SATA link down (SStatus 0 SControl 310)
ata6.01: hard resetting port
ata6.01: SATA link down (SStatus 0 SControl 300)
ata6.02: hard resetting port
ata6.02: softreset failed (SRST command error)
ata6.02: follow-up softreset failed, retrying in 5 secs
ata6.02: hard resetting port
ata6.03: hard resetting port
ata6.03: COMRESET failed (errno=-16)
ata6.03: hardreset failed, retrying in 5 secs
ata6.03: hard resetting port
ata6.03: COMRESET failed (errno=-16)
ata6.03: reset failed, giving up
ata6.03: failed to recover link after 2 tries, disabling
ata6: failed to recover PMP, retrying in 5 secs
ata6.15: hard resetting port
ata6: controller in dubious state, performing PORT_RST
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting port
ata6.00: SATA link down (SStatus 0 SControl 310)
ata6.01: hard resetting port
ata6.01: SATA link down (SStatus 0 SControl 300)
ata6.02: hard resetting port
ata6.02: softreset failed (SRST command error)
ata6.02: follow-up softreset failed, retrying in 5 secs
ata6.02: hard resetting port
ata6.04: hard resetting port
ata6.04: COMRESET failed (errno=-16)
ata6.04: hardreset failed, retrying in 5 secs
ata6.04: hard resetting port
ata6.04: COMRESET failed (errno=-16)
ata6.04: reset failed, giving up
ata6.15: hard resetting port
ata6: controller in dubious state, performing PORT_RST
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting port
ata6.00: SATA link down (SStatus 0 SControl 310)
ata6.01: hard resetting port
ata6.01: SATA link down (SStatus 0 SControl 300)
ata6.02: hard resetting port
ata6.02: softreset failed (SRST command error)
ata6.02: follow-up softreset failed, retrying in 5 secs
ata6.02: hard resetting port
ata6.04: hard resetting port
ata6.04: COMRESET failed (errno=-16)
ata6.04: hardreset failed, retrying in 5 secs
ata6.04: hard resetting port
ata6.04: COMRESET failed (errno=-16)
ata6.04: reset failed, giving up
ata6.04: failed to recover link after 2 tries, disabling
ata6: failed to recover PMP, retrying in 5 secs
ata6.15: hard resetting port
ata6: controller in dubious state, performing PORT_RST
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting port
ata6.00: SATA link down (SStatus 0 SControl 310)
ata6.01: hard resetting port
ata6.01: SATA link down (SStatus 0 SControl 300)
ata6.02: hard resetting port
ata6.02: softreset failed (SRST command error)
ata6.02: follow-up softreset failed, retrying in 5 secs
ata6.02: hard resetting port
ata6.15: failed to read PMP_GSCR_ERROR
ata6: failed to recover PMP, retrying in 5 secs
ata6.15: hard resetting port
ata6: controller in dubious state, performing PORT_RST
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting port
ata6.00: SATA link down (SStatus 0 SControl 310)
ata6.01: hard resetting port
ata6.01: SATA link down (SStatus 0 SControl 300)
ata6.02: hard resetting port
ata6.02: softreset failed (SRST command error)
ata6.02: follow-up softreset failed, retrying in 5 secs
ata6.02: hard resetting port
ata6.15: failed to read PMP_GSCR_ERROR
ata6: failed to recover PMP, retrying in 5 secs
ata6.15: hard resetting port
ata6: controller in dubious state, performing PORT_RST
ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata6.00: hard resetting port
ata6.00: SATA link down (SStatus 0 SControl 310)
ata6.01: hard resetting port
ata6.01: SATA link down (SStatus 0 SControl 300)
ata6.02: hard resetting port
ata6.02: softreset failed (SRST command error)
ata6.02: follow-up softreset failed, retrying in 5 secs
ata6.02: hard resetting port
ata6.15: failed to read PMP_GSCR_ERROR
ata6: failed to recover PMP after 5 tries, giving up
ata6.15: Port Multiplier detaching
ata6.00: disabled
ata6: EH pending after completion, repeating EH (cnt=4)
ata6: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x1
ata6: (irq_stat 0x08040800, SDB notify)
ata6: EH complete

good:
------------
sata_sil24 0000:01:00.0: version 0.3
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:01:00.0 to 64
ata7: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 169
ata8: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 169
scsi6 : sata_sil24
ata7: SATA link down (SStatus 0 SControl 300)
scsi7 : sata_sil24
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
ata8.00: hard resetting port
ata8.00: SATA link down (SStatus 0 SControl 310)
ata8.01: hard resetting port
ata8.01: SATA link down (SStatus 0 SControl 300)
ata8.02: hard resetting port
ata8.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.03: hard resetting port
ata8.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.04: hard resetting port
ata8.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.02: ATAPI, max UDMA/66
ata8.02: configured for UDMA/66
ata8.03: ATAPI, max UDMA/66
ata8.03: configured for UDMA/66
ata8.04: ATAPI, max UDMA/66
ata8.04: applying bridge limits
ata8.04: qc timeout (cmd 0xef)
ata8.04: failed to set xfermode (err_mask=0x104)
ata8.04: limiting speed to UDMA/44
ata8: failed to recover some devices, retrying in 5 secs
ata8.04: hard resetting port
ata8.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.04: configured for UDMA/44
ata8: EH complete
ata8.02: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata8.02: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata8.15: hard resetting port
ata8: controller in dubious state, performing PORT_RST
ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata8.00: hard resetting port
ata8.00: SATA link down (SStatus 0 SControl 310)
ata8.01: hard resetting port
ata8.01: SATA link down (SStatus 0 SControl 300)
ata8.02: hard resetting port
ata8.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.03: hard resetting port
ata8.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.04: hard resetting port
ata8.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.02: failed to set xfermode (err_mask=0x101)
ata8.02: limiting speed to UDMA/44
ata8.03: configured for UDMA/66
ata8.04: configured for UDMA/44
ata8: failed to recover some devices, retrying in 5 secs
ata8.02: hard resetting port
ata8.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.02: configured for UDMA/44
ata8: EH pending after completion, repeating EH (cnt=4)
ata8.04: exception Emask 0x2 SAct 0x0 SErr 0x0 action 0x2
ata8.04: (irq_stat 0x00060002, protocol mismatch)
ata8.04: soft resetting port
ata8.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata8.04: configured for UDMA/44
ata8: EH complete
  Vendor: _NEC      Model: DVD_RW ND-3550A   Rev: 1.G3
  Type:   CD-ROM                             ANSI SCSI revision: 05
 7:0:2:0: Attached scsi generic sg1 type 5
  Vendor: PLEXTOR   Model: DVDR   PX-755A    Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 05
 7:0:3:0: Attached scsi generic sg2 type 5
  Vendor: PIONEER   Model: DVD-RW  DVR-111D  Rev: 1.23
  Type:   CD-ROM                             ANSI SCSI revision: 05
 7:0:4:0: Attached scsi generic sg3 type 5
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 7:0:2:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr 7:0:3:0: Attached scsi CD-ROM sr1
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr 7:0:4:0: Attached scsi CD-ROM sr2

not to get off topic, but

this was from SiI-DS-0113_3124-1_full.pdf

5.4.6 Interrupts and Command Completion

talked about the multi interrupt lines. 

Trent

