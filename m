From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2.6.21-rc1 0/2] sata_vsc regression fix and
	vsc_sata_interrupt_cleanup (take2)
Date: Wed, 21 Feb 2007 10:56:41 -0700
Message-ID: <20070221175354.21231.15372.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34330 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422741AbXBUR4o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Feb 2007 12:56:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

Tejun,

Here are the sata_vsc patches again with the following changes:
* revert changes to vsc_intr_mask_update (vsc_thaw enables all interrupts)
* use unlikely() for the pci-abort and not-our-interrupt cases in
  vsc_sata_interrupt
* move vsc_freeze and vsc_thaw into this patch
* removed definition of invalid fis bit
* let standard ata-error-handling handle the serror register
* clear all unhandled interrupts

Thanks for pointing me in the right direction.

--
Dan
