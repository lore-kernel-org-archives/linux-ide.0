From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/2] sata_vsc regression fix and vsc_sata_interrupt_cleanup
Date: Tue, 20 Feb 2007 18:21:21 -0700
Message-ID: <20070221012109.31723.65182.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23924 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbXBUBVY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 20:21:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

Tejun,

The following patches clean up vsc_sata_interrupt according to your recommendations in the thread "sata_vsc with iq3124h regression in 2.6.20".

Dan Williams (2):
      sata_vsc: factor the error and normal intr paths into separate routines
      sata_vsc: clean up vsc_sata_interrupt

* Based on Linus' latest git tree (commit: e696268a73f7f59a333624f9abf8ffc9412ee64c)
* Tested with an iq3124h PCI-X add-in card on an iop13xx platform
* Interrupt based hotplug is also enabled by these patches

Regards,

Dan
