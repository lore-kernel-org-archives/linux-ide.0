From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 01:30:38 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.SOL.4.30.0308070129050.19328-100000@mion.elka.pw.edu.pl>
References: <200308070116.18108.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200308070116.18108.fsdeveloper@yahoo.de>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Willy Gardiol <gardiol@libero.it>
List-Id: linux-ide@vger.kernel.org


On Thu, 7 Aug 2003, Michael Buesch wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Thursday 07 August 2003 01:01, Bartlomiej Zolnierkiewicz wrote:
> > Please send dmesg and .config.
>
> I've attached them to this mail.

After removing CONFIG_IDEDMA_IVB=y from your config
"Speed warnings" should go away.

--
Bartlomiej
