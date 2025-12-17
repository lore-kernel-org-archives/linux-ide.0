Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DB42D595D
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2025 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949940; cv=none; b=LTlhpwQKdTLabr15EFcAqizmnRoGbq28dlFTLrsDNeW2epUlvdC3hOb6+XXSDIiKDaJ9rziHa30spMgRAd4aAU8OyXuq0Abg3cZdtYyTyjn65m3UXKUsAZ1EFUB6hfHbms7rSPCMwZGuSKghmNp12+QQH1N74x2o38UnOqFnrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949940; c=relaxed/simple;
	bh=cjtcOIjfPasLUrjnEfpiLPRNrNF2c2L1e43dsfBQOI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEGRetkbCn2fof0+3rSJS9jvLxsoq86gMGBXxHrubI+b88jDtxq87mJpwxhOyWrPytIYOYgsKEXzhV6FQiFy5bqmBJUnT7Q/ZlpcxZ9YDGok+x/bUaYOQQ+8LwYfU7/U2rPpZ5hGfZx+BMoGhw8rAdx3+GbtthG5nuWxyT+p9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUoZOE8F; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUoZOE8F"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a1360e1392so15227475ad.2
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2025 21:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765949937; x=1766554737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqwb4JP1a3YO8kXm5rBSjLSrExzpAyl4F1TJfTygODw=;
        b=HUoZOE8FfooPU0Mg6B7HUeuhMwhpQ+3aHOLBD5DfxSzJ1ZQdchFzRlV4AXxz4zapeY
         bwaalNhPMWcN/ikbxnzbmtBik9qokbPJ08GcDs1gFvdEASKAuTQg8k1bc/vanQPAonHY
         ZiC4FW3v8EuOxaJrPf+DhFFIk6JMrs8LIP65PD3A5eUa1WlW+2LwQbuvB1ya+yA/ZvTx
         /LvM7UPVACUg+egQ7ntLJMRrpjppiDZ7NgMvRpKEQEY4RmZTOKFZ77TUqu0cwE0ax0Le
         Tc3sYegMenWkK+JxzCb0zo3T+5uMnn4XgDJnik7DCq28qPtiMsUrxHC1CDhSov66go2S
         aJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949937; x=1766554737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lqwb4JP1a3YO8kXm5rBSjLSrExzpAyl4F1TJfTygODw=;
        b=vARLKmjOoE6PC8y0aftu6f5VpY06xFxzPfN9QUt+uv5RqMMjcHWMlrOd2C36AIlrK7
         iIcxdIisPTyhbtF0/wgI0beWp0CxgPnsZdteRxez9373zQOB0A0Ktn/9xsxfVcyUhPEc
         9hPdpJO23shcRUHVxnN7OmExS1jOaEVqsw2PPLeBw/xbqAGyqU0hUi4i+xIDOq0NiX6x
         zpWzQz+opM8b83ei0jLsQZheD1lR3Qv875OdWgzTN7lfO6L6Faz2rCFZVAJ3B5x8xYvB
         5essjGQNX4QR4jf2o6X3o1w2/cj21XYnzarNvlTKT5gbhK0OtZ3m5ce/jmaIGcugIf/A
         9awQ==
X-Gm-Message-State: AOJu0YxZHjzuE/DGjA7WxKBUPNBOcUy5Kivkl2fvt538XpLm8DNXFTlY
	shEQggIVeD9tMusXub8yhPtVT+3eeK9RtEXy2WwBQYHwKbvUlWMUi4imDwgcOaiOcWA=
X-Gm-Gg: AY/fxX6YAE2Plz2h4zUdHR9VZLjWwTUUPSiJ9Q0gq5rR5wg7Fz/S0s+ncfbURY07FpI
	8/7BxQKE+eMIRuR206+/TJnuja7EGoKNN+uAeHMranxpvz3ai2KJU4GAS0M9FsZeT/jy5gxx4rU
	lEyGSYD2Z+I2Dr32eLc7qiurQh7SJ9Gn5PGLi+52P4KrdyGX9V3lzY2Z4qMH+KfiJ9G6obyNqRH
	Yx7QR9w1nvLx06qOMi4RhOsKntfg4bDqve6zEHnMwNi+SjqPXBoGgGIjaA0aQ5Q6LltjD6p+8Gm
	Nrmqn3005spDO0aTLiAQaQkPOdmRHQ58DIfSdR/Ez+4Cw6e5JclAkDTA2ZUkRaRnynQ2iwEukHx
	Wi+HlPp9S+tGDCbCAjzPZ7UrXIjTV5vPjpVSamq5cCEsllApcsGZ0KL/cVWflfNoRCNC2szec/O
	YErov+/Ti+Er0YLZMGNVGBh61GBbi+HD9JNtVHSmykhfAmJ5bAuYUciC+HzWEKXOtL2RGjWFhuR
	UtJmhgeB0gyB8E1Ak7imunE9+otug==
X-Google-Smtp-Source: AGHT+IHOsiAhZ9xPyUiDULQCHB9CaO2kDC+DjBBHYpXyG5kFA8Tpsl+BUazXOzqChZ0PGpazhw5vVQ==
X-Received: by 2002:a05:701b:2302:b0:119:e56b:958a with SMTP id a92af1059eb24-11f34bea017mr8705469c88.15.1765949936541;
        Tue, 16 Dec 2025 21:38:56 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30b799sm58319065c88.17.2025.12.16.21.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:38:56 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH] ata: pata_legacy: remove VLB support
