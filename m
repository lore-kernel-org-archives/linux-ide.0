From: Tejun Heo <htejun@gmail.com>
Subject: Re: gigabyte iRam not seen by linux
Date: Sat, 11 Mar 2006 12:31:43 +0900
Message-ID: <20060311033143.GA12866@htj.dyndns.org>
References: <20060310013604.1acac722.pegasus@nerv.eu.org> <4411BCB6.5080108@gmail.com> <44122FBD.9000909@tw.ibm.com> <20060311034630.4c12cf83.pegasus@nerv.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:26101 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752336AbWCKDby (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 22:31:54 -0500
Received: by pproxy.gmail.com with SMTP id d42so515322pyd
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 19:31:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060311034630.4c12cf83.pegasus@nerv.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jure Pe??ar <pegasus@nerv.eu.org>
Cc: linux-ide@vger.kernel.org, albertl@mail.com

Hello, Jure.

First of all, please, don't drop To/Cc.

On Sat, Mar 11, 2006 at 03:46:30AM +0100, Jure Pe??ar wrote:
> 
> > Tejun Heo wrote:
> > > After booting with such kernel, please post the result of dmesg.
> 
> This is the relevant part of dmesg with 2.6.16-rc5:
> 
> SCSI subsystem initialized
> libata version 1.20 loaded.
> sata_nv 0000:00:0e.0: version 0.8
> ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
> GSI 16 sharing vector 0xB1 and IRQ 16
> ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LSA0] -> GSI 23 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:00:0e.0 to 64
> ata_device_add: ENTER
> ata_host_add: ENTER
> ata_port_start: prd alloc, virt ffff81007a0c1000, dma 7a0c1000
> ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE482 bmdma 0xE000 irq 16
> ata_host_add: ENTER
> ata_port_start: prd alloc, virt ffff81007a740000, dma 7a740000
> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE082 bmdma 0xE008 irq 16
> ata_device_add: probe begin
> ata_device_add: ata1: probe begin
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> ata_bus_reset: ENTER, host 1, port 0
> ata_bus_softreset: ata1: bus reset via SRST
> ata_bus_reset: EXIT
> ata_dev_identify: ENTER/EXIT (host 1, dev 0) -- nodev
> ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev

Seems like iRam isn't reporting proper class signature.

> ata_device_add: ata1: probe end
> scsi0 : sata_nv
> ata_device_add: ata2: probe begin
> ata2: SATA link down (SStatus 0)
> ata_device_add: ata2: probe end
> 
> 
> On Sat, 11 Mar 2006 10:02:37 +0800
> Albert Lee <albertcc@tw.ibm.com> wrote:
> 
> > 
> > This pseudo SATA drive looks interesting. There is a SATA connector
> > on the PCI adapter. At the first glance, I thought it is a new
> > SATA adapter, but it is not.
> > (http://www6.tomshardware.com/2005/09/07/can_gigabyte/page2.html)
> 
> PCI just provides the power to charge the battery. The memory controller and sata interface is implemented in the fpga. It's entirely possible that gigabyte did take some shortcuts here ... at least that's my understanding of the info above :)
> But if the bios and windows see the device and know how to use it ... 

Can you apply the following patch and try again?

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5f1d758..c6b0a9f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -827,7 +827,9 @@ unsigned int ata_dev_classify(const stru
 	}
 
 	DPRINTK("unknown device\n");
-	return ATA_DEV_UNKNOWN;
+	/*return ATA_DEV_UNKNOWN;*/
+	DPRINTK("XXX faking ATA_DEV_ATA\n");
+	return ATA_DEV_ATA;
 }
 
 /**
@@ -862,6 +864,10 @@ static u8 ata_dev_try_classify(struct at
 	ap->ops->tf_read(ap, &tf);
 	err = tf.feature;
 
+	DPRINTK("dev=%d, TF %02x %02x:%02x:%02x:%02x:%02x %02x %02x\n",
+		device, tf.ctl, tf.feature, tf.nsect,
+		tf.lbal, tf.lbam, tf.lbah, tf.device, tf.command);
+
 	dev->class = ATA_DEV_NONE;
 
 	/* see if device passed diags */
@@ -2134,6 +2140,8 @@ void ata_bus_reset(struct ata_port *ap)
 	if (dev1)
 		devmask |= (1 << 1);
 
+	DPRINTK("devmask=0x%x\n", devmask);
+
 	/* select device 0 again */
 	ap->ops->dev_select(ap, 0);
 
