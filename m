From: Christoph Hellwig <hch@lst.de>
Subject: libata: a fix and a cleanup
Date: Sat,  3 Oct 2015 19:21:09 +0200
Message-ID: <1443892871-10413-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44343 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbbJCRZE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Oct 2015 13:25:04 -0400
Received: from [83.175.99.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1ZiQYG-0001eU-Q2
	for linux-ide@vger.kernel.org; Sat, 03 Oct 2015 17:24:53 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The first patch fixes order of command completion vs tag freeing, and the
second is a trivial cleanup of something I noticed while digging into that
area.

