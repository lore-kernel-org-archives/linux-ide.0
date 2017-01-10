From: Christoph Hellwig <hch@lst.de>
Subject: libata: remove the global response buffer
Date: Tue, 10 Jan 2017 09:41:42 +0100
Message-ID: <1484037708-654-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030266AbdAJIly (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 03:41:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

Avoid the need for a global 4k buffer by allocating no response buffer
for commands that don't return data, a small on-stack one for the ATAPI
fixup, or a kmalloced one for all other emulated commands.

