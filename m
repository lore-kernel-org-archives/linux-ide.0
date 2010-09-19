From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA IDE is slower in newer versions of kernel
Date: Sun, 19 Sep 2010 01:59:03 +0100
Message-ID: <20100919015903.49606426@lxorguk.ukuu.org.uk>
References: <00d401cb55f7$33a78210$9af68630$@com>
	<20100917154732.330c4b1b@varda>
	<010901cb5754$ae6735a0$0b35a0e0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40792 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753661Ab0ISAg6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Sep 2010 20:36:58 -0400
In-Reply-To: <010901cb5754$ae6735a0$0b35a0e0$@com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joshua Hintze <joshh@imsar.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> I'm dedicated to continue working on the problem, I just need to advice from the linux community. I've tried different I/O schedulers such as noop and anticipatory and I'm studying the ide-dma code but still lost to where this is happening.

drivers/ide is pretty much obsolete - so what you are seeing is doubly
odd. Most stuff now is using the newer drivers/ata code which can support
SATA, NCQ etc unlike the old codebase.

One thing to check would be whether using the drivers/ata code shows the
same problem.

Alan
