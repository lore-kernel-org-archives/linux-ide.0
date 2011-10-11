From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cy82c693: fix PCI device selection
Date: Tue, 11 Oct 2011 15:20:40 -0400 (EDT)
Message-ID: <20111011.152040.662786307819949300.davem@davemloft.net>
References: <201110111937.32501.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:34316 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab1JKTUo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Oct 2011 15:20:44 -0400
In-Reply-To: <201110111937.32501.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 11 Oct 2011 19:37:32 +0200

> While at it remove redundant pci_get_slot() call as cy82c693_init_one()
> already takes care of keeping the reference on the second port's PCI
> device.

Please do not submit unrelated changes with a bug fix, and as IDE is
in long-term maintainence I would not accept a risky refinement like
this anyways.
