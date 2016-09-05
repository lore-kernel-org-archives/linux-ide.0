From: Christoph Hellwig <hch@lst.de>
Subject: (unknown)
Date: Mon,  5 Sep 2016 17:21:44 +0200
Message-ID: <1473088905-27670-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932793AbcIEPVw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Sep 2016 11:21:52 -0400
Subject: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: dan.j.williamps@intel.com, rrichter@cavium.com, linux-ide@vger.kernel.org

Hi Tejun,

this patch converts the ahci driver to use the new PCI MSI/MSI-X
vector allocator.  Note that you need to first pull 4.8-rc4 or -rc5
into the libata for-4.9 branch as it depends on changes added to
mainline after that branch started.

