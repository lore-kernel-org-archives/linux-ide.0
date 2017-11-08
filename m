From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [cdrom_check_status] BUG: unable to handle kernel NULL pointer
 dereference at 000001c0
Date: Wed, 08 Nov 2017 19:09:42 +0100
Message-ID: <4286386.v3LAhFsTvW@amdc3058>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
        <7885793.0mqNGdeUvE@amdc3058>
        <CGME20171108180944epcas1p18bb9337cb4cfb5c7e9bd5f6eccfa33f4@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26724 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdKHSJr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2017 13:09:47 -0500
In-reply-to: <7885793.0mqNGdeUvE@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, linux-kernel@vger.kernel.org

On Wednesday, November 08, 2017 05:28:16 PM Bartlomiej Zolnierkiewicz wrote:

> Something is very wrong here as pci_request_selected_regions() in
> drivers/ide/setup-pci.c:ide_pci_enable() should allocate PCI resources
> so the second probe attempt should not happen. Also interface/device
> names reuse should be prevented by ide_find_port_slot()..

OK, I see now what is going on here:

...
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
...

config DEBUG_TEST_DRIVER_REMOVE
	bool "Test driver remove calls during probe (UNSTABLE)"
	depends on DEBUG_KERNEL
	help
	  Say Y here if you want the Driver core to test driver remove functions
	  by calling probe, remove, probe. This tests the remove path without
	  having to unbind the driver or unload the driver module.

	  This option is expected to find errors and may render your system
	  unusable. You should say N here unless you are explicitly looking to
	  test this functionality.

We actually see race on ->remove inside IDE's ide-cd.c driver related to
disk_check_events() handling..

It is not worth to continue with fixing IDE but from the quick look SCSI
sr.c may have similar problem - it may be worth to try to reproduce it
using libata's piix driver (disable CONFIG_IDE and enable CONFIG_BLK_DEV_SR,
CONFIG_ATA_PIIX is already enabled).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

