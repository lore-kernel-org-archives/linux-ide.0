From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_hpt{37x|3x2n}: fix timing register masks
Date: Thu, 26 Nov 2009 21:51:05 +0100
Message-ID: <200911262151.05067.bzolnier@gmail.com>
References: <200911242315.52826.sshtylyov@ru.mvista.com> <20091124212006.4730aacf@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:48769 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbZKZUwE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 15:52:04 -0500
Received: by ewy19 with SMTP id 19so834911ewy.21
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2009 12:52:08 -0800 (PST)
In-Reply-To: <20091124212006.4730aacf@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

On Tuesday 24 November 2009 10:20:06 pm Alan Cox wrote:
> On Wed, 25 Nov 2009 00:15:52 +0400
> Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> 
> > These drivers inherited from the older 'hpt366' IDE driver the buggy timing
> > register masks in their set_piomode() metods. As a result, too low command
> > cycle active time is programmed for slow PIO modes.  Quite fortunately, it's
> > later "fixed up" by the set_dmamode() methods which also "helpfully" reprogram
> > the command timings, usually to PIO mode 4.
> > 
> > However, the drivers added some breakage of their own too:  the bit that they
> > set/clear to control the FIFO is wrong -- it's actually the MSB of the command
> > cycle setup time; setting it in DMA mode is also wrong as this bit is only for
> > PIO actually...
> > 
> > Fix all this and bump the drivers' versions, accounting for recenjt patches
> > that forgot to do it...

Sergei, pata_hpt37x contains another copy of ->set_{piomode,dmamode} methods
(for HPT372 and later chipsets) which also need to be updated.

> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> Acked-by: Alan Cox <alan@linux.intel.com>

--
Bartlomiej Zolnierkiewicz