Date: Tue, 16 Dec 2025 21:38:22 -0800
Message-ID: <20251217053822.35783-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This significantly reduces the complexity of the pata_legacy driver.
The VLB bus is very obsolete and last appeared on P5 Pentium-era
hardware. Support for it has been removed from other drivers, and
it is highly unlikely anyone is using it with modern Linux kernels.
Some of these chips were integrated on motherboards, but they
seem to have all been 486-era boards, which are equally obsolete.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/ata/Kconfig       |  17 +-
 drivers/ata/pata_legacy.c | 867 +-------------------------------------
 2 files changed, 6 insertions(+), 878 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 120a2b7067fc..2349bca136e0 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1127,13 +1127,6 @@ config PATA_OF_PLATFORM
 
 	  If unsure, say N.
 
-config PATA_QDI
-	tristate "QDI VLB PATA support"
-	depends on ISA
-	select PATA_LEGACY
-	help
-	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
-
 config PATA_RB532
 	tristate "RouterBoard 532 PATA CompactFlash support"
 	depends on MIKROTIK_RB532
@@ -1152,14 +1145,6 @@ config PATA_RZ1000
 
 	  If unsure, say N.
 
-config PATA_WINBOND_VLB
-	tristate "Winbond W83759A VLB PATA support (Experimental)"
-	depends on ISA
-	select PATA_LEGACY
-	help
-	  Support for the Winbond W83759A controller on Vesa Local Bus
-	  systems.
-
 config PATA_PARPORT
 	tristate "Parallel port IDE device support"
 	depends on PARPORT_PC
@@ -1201,7 +1186,7 @@ config PATA_LEGACY
 	depends on (ISA || PCI) && HAS_IOPORT
 	select PATA_TIMINGS
 	help
-	  This option enables support for ISA/VLB/PCI bus legacy PATA
+	  This option enables support for ISA/PCI bus legacy PATA
 	  ports and allows them to be accessed via the new ATA layer.
 
 	  If unsure, say N.
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index e7ac142c2423..80486f8820e4 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -5,43 +5,10 @@
  *
  *   An ATA driver for the legacy ATA ports.
  *
- *   Data Sources:
- *	Opti 82C465/82C611 support: Data sheets at opti-inc.com
- *	HT6560 series:
- *	Promise 20230/20620:
- *		http://www.ryston.cz/petr/vlb/pdc20230b.html
- *		http://www.ryston.cz/petr/vlb/pdc20230c.html
- *		http://www.ryston.cz/petr/vlb/pdc20630.html
- *	QDI65x0:
- *		http://www.ryston.cz/petr/vlb/qd6500.html
- *		http://www.ryston.cz/petr/vlb/qd6580.html
- *
- *	QDI65x0 probe code based on drivers/ide/legacy/qd65xx.c
- *	Rewritten from the work of Colten Edwards <pje120@cs.usask.ca> by
- *	Samuel Thibault <samuel.thibault@ens-lyon.org>
- *
- *  Unsupported but docs exist:
- *	Appian/Adaptec AIC25VL01/Cirrus Logic PD7220
- *
- *  This driver handles legacy (that is "ISA/VLB side") IDE ports found
- *  on PC class systems. There are three hybrid devices that are exceptions
+ *  This driver handles legacy (that is "ISA side") IDE ports found
+ *  on PC class systems. There are three hybrid devices that are exceptions:
  *  The Cyrix 5510/5520 where a pre SFF ATA device is on the bridge and
  *  the MPIIX where the tuning is PCI side but the IDE is "ISA side".
- *
- *  Specific support is included for the ht6560a/ht6560b/opti82c611a/
- *  opti82c465mv/promise 20230c/20630/qdi65x0/winbond83759A
- *
- *  Support for the Winbond 83759A when operating in advanced mode.
- *  Multichip mode is not currently supported.
- *
- *  Use the autospeed and pio_mask options with:
- *	Appian ADI/2 aka CLPD7220 or AIC25VL01.
- *  Use the jumpers, autospeed and set pio_mask to the mode on the jumpers with
- *	Goldstar GM82C711, PIC-1288A-125, UMC 82C871F, Winbond W83759,
- *	Winbond W83759A, Promise PDC20230-B
- *
- *  For now use autospeed and pio_mask as above with the W83759A. This may
- *  change.
  */
 
 #include <linux/async.h>
@@ -87,55 +54,9 @@ static int iordy_mask = 0xFFFFFFFF;
 module_param(iordy_mask, int, 0);
 MODULE_PARM_DESC(iordy_mask, "Use IORDY if available");
 
