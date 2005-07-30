From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:sil24 00/07] sil24: misc fixes
Date: Sat, 30 Jul 2005 19:13:52 +0900 (KST)
Message-ID: <20050730101344.1C985988@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:53434 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263030AbVG3KN7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2005 06:13:59 -0400
Received: by zproxy.gmail.com with SMTP id i11so693495nzh
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2005 03:13:57 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

 Hello, Jeff & Carlos.

 These patches are misc fixes suggested by Jeff for rewritten sil24
driver.  The follwing issues are not fixed in this patchset.  I need
more info to work on these.

 * Device signature access on reset.
 * How to discern completion interrupts from error ones.
 * 64bit activation
 * Removal of PORT_RST in sil24_init_one().

[ Start of patch descriptions ]

01_sil24_add-status-emulation.patch
	: implement status register emulation

	Add back status register emulation.  It's very simple.  If the
	previous command completed successfully, we return ATA_DRDY
	for all following status register queries; otherwise, we
	return ATA_DRDY | ATA_ERR.  We can improve error reporting by
	reading CMD_ERROR register and emulating status/error values
	accordingly.

02_sil24_separate-out-error-path.patch
	: move error handling out of hot interrupt path

	Move error handling from sil24_host_intr into separate
	function - sil24_error_intr.

	Jeff, I don't think this patch actually improves readability
	and/or performance.  Is this what you wanted?

03_sil24_add-test-for-PCI-fault.patch
	: add testing for PCI fault

	On entry to interrupt handler, PORT_SLOT_STAT register is read
	first.  Check if PCI fault or device removal has occurred by
	testing the value for 0xffffffff.

04_sil24_remove-irq-disable-on-spurious-interrupt.patch
	: remove irq disable code on spurious interrupt

	If interrupt occurs on a disabled port, the driver used to
	mask the port's interrupt, but we don't know if such action is
	necessary yet and that's not what other drives do.  So, just
	do nothing and tell IRQ subsystem that it's not our interrupt.

05_sil24_mdelay-instead-of-udelay.patch
	: use longer delay function and less iteration in reset_controller

	loop 100 times with mdelay(1) instead of 1000 times with
	udelay(100) in sil24_reset_controller.

	Jeff, is this what you wanted?  If not, just ignore this
	patch.  The following patches will apply without this one.

06_sil24_add-flusing-after-masking-irq.patch
	: add IO flushing after masking irq during initialization

	Add IO flushing after masking irq during initialization.

07_sil24_add-FIXME-ata_device_add-return_value.patch
	: add FIXME comment above ata_device_add

	Add FIXME comment above ata_device_add.

[ End of patch descriptions ]

 Thanks.

--
tejun

