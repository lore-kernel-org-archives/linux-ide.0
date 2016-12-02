From: Christoph Hellwig <hch@lst.de>
Subject: detect and warn about ahci-remapped NVMe devices
Date: Fri,  2 Dec 2016 19:31:00 +0100
Message-ID: <1480703463-17489-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755170AbcLBSbM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2016 13:31:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: dan.j.williams@intel.com, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org

Just a small band-aid to detect the AHCI-remapped NVMe devices
for now.  Hopefully we'll eventually get a fake PCIe root port
driver ala VMD for them.