-static int ht6560a;
-module_param(ht6560a, int, 0);
-MODULE_PARM_DESC(ht6560a, "HT 6560A on primary 1, second 2, both 3");
-
-static int ht6560b;
-module_param(ht6560b, int, 0);
-MODULE_PARM_DESC(ht6560b, "HT 6560B on primary 1, secondary 2, both 3");
-
-static int opti82c611a;
-module_param(opti82c611a, int, 0);
-MODULE_PARM_DESC(opti82c611a,
-		 "Opti 82c611A on primary 1, secondary 2, both 3");
-
-static int opti82c46x;
-module_param(opti82c46x, int, 0);
-MODULE_PARM_DESC(opti82c46x,
-		 "Opti 82c465MV on primary 1, secondary 2, both 3");
-
-#ifdef CONFIG_PATA_QDI_MODULE
-static int qdi = 1;
-#else
-static int qdi;
-#endif
-module_param(qdi, int, 0);
-MODULE_PARM_DESC(qdi, "Set to probe QDI controllers");
-
-#ifdef CONFIG_PATA_WINBOND_VLB_MODULE
-static int winbond = 1;
-#else
-static int winbond;
-#endif
-module_param(winbond, int, 0);
-MODULE_PARM_DESC(winbond,
-		 "Set to probe Winbond controllers, "
-		 "give I/O port if non standard");
-
-
 enum controller {
 	BIOS = 0,
 	SNOOP = 1,
-	PDC20230 = 2,
-	HT6560A = 3,
-	HT6560B = 4,
-	OPTI611A = 5,
-	OPTI46X = 6,
-	QDI6500 = 7,
-	QDI6580 = 8,
-	QDI6580DP = 9,		/* Dual channel mode is different */
-	W83759A = 10,
 
 	UNKNOWN = -1
 };
@@ -183,7 +104,7 @@ static struct ata_host *legacy_host[NR_HOST];
  *
  *	Add an entry into the probe list for ATA controllers. This is used
  *	to add the default ISA slots and then to build up the table
- *	further according to other ISA/VLB/Weird device scans
+ *	further according to other ISA/Weird device scans
  *
  *	An I/O port list is used to keep ordering stable and sane, as we
  *	don't have any good way to talk about ordering otherwise
@@ -276,613 +197,11 @@ static struct ata_port_operations legacy_port_ops = {
 	.set_mode	= legacy_set_mode,
 };
 
