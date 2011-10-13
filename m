From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cy82c693: fix PCI device selection
Date: Thu, 13 Oct 2011 17:05:36 -0400 (EDT)
Message-ID: <20111013.170536.562162672545514574.davem@davemloft.net>
References: <201110121652.10495.bzolnier@gmail.com>
	<20111012.150207.1100668688848833225.davem@davemloft.net>
	<201110131229.09178.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:37392 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab1JMVFj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 17:05:39 -0400
In-Reply-To: <201110131229.09178.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Thu, 13 Oct 2011 12:28:54 +0200

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH v2] cy82c693: fix PCI device selection
> 
> Wrong PCI device may be selected by cy82c693_set_pio_mode() if modular
> IDE host drivers are used and there are additional IDE PCI devices
> installed in the system.  Fix it.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied.
