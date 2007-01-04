From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add delay around sl82c105_reset_engine calls
Date: Thu, 4 Jan 2007 10:53:45 +0000
Message-ID: <20070104105345.046e7aec@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061204124026.GB28159@aepfle.de>
	<20061204130254.424c7979@localhost.localdomain>
	<20070104064254.GA31986@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43328 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932371AbXADKnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jan 2007 05:43:24 -0500
In-Reply-To: <20070104064254.GA31986@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Thu, 4 Jan 2007 07:42:54 +0100
Olaf Hering <olaf@aepfle.de> wrote:

> On Mon, Dec 04, Alan wrote:
> 
> > On Mon, 4 Dec 2006 13:40:26 +0100 (MET)
> > Olaf Hering <olaf@aepfle.de> wrote:
> > 
> > > 
> > > 
> > > the hald media changed polling does really confuse things.
> > > noone knows why the delays are needed, but they give us access to
> > > the CD.
> > 
> > Can you tell me what happens if you completely pull the reset out of the
> > dma_end function. Do you still need delays then.
> 
> An udelay(50) will give reliable access to the drive, but there is still
> one (or more) EH reset. The drive works without EH resets with udelay(100).
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Acked-by: Alan Cox <alan@redhat.com>

This wants revisiting some day to understand the interaction better but
for now it gets us up and running properly.