-/*
- *	Promise 20230C and 20620 support
- *
- *	This controller supports PIO0 to PIO2. We set PIO timings
- *	conservatively to allow for 50MHz Vesa Local Bus. The 20620 DMA
- *	support is weird being DMA to controller and PIO'd to the host
- *	and not supported.
- */
-
-static void pdc20230_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	int tries = 5;
-	int pio = adev->pio_mode - XFER_PIO_0;
-	u8 rt;
-	unsigned long flags;
-
-	/* Safe as UP only. Force I/Os to occur together */
-
-	local_irq_save(flags);
-
-	/* Unlock the control interface */
-	do {
-		inb(0x1F5);
-		outb(inb(0x1F2) | 0x80, 0x1F2);
-		inb(0x1F2);
-		inb(0x3F6);
-		inb(0x3F6);
-		inb(0x1F2);
-		inb(0x1F2);
-	}
-	while ((inb(0x1F2) & 0x80) && --tries);
-
-	local_irq_restore(flags);
-
-	outb(inb(0x1F4) & 0x07, 0x1F4);
-
-	rt = inb(0x1F3);
-	rt &= ~(0x07 << (3 * !adev->devno));
-	if (pio)
-		rt |= (1 + 3 * pio) << (3 * !adev->devno);
-	outb(rt, 0x1F3);
-
-	udelay(100);
-	outb(inb(0x1F2) | 0x01, 0x1F2);
-	udelay(100);
-	inb(0x1F5);
-
-}
-
-static unsigned int pdc_data_xfer_vlb(struct ata_queued_cmd *qc,
-			unsigned char *buf, unsigned int buflen, int rw)
-{
-	struct ata_device *dev = qc->dev;
-	struct ata_port *ap = dev->link->ap;
-	int slop = buflen & 3;
-
-	/* 32bit I/O capable *and* we need to write a whole number of dwords */
-	if (ata_id_has_dword_io(dev->id) && (slop == 0 || slop == 3)
-					&& (ap->pflags & ATA_PFLAG_PIO32)) {
-		unsigned long flags;
-
-		local_irq_save(flags);
-
-		/* Perform the 32bit I/O synchronization sequence */
-		ioread8(ap->ioaddr.nsect_addr);
-		ioread8(ap->ioaddr.nsect_addr);
-		ioread8(ap->ioaddr.nsect_addr);
-
-		/* Now the data */
-		if (rw == READ)
-			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
-		else
-			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
-
-		if (unlikely(slop)) {
-			__le32 pad = 0;
-
-			if (rw == READ) {
-				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
-				memcpy(buf + buflen - slop, &pad, slop);
-			} else {
-				memcpy(&pad, buf + buflen - slop, slop);
-				iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
-			}
-			buflen += 4 - slop;
-		}
-		local_irq_restore(flags);
-	} else
-		buflen = ata_sff_data_xfer32(qc, buf, buflen, rw);
-
-	return buflen;
-}
-
-static struct ata_port_operations pdc20230_port_ops = {
-	.inherits	= &legacy_base_port_ops,
-	.set_piomode	= pdc20230_set_piomode,
-	.sff_data_xfer	= pdc_data_xfer_vlb,
-};
-
-/*
- *	Holtek 6560A support
- *
- *	This controller supports PIO0 to PIO2 (no IORDY even though higher
- *	timings can be loaded).
- */
-
-static void ht6560a_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	u8 active, recover;
-	struct ata_timing t;
-
-	/* Get the timing data in cycles. For now play safe at 50Mhz */
-	ata_timing_compute(adev, adev->pio_mode, &t, 20000, 1000);
-
-	active = clamp_val(t.active, 2, 15);
-	recover = clamp_val(t.recover, 4, 15);
-
-	inb(0x3E6);
-	inb(0x3E6);
-	inb(0x3E6);
-	inb(0x3E6);
-
-	iowrite8(recover << 4 | active, ap->ioaddr.device_addr);
-	ioread8(ap->ioaddr.status_addr);
-}
-
-static struct ata_port_operations ht6560a_port_ops = {
-	.inherits	= &legacy_base_port_ops,
-	.set_piomode	= ht6560a_set_piomode,
-};
-
-/*
- *	Holtek 6560B support
- *
- *	This controller supports PIO0 to PIO4. We honour the BIOS/jumper FIFO
- *	setting unless we see an ATAPI device in which case we force it off.
- *
- *	FIXME: need to implement 2nd channel support.
- */
-
-static void ht6560b_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	u8 active, recover;
-	struct ata_timing t;
-
-	/* Get the timing data in cycles. For now play safe at 50Mhz */
-	ata_timing_compute(adev, adev->pio_mode, &t, 20000, 1000);
-
-	active = clamp_val(t.active, 2, 15);
-	recover = clamp_val(t.recover, 2, 16) & 0x0F;
-
-	inb(0x3E6);
-	inb(0x3E6);
-	inb(0x3E6);
-	inb(0x3E6);
-
-	iowrite8(recover << 4 | active, ap->ioaddr.device_addr);
-
-	if (adev->class != ATA_DEV_ATA) {
-		u8 rconf = inb(0x3E6);
-		if (rconf & 0x24) {
-			rconf &= ~0x24;
-			outb(rconf, 0x3E6);
-		}
-	}
-	ioread8(ap->ioaddr.status_addr);
-}
-
-static struct ata_port_operations ht6560b_port_ops = {
-	.inherits	= &legacy_base_port_ops,
-	.set_piomode	= ht6560b_set_piomode,
-};
-
-/*
- *	Opti core chipset helpers
- */
-
-/**
- *	opti_syscfg	-	read OPTI chipset configuration
- *	@reg: Configuration register to read
- *
- *	Returns the value of an OPTI system board configuration register.
- */
-
-static u8 opti_syscfg(u8 reg)
-{
-	unsigned long flags;
-	u8 r;
-
-	/* Uniprocessor chipset and must force cycles adjancent */
-	local_irq_save(flags);
-	outb(reg, 0x22);
-	r = inb(0x24);
-	local_irq_restore(flags);
-	return r;
-}
-
-/*
- *	Opti 82C611A
- *
- *	This controller supports PIO0 to PIO3.
- */
-
-static void opti82c611a_set_piomode(struct ata_port *ap,
-						struct ata_device *adev)
-{
-	u8 active, recover, setup;
-	struct ata_timing t;
-	struct ata_device *pair = ata_dev_pair(adev);
-	int clock;
-	int khz[4] = { 50000, 40000, 33000, 25000 };
-	u8 rc;
-
-	/* Enter configuration mode */
-	ioread16(ap->ioaddr.error_addr);
-	ioread16(ap->ioaddr.error_addr);
-	iowrite8(3, ap->ioaddr.nsect_addr);
-
-	/* Read VLB clock strapping */
-	clock = 1000000000 / khz[ioread8(ap->ioaddr.lbah_addr) & 0x03];
-
-	/* Get the timing data in cycles */
-	ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000);
-
-	/* Setup timing is shared */
-	if (pair) {
-		struct ata_timing tp;
-		ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000);
-
-		ata_timing_merge(&t, &tp, &t, ATA_TIMING_SETUP);
-	}
-
-	active = clamp_val(t.active, 2, 17) - 2;
-	recover = clamp_val(t.recover, 1, 16) - 1;
-	setup = clamp_val(t.setup, 1, 4) - 1;
-
-	/* Select the right timing bank for write timing */
-	rc = ioread8(ap->ioaddr.lbal_addr);
-	rc &= 0x7F;
-	rc |= (adev->devno << 7);
-	iowrite8(rc, ap->ioaddr.lbal_addr);
-
-	/* Write the timings */
-	iowrite8(active << 4 | recover, ap->ioaddr.error_addr);
-
-	/* Select the right bank for read timings, also
-	   load the shared timings for address */
-	rc = ioread8(ap->ioaddr.device_addr);
-	rc &= 0xC0;
-	rc |= adev->devno;	/* Index select */
-	rc |= (setup << 4) | 0x04;
-	iowrite8(rc, ap->ioaddr.device_addr);
-
-	/* Load the read timings */
-	iowrite8(active << 4 | recover, ap->ioaddr.data_addr);
-
-	/* Ensure the timing register mode is right */
-	rc = ioread8(ap->ioaddr.lbal_addr);
-	rc &= 0x73;
-	rc |= 0x84;
-	iowrite8(rc, ap->ioaddr.lbal_addr);
-
-	/* Exit command mode */
-	iowrite8(0x83,  ap->ioaddr.nsect_addr);
-}
-
-
-static struct ata_port_operations opti82c611a_port_ops = {
-	.inherits	= &legacy_base_port_ops,
-	.set_piomode	= opti82c611a_set_piomode,
-};
-
-/*
- *	Opti 82C465MV
- *
- *	This controller supports PIO0 to PIO3. Unlike the 611A the MVB
- *	version is dual channel but doesn't have a lot of unique registers.
- */
-
-static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	u8 active, recover, setup;
-	struct ata_timing t;
-	struct ata_device *pair = ata_dev_pair(adev);
-	int clock;
-	int khz[4] = { 50000, 40000, 33000, 25000 };
-	u8 rc;
-	u8 sysclk;
-
-	/* Get the clock */
-	sysclk = (opti_syscfg(0xAC) & 0xC0) >> 6;	/* BIOS set */
-
-	/* Enter configuration mode */
-	ioread16(ap->ioaddr.error_addr);
-	ioread16(ap->ioaddr.error_addr);
-	iowrite8(3, ap->ioaddr.nsect_addr);
-
-	/* Read VLB clock strapping */
-	clock = 1000000000 / khz[sysclk];
-
-	/* Get the timing data in cycles */
-	ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000);
-
-	/* Setup timing is shared */
-	if (pair) {
-		struct ata_timing tp;
-		ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000);
-
-		ata_timing_merge(&t, &tp, &t, ATA_TIMING_SETUP);
-	}
-
-	active = clamp_val(t.active, 2, 17) - 2;
-	recover = clamp_val(t.recover, 1, 16) - 1;
-	setup = clamp_val(t.setup, 1, 4) - 1;
-
-	/* Select the right timing bank for write timing */
-	rc = ioread8(ap->ioaddr.lbal_addr);
-	rc &= 0x7F;
-	rc |= (adev->devno << 7);
-	iowrite8(rc, ap->ioaddr.lbal_addr);
-
-	/* Write the timings */
-	iowrite8(active << 4 | recover, ap->ioaddr.error_addr);
-
-	/* Select the right bank for read timings, also
-	   load the shared timings for address */
-	rc = ioread8(ap->ioaddr.device_addr);
-	rc &= 0xC0;
-	rc |= adev->devno;	/* Index select */
-	rc |= (setup << 4) | 0x04;
-	iowrite8(rc, ap->ioaddr.device_addr);
-
-	/* Load the read timings */
-	iowrite8(active << 4 | recover, ap->ioaddr.data_addr);
-
-	/* Ensure the timing register mode is right */
-	rc = ioread8(ap->ioaddr.lbal_addr);
-	rc &= 0x73;
-	rc |= 0x84;
-	iowrite8(rc, ap->ioaddr.lbal_addr);
-
-	/* Exit command mode */
-	iowrite8(0x83,  ap->ioaddr.nsect_addr);
-
-	/* We need to know this for quad device on the MVB */
-	ap->host->private_data = ap;
-}
-
-/**
- *	opti82c46x_qc_issue		-	command issue
- *	@qc: command pending
- *
- *	Called when the libata layer is about to issue a command. We wrap
- *	this interface so that we can load the correct ATA timings. The
- *	MVB has a single set of timing registers and these are shared
- *	across channels. As there are two registers we really ought to
- *	track the last two used values as a sort of register window. For
- *	now we just reload on a channel switch. On the single channel
- *	setup this condition never fires so we do nothing extra.
- *
- *	FIXME: dual channel needs ->serialize support
- */
-
-static unsigned int opti82c46x_qc_issue(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct ata_device *adev = qc->dev;
-
-	/* If timings are set and for the wrong channel (2nd test is
-	   due to a libata shortcoming and will eventually go I hope) */
-	if (ap->host->private_data != ap->host
-	    && ap->host->private_data != NULL)
-		opti82c46x_set_piomode(ap, adev);
-
-	return ata_sff_qc_issue(qc);
-}
-
-static struct ata_port_operations opti82c46x_port_ops = {
-	.inherits	= &legacy_base_port_ops,
-	.set_piomode	= opti82c46x_set_piomode,
-	.qc_issue	= opti82c46x_qc_issue,
-};
-
-/**
- *	qdi65x0_set_piomode		-	PIO setup for QDI65x0
- *	@ap: Port
- *	@adev: Device
- *
- *	In single channel mode the 6580 has one clock per device and we can
- *	avoid the requirement to clock switch. We also have to load the timing
- *	into the right clock according to whether we are master or slave.
- *
- *	In dual channel mode the 6580 has one clock per channel and we have
- *	to software clockswitch in qc_issue.
- */
-
-static void qdi65x0_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	struct ata_timing t;
-	struct legacy_data *ld_qdi = ap->host->private_data;
-	int active, recovery;
-	u8 timing;
-
-	/* Get the timing data in cycles */
-	ata_timing_compute(adev, adev->pio_mode, &t, 30303, 1000);
-
-	if (ld_qdi->fast) {
-		active = 8 - clamp_val(t.active, 1, 8);
-		recovery = 18 - clamp_val(t.recover, 3, 18);
-	} else {
-		active = 9 - clamp_val(t.active, 2, 9);
-		recovery = 15 - clamp_val(t.recover, 0, 15);
-	}
-	timing = (recovery << 4) | active | 0x08;
-	ld_qdi->clock[adev->devno] = timing;
-
-	if (ld_qdi->type == QDI6580)
-		outb(timing, ld_qdi->timing + 2 * adev->devno);
-	else
-		outb(timing, ld_qdi->timing + 2 * ap->port_no);
-
-	/* Clear the FIFO */
-	if (ld_qdi->type != QDI6500 && adev->class != ATA_DEV_ATA)
-		outb(0x5F, (ld_qdi->timing & 0xFFF0) + 3);
-}
-
-/**
- *	qdi_qc_issue		-	command issue
- *	@qc: command pending
- *
- *	Called when the libata layer is about to issue a command. We wrap
- *	this interface so that we can load the correct ATA timings.
- */
-
-static unsigned int qdi_qc_issue(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct ata_device *adev = qc->dev;
-	struct legacy_data *ld_qdi = ap->host->private_data;
-
-	if (ld_qdi->clock[adev->devno] != ld_qdi->last) {
-		if (adev->pio_mode) {
-			ld_qdi->last = ld_qdi->clock[adev->devno];
-			outb(ld_qdi->clock[adev->devno], ld_qdi->timing +
-							2 * ap->port_no);
-		}
-	}
-	return ata_sff_qc_issue(qc);
-}
-
-static unsigned int vlb32_data_xfer(struct ata_queued_cmd *qc,
-				    unsigned char *buf,
-				    unsigned int buflen, int rw)
-{
-	struct ata_device *adev = qc->dev;
-	struct ata_port *ap = adev->link->ap;
-	int slop = buflen & 3;
-
-	if (ata_id_has_dword_io(adev->id) && (slop == 0 || slop == 3)
-					&& (ap->pflags & ATA_PFLAG_PIO32)) {
-		if (rw == WRITE)
-			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
-		else
-			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
-
-		if (unlikely(slop)) {
-			__le32 pad = 0;
-
-			if (rw == WRITE) {
-				memcpy(&pad, buf + buflen - slop, slop);
-				iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
-			} else {
-				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
-				memcpy(buf + buflen - slop, &pad, slop);
-			}
-		}
-		return (buflen + 3) & ~3;
-	} else
-		return ata_sff_data_xfer(qc, buf, buflen, rw);
-}
-
-static int qdi_port(struct platform_device *dev,
-			struct legacy_probe *lp, struct legacy_data *ld)
-{
-	if (devm_request_region(&dev->dev, lp->private, 4, "qdi") == NULL)
-		return -EBUSY;
-	ld->timing = lp->private;
-	return 0;
-}
-
-static struct ata_port_operations qdi6500_port_ops = {
-	.inherits	= &legacy_base_port_ops,
-	.set_piomode	= qdi65x0_set_piomode,
-	.qc_issue	= qdi_qc_issue,
-	.sff_data_xfer	= vlb32_data_xfer,
-};
-
-static struct ata_port_operations qdi6580_port_ops = {
-	.inherits	= &legacy_base_port_ops,
-	.set_piomode	= qdi65x0_set_piomode,
-	.sff_data_xfer	= vlb32_data_xfer,
-};
-
-static struct ata_port_operations qdi6580dp_port_ops = {
-	.inherits	= &legacy_base_port_ops,
-	.set_piomode	= qdi65x0_set_piomode,
-	.qc_issue	= qdi_qc_issue,
-	.sff_data_xfer	= vlb32_data_xfer,
-};
-
-static DEFINE_SPINLOCK(winbond_lock);
-
-static void winbond_writecfg(unsigned long port, u8 reg, u8 val)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&winbond_lock, flags);
-	outb(reg, port + 0x01);
-	outb(val, port + 0x02);
-	spin_unlock_irqrestore(&winbond_lock, flags);
-}
-
-static u8 winbond_readcfg(unsigned long port, u8 reg)
-{
-	u8 val;
-
-	unsigned long flags;
-	spin_lock_irqsave(&winbond_lock, flags);
-	outb(reg, port + 0x01);
-	val = inb(port + 0x02);
-	spin_unlock_irqrestore(&winbond_lock, flags);
-
-	return val;
-}
-
-static void winbond_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	struct ata_timing t;
-	struct legacy_data *ld_winbond = ap->host->private_data;
-	int active, recovery;
-	u8 reg;
-	int timing = 0x88 + (ap->port_no * 4) + (adev->devno * 2);
-
-	reg = winbond_readcfg(ld_winbond->timing, 0x81);
-
-	/* Get the timing data in cycles */
-	if (reg & 0x40)		/* Fast VLB bus, assume 50MHz */
-		ata_timing_compute(adev, adev->pio_mode, &t, 20000, 1000);
-	else
-		ata_timing_compute(adev, adev->pio_mode, &t, 30303, 1000);
-
-	active = (clamp_val(t.active, 3, 17) - 1) & 0x0F;
-	recovery = (clamp_val(t.recover, 1, 15) + 1) & 0x0F;
-	timing = (active << 4) | recovery;
-	winbond_writecfg(ld_winbond->timing, timing, reg);
-
-	/* Load the setup timing */
-
-	reg = 0x35;
-	if (adev->class != ATA_DEV_ATA)
-		reg |= 0x08;	/* FIFO off */
-	if (!ata_pio_need_iordy(adev))
-		reg |= 0x02;	/* IORDY off */
-	reg |= (clamp_val(t.setup, 0, 3) << 6);
-	winbond_writecfg(ld_winbond->timing, timing + 1, reg);
-}
-
-static int winbond_port(struct platform_device *dev,
-			struct legacy_probe *lp, struct legacy_data *ld)
-{
-	if (devm_request_region(&dev->dev, lp->private, 4, "winbond") == NULL)
-		return -EBUSY;
-	ld->timing = lp->private;
-	return 0;
-}
-
-static struct ata_port_operations winbond_port_ops = {
-	.inherits	= &legacy_base_port_ops,
-	.set_piomode	= winbond_set_piomode,
-	.sff_data_xfer	= vlb32_data_xfer,
-};
-
 static struct legacy_controller controllers[] = {
 	{"BIOS",	&legacy_port_ops, 	ATA_PIO4,
 			ATA_FLAG_NO_IORDY,	0,			NULL },
 	{"Snooping", 	&simple_port_ops, 	ATA_PIO4,
 			0,			0,			NULL },
-	{"PDC20230",	&pdc20230_port_ops,	ATA_PIO2,
-			ATA_FLAG_NO_IORDY,
-			ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE,	NULL },
-	{"HT6560A",	&ht6560a_port_ops,	ATA_PIO2,
-			ATA_FLAG_NO_IORDY,	0,			NULL },
-	{"HT6560B",	&ht6560b_port_ops,	ATA_PIO4,
-			ATA_FLAG_NO_IORDY,	0,			NULL },
-	{"OPTI82C611A",	&opti82c611a_port_ops,	ATA_PIO3,
-			0,			0,			NULL },
-	{"OPTI82C46X",	&opti82c46x_port_ops,	ATA_PIO3,
-			0,			0,			NULL },
-	{"QDI6500",	&qdi6500_port_ops,	ATA_PIO2,
-			ATA_FLAG_NO_IORDY,
-			ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE,    qdi_port },
-	{"QDI6580",	&qdi6580_port_ops,	ATA_PIO4,
-			0, ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE, qdi_port },
-	{"QDI6580DP",	&qdi6580dp_port_ops,	ATA_PIO4,
-			0, ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE, qdi_port },
-	{"W83759A",	&winbond_port_ops,	ATA_PIO4,
-			0, ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE,
-								winbond_port }
 };
 
 /**
@@ -897,62 +216,6 @@ static __init int probe_chip_type(struct legacy_probe *probe)
 {
 	int mask = 1 << probe->slot;
 
-	if (winbond && (probe->port == 0x1F0 || probe->port == 0x170)) {
-		u8 reg = winbond_readcfg(winbond, 0x81);
-		reg |= 0x80;	/* jumpered mode off */
-		winbond_writecfg(winbond, 0x81, reg);
-		reg = winbond_readcfg(winbond, 0x83);
-		reg |= 0xF0;	/* local control */
-		winbond_writecfg(winbond, 0x83, reg);
-		reg = winbond_readcfg(winbond, 0x85);
-		reg |= 0xF0;	/* programmable timing */
-		winbond_writecfg(winbond, 0x85, reg);
-
-		reg = winbond_readcfg(winbond, 0x81);
-
-		if (reg & mask)
-			return W83759A;
-	}
-	if (probe->port == 0x1F0) {
-		unsigned long flags;
-		local_irq_save(flags);
-		/* Probes */
-		outb(inb(0x1F2) | 0x80, 0x1F2);
-		inb(0x1F5);
-		inb(0x1F2);
-		inb(0x3F6);
-		inb(0x3F6);
-		inb(0x1F2);
-		inb(0x1F2);
-
-		if ((inb(0x1F2) & 0x80) == 0) {
-			/* PDC20230c or 20630 ? */
-			printk(KERN_INFO  "PDC20230-C/20630 VLB ATA controller"
-							" detected.\n");
-			udelay(100);
-			inb(0x1F5);
-			local_irq_restore(flags);
-			return PDC20230;
-		} else {
-			outb(0x55, 0x1F2);
-			inb(0x1F2);
-			inb(0x1F2);
-			if (inb(0x1F2) == 0x00)
-				printk(KERN_INFO "PDC20230-B VLB ATA "
-						     "controller detected.\n");
-			local_irq_restore(flags);
-			return BIOS;
-		}
-	}
-
-	if (ht6560a & mask)
-		return HT6560A;
-	if (ht6560b & mask)
-		return HT6560B;
-	if (opti82c611a & mask)
-		return OPTI611A;
-	if (opti82c46x & mask)
-		return OPTI46X;
 	if (autospeed & mask)
 		return SNOOP;
 	return BIOS;
