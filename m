From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [KERNEL 2.6.26-rc4]  bugreport : pata_pcmcia with Sandisk
	Extreme III 8GB
Date: Wed, 11 Jun 2008 09:20:29 +0200
Message-ID: <20080611072029.GB28692@comet.dominikbrodowski.net>
References: <20080528225049.9a134e0d.Kristoffer.Ericson@Gmail.com> <20080528222740.GB20893@isilmar.linta.de> <20080530135728.be02d3dc.Kristoffer.Ericson@Gmail.com> <20080607223716.7d142072.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:36134 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759083AbYFKPuk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Jun 2008 11:50:40 -0400
Content-Disposition: inline
In-Reply-To: <20080607223716.7d142072.komurojun-mbn@nifty.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>, Tejun Heo <htejun@gmail.com>, jgarzik@redhat.com, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pcmcia <linux-pcmcia@lists.infradead.org>, Kristoffer Ericson <kristoffer.ericson@gmail.com>

On Sat, Jun 07, 2008 at 10:37:16PM +0900, Komuro wrote:
> On Fri, 30 May 2008 13:57:28 +0200
> Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> 
> 
> > > > pcmcia: registering new device pcmcia1.0
> > > ...
> > > > pcmcia: registering new device pcmcia1.1
> > > > 1.1: GetNextTuple: No more items
> > > > pata_pcmcia: probe of 1.1 failed with error -12
> 
> This problem is introduced at kernel 2.6.26-rc4.
> 
> The kernel 2.6.26-rc3 does not have this problem.


git-diff drivers/pcmcia is empty for 2.6.26-rc3 to 2.6.26-rc4. Therefore,
it looks like something in the ata codepaths introduced this error? Tejun,
Jeff, any ideas? (original bugreport below)

Thanks,
	Dominik

> > > Hi,
> > > 
> > > > Ive added the id123 strings for a Sandisk Extreme III 8GB.
> > > > I get this when using pcmcia->CF adapter.
> > > 
> > > > pcmcia: registering new device pcmcia1.0
> > > ...
> > > > pcmcia: registering new device pcmcia1.1
> > > > 1.1: GetNextTuple: No more items
> > > > pata_pcmcia: probe of 1.1 failed with error -12
> > > 
> > > Is that a multifunction device? It seems to me that something is broken in
> > > the device CIS, for both drives seem to be exported already by device
> > > pcmcia1.0.
> > 
> > Its a simply pcmcia->CF adapter and the CF card is a simple storage one. I got it to work through USB-adapter after replacing my
> > broken one.
> > However it still doesnt work through the pcmcia->CF adapter.
> > 
> > Im not ruling out that its broken though.
> > 
> > > 
> > > Best,
> > > 	Dominik
