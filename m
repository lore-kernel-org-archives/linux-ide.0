From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] move host drivers for VLB IDE controllers to staging/out
Date: Wed, 3 Feb 2010 01:08:50 +0100
Message-ID: <201002030108.50647.bzolnier@gmail.com>
References: <20100202172701.7599.2028.sendpatchset@localhost> <201002022222.29728.bzolnier@gmail.com> <4B68AE6A.8030304@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:41793 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660Ab0BCAJj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 19:09:39 -0500
In-Reply-To: <4B68AE6A.8030304@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>

On Tuesday 02 February 2010 11:59:54 pm Jeff Garzik wrote:
> On 02/02/2010 04:22 PM, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 02 February 2010 07:00:41 pm Alan Cox wrote:
> >> On Tue, 02 Feb 2010 18:27:08 +0100
> >> Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>  wrote:
> >>
> >>> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> >>> Subject: [PATCH] move host drivers for VLB IDE controllers to staging/out
> >>>
> >>> - they are for really old hardware that nobody has any longer
> >>> - they all require 'magic' parameters to work
> >>> - many controllers are also supported by pata_legacy driver
> >>>
> >>> so move them to staging/out and schedule for removal in 2.6.36
> >>> unless somebody steps in to work on them.
> >>>
> >>> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> >>
> >> Acked-by: Alan Cox<alan@linux.intel.com>
> >>
> >> When I actually tried some of the VLB bits while working on the
> >> pata_legacy stuff it was clear these hadn't been maintained/used for a
> >> very long time indeed. Most of them also are hacks doing stuff like fixed
> >> mode settings.
> >>
> >> However if the point of the old IDE code was as claimed to keep it as a
> >> 'stable' layer throwing chunks of it out doesn't strike me as in keeping
> >> with the stated plan ...
> >
> > I've always been under the impression that the claim was about adding new
> > stuff and not about removing dead code or ongoing efforts to make whole
> > kernel more maintainable.  Either way, Dave would be a much better person
> > to clarify it..
> 
> David's statements at the time were
> 
> 	I'm going to treat IDE as pure legacy, rather than as
> 	competition with the PATA drivers which is what people whould
> 	be moving over to.

I believe that the competition part was the result of misinterpretation
of the nature of large volume of changes as resulting in added features
while those changes were mainly re-organizing and shrinking the source
code size (by ~30% in total during last 3 years)..

> "pure legacy" does not usually imply accepting major changes to drivers, 
> changing APIs, and the like.

Your definition probably matches RHEL (or SLES) nicely but upstream kernel
and its APIs (i.e. block layer ones) evolve all the time.

It is impossible for any piece of kernel code to be a truly 'lone island'.

> But if IDE users are happy with this abrupt change of direction, the 
> resumption of frequent, large IDE changes, then that's their call...   I 
> would rather they just use libata, but who am I to judge?  ;-)

With atang tree they are free of this dilemma and through code sharing
they can (to some degree) use both at the same time! :-)

--
Bartlomiej Zolnierkiewicz