@@ -1085,123 +348,13 @@ static void __init legacy_check_special_cases(struct pci_dev *p, int *primary,
 	}
 }
 
-static __init void probe_opti_vlb(void)
-{
-	/* If an OPTI 82C46X is present find out where the channels are */
-	static const char *optis[4] = {
-		"3/463MV", "5MV",
-		"5MVA", "5MVB"
-	};
-	u8 chans = 1;
-	u8 ctrl = (opti_syscfg(0x30) & 0xC0) >> 6;
-
-	opti82c46x = 3;	/* Assume master and slave first */
-	printk(KERN_INFO DRV_NAME ": Opti 82C46%s chipset support.\n",
-								optis[ctrl]);
-	if (ctrl == 3)
-		chans = (opti_syscfg(0x3F) & 0x20) ? 2 : 1;
-	ctrl = opti_syscfg(0xAC);
-	/* Check enabled and this port is the 465MV port. On the
-	   MVB we may have two channels */
-	if (ctrl & 8) {
-		if (chans == 2) {
-			legacy_probe_add(0x1F0, 14, OPTI46X, 0);
-			legacy_probe_add(0x170, 15, OPTI46X, 0);
-		}
-		if (ctrl & 4)
-			legacy_probe_add(0x170, 15, OPTI46X, 0);
-		else
-			legacy_probe_add(0x1F0, 14, OPTI46X, 0);
-	} else
-		legacy_probe_add(0x1F0, 14, OPTI46X, 0);
-}
-
-static __init void qdi65_identify_port(u8 r, u8 res, unsigned long port)
-{
-	static const unsigned long ide_port[2] = { 0x170, 0x1F0 };
-	/* Check card type */
-	if ((r & 0xF0) == 0xC0) {
-		/* QD6500: single channel */
-		if (r & 8)
-			/* Disabled ? */
-			return;
-		legacy_probe_add(ide_port[r & 0x01], 14 + (r & 0x01),
-								QDI6500, port);
-	}
-	if (((r & 0xF0) == 0xA0) || (r & 0xF0) == 0x50) {
-		/* QD6580: dual channel */
-		if (!request_region(port + 2 , 2, "pata_qdi")) {
-			release_region(port, 2);
-			return;
-		}
-		res = inb(port + 3);
-		/* Single channel mode ? */
-		if (res & 1)
-			legacy_probe_add(ide_port[r & 0x01], 14 + (r & 0x01),
-								QDI6580, port);
-		else { /* Dual channel mode */
-			legacy_probe_add(0x1F0, 14, QDI6580DP, port);
-			/* port + 0x02, r & 0x04 */
-			legacy_probe_add(0x170, 15, QDI6580DP, port + 2);
-		}
-		release_region(port + 2, 2);
-	}
-}
-
-static __init void probe_qdi_vlb(void)
-{
-	unsigned long flags;
-	static const unsigned long qd_port[2] = { 0x30, 0xB0 };
-	int i;
-
-	/*
-	 *	Check each possible QD65xx base address
-	 */
-
-	for (i = 0; i < 2; i++) {
-		unsigned long port = qd_port[i];
-		u8 r, res;
-
-
-		if (request_region(port, 2, "pata_qdi")) {
-			/* Check for a card */
-			local_irq_save(flags);
-			/* I have no h/w that needs this delay but it
-			   is present in the historic code */
-			r = inb(port);
-			udelay(1);
-			outb(0x19, port);
-			udelay(1);
-			res = inb(port);
-			udelay(1);
-			outb(r, port);
-			udelay(1);
-			local_irq_restore(flags);
-
-			/* Fail */
-			if (res == 0x19) {
-				release_region(port, 2);
-				continue;
-			}
-			/* Passes the presence test */
-			r = inb(port + 1);
-			udelay(1);
-			/* Check port agrees with port set */
-			if ((r & 2) >> 1 == i)
-				qdi65_identify_port(r, res, port);
-			release_region(port, 2);
-		}
-	}
-}
-
 /**
  *	legacy_init		-	attach legacy interfaces
  *
  *	Attach legacy IDE interfaces by scanning the usual IRQ/port suspects.
  *	Right now we do not scan the ide0 and ide1 address but should do so
  *	for non PCI systems or systems with no PCI IDE legacy mode devices.
- *	If you fix that note there are special cases to consider like VLB
- *	drivers and CS5510/20.
+ *	If you fix that note there are special cases to consider like CS5510/20.
  */
 
 static __init int legacy_init(void)
