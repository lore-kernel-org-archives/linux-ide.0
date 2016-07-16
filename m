From: Christoph Hellwig <hch@lst.de>
Subject: protocol flag cleanups
Date: Sat, 16 Jul 2016 22:16:40 +0900
Message-ID: <1468675003-13701-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50478 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbcGPNQr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jul 2016 09:16:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

This series contains a few cleanups for the way the ATA_PROT_* values are
handled.

