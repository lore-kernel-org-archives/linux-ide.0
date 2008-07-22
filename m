From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: pata_it821x completely broken
Date: Tue, 22 Jul 2008 21:16:17 +0200
Message-ID: <200807222116.19077.linux@rainbow-software.org>
References: <200807042153.56644.linux@rainbow-software.org> <200807221959.53669.linux@rainbow-software.org> <20080722191022.0417f45c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.atlantis.sk ([80.94.52.35]:44090 "EHLO mail.atlantis.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbYGVTQ0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jul 2008 15:16:26 -0400
In-Reply-To: <20080722191022.0417f45c@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tuesday 22 July 2008 20:10:22 Alan Cox wrote:
> > New patch below, this time with DMA forced on RAID volumes - as my
> > firmware does not identify the RAID arrays as DMA capable :(
>
> The underlying problem is that the newer libata rewrites the dev->id data
> in ways that we can't then patch up. I've actually been hacking on this a
> bit today. The existing it821x code was working fine and it does the
> needed patching, it just needs to do it in a different place, and that in
> turn needs a new ap->ops->read_id() method so it can be hooked.

I can test the code once it's done.
I just moved my / to the RAID1 provided by IT8212. The controller has a great 
feature that allows converting a drive between RAID1/standalone without data 
loss (haven't seen anything like this yet). Also the background rebuild is 
nice (as seen on much more expensive RAID controllers), it's running as I'm 
typing this.

>
> On the bright side that also allows us to implement a pata_mfm/rll
> driver at last.
>

I used to have an old drive that was something like that - 5.25" Seagate 40MB 
drive. I sold it including the controller a couple of years ago (it was still 
working) so no testing fun for me.

> Alan



-- 
Ondrej Zary