@@ -1235,27 +388,19 @@ static __init int legacy_init(void)
 		pci_present = 1;
 	}
 
-	if (winbond == 1)
-		winbond = 0x130;	/* Default port, alt is 1B0 */
-
 	if (primary == 0 || all)
 		legacy_probe_add(0x1F0, 14, UNKNOWN, 0);
 	if (secondary == 0 || all)
 		legacy_probe_add(0x170, 15, UNKNOWN, 0);
 
 	if (probe_all || !pci_present) {
-		/* ISA/VLB extra ports */
+		/* ISA extra ports */
 		legacy_probe_add(0x1E8, 11, UNKNOWN, 0);
 		legacy_probe_add(0x168, 10, UNKNOWN, 0);
 		legacy_probe_add(0x1E0, 8, UNKNOWN, 0);
 		legacy_probe_add(0x160, 12, UNKNOWN, 0);
 	}
 
-	if (opti82c46x)
-		probe_opti_vlb();
-	if (qdi)
-		probe_qdi_vlb();
-
 	for (i = 0; i < NR_HOST; i++, pl++) {
 		if (pl->port == 0)
 			continue;
@@ -1287,8 +432,6 @@ MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for legacy ATA");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
-MODULE_ALIAS("pata_qdi");
-MODULE_ALIAS("pata_winbond");
 
 module_init(legacy_init);
 module_exit(legacy_exit);
-- 
2.43.0

