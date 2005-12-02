From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 0/6] SATA use ACPI methods for PM
Date: Fri, 2 Dec 2005 10:16:37 -0800
Message-ID: <20051202101637.2167851a.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:50851 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750850AbVLBSNp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Dec 2005 13:13:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: axboe <axboe@suse.de>, jgarzik <jgarzik@pobox.com>


This is an update to the SATA suspend/resume patches
to use ACPI methods (specifically _SDD and _GTF).
This patch series applies to 2.6.15-rc4.

It boots but needs lots of testing & review/comments,
as well as adding a call to write taskfiles on
COMRESET event(s) (at least on async. loss of signal).

This is not intended to be a final patch for merging.

The patchset begins with the libata suspend/resume patch from
Jens Axboe and builds on that.

---
~Randy
