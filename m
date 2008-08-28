From: Frans Pop <elendil@planet.nl>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive on QNAP TS-109
Date: Thu, 28 Aug 2008 20:03:34 +0200
Message-ID: <200808282003.35663.elendil@planet.nl>
References: <200808261045.33241.elendil@planet.nl> <200808281911.28484.elendil@planet.nl> <da824cf30808281026x1dde9a5bl1dd779b99b2c2789@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml15.kpnxchange.com ([213.75.38.115]:26918 "EHLO
	hpsmtp-eml15.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752690AbYH1SDk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 14:03:40 -0400
In-Reply-To: <da824cf30808281026x1dde9a5bl1dd779b99b2c2789@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: saeed bishara <saeed.bishara@gmail.com>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>, Harald Welte <laforge@gnumonks.org>

On Thursday 28 August 2008, Grant Grundler wrote:
> On Thu, Aug 28, 2008 at 10:11 AM, Frans Pop <elendil@planet.nl> wrote:
> > On Thursday 28 August 2008, saeed bishara wrote:
> >> can you try setting bit 0 of the 0xf108002c then run some io?
> >
> > Tried that using Grant's suggestion (thanks!), but setting the bit
> > does not seem to take:
> >
> > $ sudo mmio_rd f108002c 1
> > 0x0000000000000000
> > $ sudo mmio_wr f108002c 1
> > 0000000000000000 -> 0000000000000001
> > $ sudo mmio_rd f108002c 1
> > 0x0000000000000000
> >
> > Am I doing something wrong here?
>
> Dunno. Is this a 64-bit kjernel?

No, it's a 32-bit armel kernel.
