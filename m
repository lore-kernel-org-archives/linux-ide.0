From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/4] partitions/ide: improve Host Protected Area handling
Date: Tue, 2 Jun 2009 00:00:51 +0200
Message-ID: <200906020000.57884.bzolnier@gmail.com>
References: <20090531143911.7164.26834.sendpatchset@localhost.localdomain> <87f94c370906010559k4f2694cbv4023129c7b0cbc31@mail.gmail.com> <20090601140651.5261ecbb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:61789 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886AbZFAV4B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2009 17:56:01 -0400
In-Reply-To: <20090601140651.5261ecbb@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, linux-ide@vger.kernel.org, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Frans Pop <elendil@planet.nl>

On Monday 01 June 2009 15:06:51 Alan Cox wrote:
> On Mon, 1 Jun 2009 08:59:29 -0400
> Greg Freemyer <greg.freemyer@gmail.com> wrote:

[...]

> > drivers?  I mean instead of having 2 module params.
> 
> No because the modules have different names so it will always be
> ide_core.something and libata.something

Moreover "nohpa" is a per-device setting while "ignore_hpa" is a global one.

> Bartlomiej - thinking about this I question "nohpa=" because we get into
> unneccessary negatives ide_core.hpa= is one less inversion to figure out.

Actually in case of "nohpa" there are no unnecessary negatives because it
is really meant for disabling Host Protected Area only and sticking with
the current name allows us to use IDE's module parameters infrastructure
without adding some extra code/complexity.
