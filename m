From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Wed, 2 Apr 2008 22:10:23 +0200
Message-ID: <200804022210.26736.linux@rainbow-software.org>
References: <200804021524.27222.elendil@planet.nl> <200804021833.49295.linux@rainbow-software.org> <20080402200549.GC24239@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.atlantis.sk ([80.94.52.35]:56168 "EHLO mail.atlantis.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757845AbYDBUKj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Apr 2008 16:10:39 -0400
In-Reply-To: <20080402200549.GC24239@csclub.uwaterloo.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wednesday 02 April 2008 22:05:49 Lennart Sorensen wrote:
> On Wed, Apr 02, 2008 at 06:33:46PM +0200, Ondrej Zary wrote:
> > On Wednesday 02 April 2008 15:24:26 Frans Pop wrote:
> > > Output of lspci -nn:
> > > 00:00.0 Host bridge [0600]: Toshiba America Info Systems CPU to PCI
> > > bridge [1179:0601] (rev a0)
> > > 00:04.0 VGA compatible controller [0300]: Chips and Technologies F65555
> > > HiQVPro [102c:00e5] (rev c6)
> > > 00:0b.0 USB Controller [0c03]: NEC Corporation USB [1033:0035] (rev 02)
> > > 00:11.0 Communication controller [0780]: Toshiba America Info Systems
> > > FIR Port [1179:0701] (rev 21)
> > > 00:13.0 CardBus bridge [0607]: Toshiba America Info Systems ToPIC97
> > > [1179:060f] (rev 20)
> > > 00:13.1 CardBus bridge [0607]: Toshiba America Info Systems ToPIC97
> > > [1179:060f] (rev 20)
> >
> > Looks like the controller is not a separate PCI device. Toshiba provides
> > Bus Mastering driver for Windows 95:
> > http://209.167.114.38/support/download/files_Archive/Index/windows_95_fil
> >es.htm
> >
> > So the controller probably can do DMA but it's not a standard IDE
> > controller. And looks like there's no driver in the kernel for it.
>
> I don't think that bus master package is for that machine.  The
> datasheet for it mentioned PIO4 max.  I think the BUSIDE.EXE is for
> machines with the early PIIX controller (which that particular machine
> clearly doesn't have since it has no PCI IDE controller).

I mean S320BIDE.EXE - that's for this machine only.

-- 
Ondrej Zary
