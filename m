From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 05/30] pcmcia - spot slave decode flaws (for testing)
Date: Tue, 6 Mar 2007 15:21:42 +0000
Message-ID: <20070306152142.1611a083@lxorguk.ukuu.org.uk>
References: <200703061037.l26AbsJI019466@shell0.pdx.osdl.net>
	<45ED5431.3040105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39134 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965045AbXCFORm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 09:17:42 -0500
In-Reply-To: <45ED5431.3040105@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@redhat.com

On Tue, 06 Mar 2007 06:44:49 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> akpm@linux-foundation.org wrote:
> > From: Alan <alan@lxorguk.ukuu.org.uk>
> > 
> > If you've got a CF adapter or PCMCIA disc which shows up twice in libata
> > pata_pcmcia can you try this patch on top of the updates posted.  It tries
> > to spot when the slave is a mirror of the master and to fix up problems
> > that causes.
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Seems same, but dropped due to "can you try this patch" comments.  Let 
> me know if this actually fixes something...

I've got two confirmations so far that this plus the "can fail set_xfer"
patch work for folks who had problems before. Also if you are unfortunate
enough to be running something like HAL then it'll automount the same
disk twice for you and corrupt it without the fix (aint that nice...)


Alan
