From: Mark Cooke <mpc@jts.homeip.net>
Subject: Re: 2.4.26rc1 / HPT 374 / RAID = data read corruption with disks
	onprimary channels.
Date: Wed, 31 Mar 2004 16:01:12 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1080745272.20830.13.camel@pc24.sr.bham.ac.uk>
References: <1080677057.11947.83.camel@sage.kitchen>
	 <63171.194.237.142.24.1080716884.squirrel@ncircle.nullnet.fi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:39126 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261988AbUCaPBW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Mar 2004 10:01:22 -0500
In-Reply-To: <63171.194.237.142.24.1080716884.squirrel@ncircle.nullnet.fi>
List-Id: linux-ide@vger.kernel.org
To: Tomi Orava <tomimo+linux-ide@ncircle.nullnet.fi>
Cc: linux-ide@vger.kernel.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Dear Tomi, all,

This patch appears to have cured the problems I was having.  5 loops
over a 2GB file have shown no errors in copying or differing checksums.

The only difference in testing is that I am logged in remotely, rather
than from X on the server itself, though it will be a few more hours
before I am in front of the machine again.

Thanks for the patch Andre/Tomi.  It has seemingly cured the silent disk
corruption I was seeing.

Marcelo - I'd certainly recommend this patch for 2.4.*.  2.4.26rc1 was
giving random 4-byte corruptions for me without it.

http://marc.theaimsgroup.com/?l=linux-ide&m=108071690505910&w=2

Mark

On Wed, 2004-03-31 at 08:08, Tomi Orava wrote:
> > Hi all,
> >
> > I've been having some trouble with an Abit IT7 machine.  It is a
> > pentium-4 machine, 1GB ram (passes days of all-test memtest86), 80GB
> > seagate on the ICH4 as the system disk.  4 x 160GB seagates, one on each
> > channel of the HPT374.
> 
> It seems that 2.4.26rc1 doesn't still contain the HPT374 patch which
> fixes at least some DMA-problems with that ide-chip. Perhaps you'd like
> to retest after aplying the patch Andre Hedrick posted on this list a
> short while ago ? I'm not saying it will fix your problems, but its worth
> trying.
> 
> Regards,
> Tomi Orava

