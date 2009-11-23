From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] pata_hpt37x: add proper cable detection methods
Date: Mon, 23 Nov 2009 21:07:22 +0100
Message-ID: <200911232107.22868.bzolnier@gmail.com>
References: <200911191910.44609.bzolnier@gmail.com> <4B0AE59F.7040202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42490 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418AbZKWUIR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 15:08:17 -0500
In-Reply-To: <4B0AE59F.7040202@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 23 November 2009 08:42:23 pm Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ata/pata_hpt37x.c |   86 +++++++++++++++++++++++++++++-----------------
> >  1 file changed, 56 insertions(+), 30 deletions(-)
> 
> > Index: b/drivers/ata/pata_hpt37x.c
> > ===================================================================
> > --- a/drivers/ata/pata_hpt37x.c
> > +++ b/drivers/ata/pata_hpt37x.c
> > @@ -303,6 +303,59 @@ static unsigned long hpt370a_filter(stru
> 
>     As this driver still carries a version info, don't we need to update it?

While doing the previously mentioned PATA rework I've looked at
the ratio of patches actually updating version numbers and not
doing so.  This lead me to the same conclusions as with version
numbers in IDE drivers previously..

However this is just my opinion so if you for some reason would
like to bump version numbers of some drivers I won't complain..

--
Bartlomiej Zolnierkiewicz
