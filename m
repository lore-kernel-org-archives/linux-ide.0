From: Aalderd Bouwman <boac@wanadoo.nl>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using ahci module
Date: Wed, 21 Jun 2006 09:25:27 +0200
Message-ID: <200606210925.27544.boac@wanadoo.nl>
References: <1149787827.4180.8.camel@anja> <4498163C.90601@gmail.com> <200606202131.12654.b.jacques@planet.nl>
Reply-To: boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp04.wanadoo.nl ([194.134.35.144]:35378 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S932464AbWFUHZa
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 03:25:30 -0400
In-Reply-To: <200606202131.12654.b.jacques@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bastiaan Jacques <b.jacques@planet.nl>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Maybe it is an idea to disable NCQ for vt8251 compile-time (kernel-option) 
until it works correctly?

On Tuesday 20 June 2006 21:31, Bastiaan Jacques wrote:
> On Tuesday 20 June 2006 17:37, Tejun Heo wrote:
> > [CC'ing Bastiaan Jacques. Hi!]
>
> Hey!
>
> > Do you happen to have a different drive which can do NCQ?
> > Preferably, one from another vendor?
>
> I've just tried it with a Maxtor drive supporting NCQ, and it didn't
> work.
>
> > AFAICS, the ahci driver is
> > doing NCQ as the AHCI spec specifies and all ICH controllers seem to
> > be quite happy with it.  I wanna know whether the problem is from the
> > specific combination of the controller and the drive or the via
> > controller needs a different programming sequence for NCQ in general.
>
> It would seem the problem is in the VIA controller. Surprise, surprise.
>
> > Bastiaan, do you know whether we need to do things differently to use
> > NCQ on vt8251?
>
> Apparently we have a hardware or firmware bug to work around, but I have
> no idea what we should be doing differently.
