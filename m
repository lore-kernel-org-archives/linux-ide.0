From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt3x3: Major reworking and testing
Date: Tue, 3 Jul 2007 16:49:27 +0100
Message-ID: <20070703164927.78596662@the-village.bc.nu>
References: <20070703161002.1576c39d@the-village.bc.nu>
	<468A6DDB.706@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42034 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757468AbXGCPnO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 11:43:14 -0400
In-Reply-To: <468A6DDB.706@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, 03 Jul 2007 11:40:11 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > The HPT343/345 (aka 363) is a bit of a warped device. For many setups you
> > need to access the other registers via BAR4 offsets. PIO is now rock
> > solid, DMA isn't. Unfortunately the drivers/ide hpt34x driver is
> > completely broken so doesn't help further debug.
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> OK but doesn't apply

All the patches to Andrew cc you are versus -mm tree for Andrew so they
can get tested. I'll feed you patches versus the base Linus tree at some
point in the future when I have time to resync them (probably a couple of
weeks) which should be about right for them having been tested well.

Alan
