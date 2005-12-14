From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH/RFC 0/7] SATA ACPI suspend/resume support
Date: Tue, 13 Dec 2005 16:10:58 -0800
Message-ID: <20051213161058.594e93e6.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:16853 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030361AbVLNAHh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2005 19:07:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: axboe <axboe@suse.de>, jgarzik <jgarzik@pobox.com>


This is an update to the SATA suspend/resume patches
to use ACPI methods (specifically _SDD and _GTF).
This patch series applies to 2.6.15-rc5-git3.

It boots but needs lots of testing & review/comments,
as well as adding a call to write taskfiles on
COMRESET event(s) (at least on async. loss of signal) and
freeing ata_device->gtf_address on module unload.

The patchset begins with the libata suspend/resume patch from
Jens Axboe and builds on that.

---
~Randy
