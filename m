From: Michael =?iso-8859-1?Q?M=FCller?= <mueller_michael@nikocity.de>
Subject: Using PATA port from Promise SATA 300 TX2 plus
Date: Sun, 19 Feb 2006 13:42:58 +0100
Message-ID: <20060219124258.GH4858@mueller_michael.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:41412 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932414AbWBSMnD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Feb 2006 07:43:03 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

I want to tell you that I was able to use the two SATA ports and the
PATA port from my Promise SATA 300 TX2 plus under linux 2.6.16-rc1 and
your patch 2.6.16-rc1-libata1.patch.bz2. The only problem I had that
it didn't worked when I compiled it into the kernel. It didn't find
neither the SATA drives nor the PATA drive. After creating the module
everything worked fine without any further changes.

I'm booting from a hard drive (120GB) connected to the IDE controller
on the mainboard.
Here are some lines from syslog:
...
Feb 19 08:27:04 grizzly kernel: scsi2 : sata_promise
Feb 19 08:27:04 grizzly kernel:   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
Feb 19 08:27:04 grizzly kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Feb 19 08:27:04 grizzly kernel:   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
Feb 19 08:27:04 grizzly kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Feb 19 08:27:04 grizzly kernel:   Vendor: ATA       Model: IC35L060AVER07-0  Rev: ER6O
Feb 19 08:27:04 grizzly kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
...
Feb 19 08:27:04 grizzly kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
...
Feb 19 08:27:04 grizzly kernel: SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
...
Feb 19 08:27:04 grizzly kernel: SCSI device sdc: 120103200 512-byte hdwr sectors (61493 MB)
...
sda and sdb are the SATA discs and sdc is the PATA drive.

I'm using software RAID and LVM2 on top of this.

Can you point me to some informations how to tune the TCQ parameter?

I'm not on the list. So if you reply please CC me.

Thanks for your work!

Regards

Michael
