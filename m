From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] libata: disable interrupts before soft reset
Date: Fri, 31 Mar 2006 18:04:06 +0800
Message-ID: <442CFE96.1040203@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:18081 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932067AbWCaKEP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:15 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2VA49ig022340
	for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 05:04:09 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2VA0uSJ033252
	for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 03:00:56 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2VA49ds000613
	for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 03:04:09 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

Changes:
- add ata_irq_off() to libata.h
- call ata_irq_off() to disable the interrupt before soft reset

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

When testing an old 1996 Acer 8x CD-ROM drive (CD-787E), an
interrupt is generated in ata_devchk(), right after the device is selected.
(The unhandled irq cause the IRQ 10 to be disabled.)

Disabling interrupts before doing soft reset fixes the problem.
However, this problem is only seen on the specific CD-ROM drive.
So, don't know whether the fix is necessary.

Patch against upstream (8b316a3973f05e572b4edeeda9072987f6bbaa44).
For your review, thanks.

Albert
===================================================
(Attached detailed dmesg for your reference)
pata_pdc2027x 0000:02:05.0: version 0.74
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
pata_pdc2027x 0000:02:05.0: PLL input clock 16718 kHz
ata3: PATA max UDMA/133 cmd 0x989517C0 ctl 0x98951FDA bmdma 0x98951000 irq 10
ata4: PATA max UDMA/133 cmd 0x989515C0 ctl 0x98951DDA bmdma 0x98951008 irq 10
checking device 0
selecting checking device 0
irq 10: nobody cared (try booting with the "irqpoll" option)
 <78139444> __report_bad_irq+0x24/0x7f   <78139516> note_interrupt+0x77/0x21d
 <78138f0d> handle_IRQ_event+0x2e/0x5a   <78139003> __do_IRQ+0xca/0xd7
 <78104708> do_IRQ+0x53/0x8b  
 =======================
 <78102f4e> common_interrupt+0x1a/0x20   <7811e589> __do_softirq+0x37/0x95
 <7810478f> do_softirq+0x4f/0x60  
 =======================
 <7811e475> irq_exit+0x37/0x39   <7810470f> do_IRQ+0x5a/0x8b
 <78102f4e> common_interrupt+0x1a/0x20   <98884ce0> ata_altstatus+0x29/0x2d [libata]
 <9887e9d6> ata_std_dev_select+0x23/0x47 [libata]   <9887ea2c> ata_devchk+0x32/0x135 [libata]
 <9887fde7> ata_std_softreset+0x52/0x11a [libata]   <9887fd95> ata_std_softreset+0x0/0x11a [libata]
 <9887fac5> ata_std_postreset+0x0/0x12a [libata]   <9887d45d> do_probe_reset+0x2b/0x82 [libata]
 <9887fd95> ata_std_softreset+0x0/0x11a [libata]   <9887fac5> ata_std_postreset+0x0/0x12a [libata]
 <9887d4ee> ata_drive_probe_reset+0x3a/0x7d [libata]   <989425ae> pdc2027x_probe_reset+0x60/0x65 [pata_pdc2027x]
 <9887fac5> ata_std_postreset+0x0/0x12a [libata]   <98881b84> ata_device_add+0x428/0x648 [libata]
 <98942449> pdc2027x_init_one+0x29f/0x348 [pata_pdc2027x]   <781de777> pci_device_probe+0x40/0x5b
 <7823fe24> driver_probe_device+0x3b/0xb0   <7823ff88> __driver_attach+0x82/0x84
 <7823f457> bus_for_each_dev+0x39/0x57   <7823fd16> driver_attach+0x16/0x1a
 <7823ff06> __driver_attach+0x0/0x84   <7823f71c> bus_add_driver+0x63/0x110
 <782402da> driver_register+0x41/0xb4   <781de3c8> __pci_register_driver+0x65/0x86
 <781317af> sys_init_module+0x114/0x1731   <9887d79a> ata_port_start+0x0/0x7e [libata]
 <78102d1b> sysenter_past_esp+0x54/0x75  
handlers:
[<98881f1e>] (ata_interrupt+0x0/0x282 [libata])
Disabling IRQ #10
writing pattern 1 device 0
writing pattern 2 device 0
writing pattern 3 device 0
reading pattern 4 device 0
device found 1
checking device 1
selecting checking device 1
writing pattern 1 device 1
writing pattern 2 device 1
writing pattern 3 device 1
reading pattern 4 device 1
device found 1
select dev 0

======================================

diff -Nrup upstream0/drivers/scsi/libata-core.c reset_irq_off/drivers/scsi/libata-core.c
--- upstream0/drivers/scsi/libata-core.c	2006-03-31 13:33:15.000000000 +0800
+++ reset_irq_off/drivers/scsi/libata-core.c	2006-03-31 17:12:28.000000000 +0800
@@ -2069,6 +2069,10 @@ void ata_bus_reset(struct ata_port *ap)
 
 	DPRINTK("ENTER, host %u, port %u\n", ap->id, ap->port_no);
 
+	/* disable interrupts */
+	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+		ata_irq_off(ap);
+
 	/* determine if device 0/1 are present */
 	if (ap->flags & ATA_FLAG_SATA_RESET)
 		dev0 = 1;
@@ -2199,6 +2203,10 @@ int ata_std_softreset(struct ata_port *a
 		goto out;
 	}
 
+	/* disable interrupts */
+	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+		ata_irq_off(ap);
+
 	/* determine if device 0/1 are present */
 	if (ata_devchk(ap, 0))
 		devmask |= (1 << 0);
diff -Nrup upstream0/include/linux/libata.h reset_irq_off/include/linux/libata.h
--- upstream0/include/linux/libata.h	2006-03-31 13:33:24.000000000 +0800
+++ reset_irq_off/include/linux/libata.h	2006-03-31 17:07:04.000000000 +0800
@@ -840,6 +840,35 @@ static inline u8 ata_irq_on(struct ata_p
 	return tmp;
 }
 
+/**
+ *	ata_irq_off - Disable interrupts on a port.
+ *	@ap: Port on which interrupts are disabled.
+ *
+ *	Disable interrupts on a legacy IDE device using MMIO or PIO,
+ *	wait for idle, clear any pending interrupts.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
+static inline u8 ata_irq_off(struct ata_port *ap)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 tmp;
+
+	ap->ctl |= ATA_NIEN;
+	ap->last_ctl = ap->ctl;
+
+	if (ap->flags & ATA_FLAG_MMIO)
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
+	else
+		outb(ap->ctl, ioaddr->ctl_addr);
+	tmp = ata_wait_idle(ap);
+
+	ap->ops->irq_clear(ap);
+
+	return tmp;
+}
 
 /**
  *	ata_irq_ack - Acknowledge a device interrupt.



