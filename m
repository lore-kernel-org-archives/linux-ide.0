From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/2] fix sil24 regression and muddy the ata tag allocation
 waters
Date: Fri, 16 Jan 2015 15:12:57 -0800
Message-ID: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54502 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbbAPXMv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2015 18:12:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org, Jens Axboe <axboe@fb.com>, Shaohua Li <shli@fb.com>, Tejun Heo <tj@kernel.org>, Ronny Hegewald <Ronny.Hegewald@online.de>

The last we left the fix for the reported sil24 regression [1], Tejun
had asked that I simplify the patch to just a flag [2].

Patch1 incorporates that feedback.  Patch2 tries to make the ata tag
allocator implementation slightly better than its current worst case
implementation.  I'm fine with replacing it with something better from
the block layer, but that implementation had better address the quirk
that patch1 does.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=87101
[2]: http://marc.info/?l=linux-ide&m=141511124009903&w=2

---

Dan Williams (2):
      libata: allow sata_sil24 to opt-out of tag ordered submission
      libata: micro-optimize tag allocation


 drivers/ata/libahci.c     |    2 +-
 drivers/ata/libata-core.c |   56 ++++++++++++++++++++++++++-------------------
 drivers/ata/libata-sff.c  |    2 +-
 drivers/ata/sata_sil24.c  |    2 +-
 include/linux/libata.h    |    4 ++-
 5 files changed, 37 insertions(+), 29 deletions(-)
