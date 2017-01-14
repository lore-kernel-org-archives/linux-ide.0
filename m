From: Christoph Hellwig <hch@lst.de>
Subject: command emulation fix
Date: Sat, 14 Jan 2017 17:50:01 +0100
Message-ID: <1484412602-11801-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdANRRV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2017 12:17:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Of course we can't just do a blind GFP_NOIO from ->queuecommand,
mea culpa.  For most of the commands GFP_ATOMIC should be absolutely
fine as they are only called from the probe path.  If you're
paranoid TRIM might want a sector-sized mempool, but other common
drivers like NVMe rely on plain GFP_ATOMIC allocations for those
as well.  Let me know, and I'll send a mempool patch on top of it.

