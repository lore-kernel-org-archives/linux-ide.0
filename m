From: Christoph Hellwig <hch@lst.de>
Subject: two ahci fixes from code inspection
Date: Thu, 11 Aug 2016 07:26:00 -0700
Message-ID: <1470925562-28914-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58300 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbcHKO0E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2016 10:26:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hi Tejun,

below are two things in ahci I found while converting the driver
to the new MSI / MSI-X vector allocator.

The first one looks like an obvious bug to me if we every have
these stray ports in a per-port IRQ vector setup.

The others one is more elaborate, but I think the per-port locking
is something we should do for the per-port MSI-X case just like for
the per-port MSI case.

