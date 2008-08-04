From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Mon, 4 Aug 2008 15:13:33 +0100
Message-ID: <20080804151333.606eaaaf@lxorguk.ukuu.org.uk>
References: <87prp1kvyy.fsf@denkblock.local>
	<20080726062142.29070.10413.stgit@denkblock.local>
	<4892B8FE.1070400@gmail.com>
	<20080804142831.GW8749@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55894 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753407AbYHDObx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 10:31:53 -0400
In-Reply-To: <20080804142831.GW8749@boogie.lpds.sztaki.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Tejun Heo <htejun@gmail.com>, Elias Oltmanns <eo@nebensachen.de>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 4 Aug 2008 16:28:32 +0200
Gabor Gombas <gombasg@sztaki.hu> wrote:

> On Fri, Aug 01, 2008 at 04:19:26PM +0900, Tejun Heo wrote:
> 
> > However, SATA or not, there simply isn't a way to abort commands in ATA.
> >  Issuing random command while other commands are in progress simply is
> > state machine violation and there will be many interesting results
> > including complete system lockup (ATA controller dying while holding the
> > PCI bus).
> 
> A system lockup may be an acceptable compromise if that saves the
> hardware. Maybe the kernel should explicitely panic unless the
> controller/drive is known to be able to recover.

We've already been told that the accelerometer will now and then randomly
trigger due to other shock patterns like a bump. I don't want my laptop
to panic randomly on train journeys thank you.

Alan
