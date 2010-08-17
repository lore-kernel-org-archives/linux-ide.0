From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] pata_winbond: fix module init
Date: Tue, 17 Aug 2010 08:29:40 +0200
Message-ID: <20100817062830.GF645@bicker>
References: <20100803152549.GQ26313@bicker> <201008162123.03208.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63612 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab0HQGaE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 02:30:04 -0400
Content-Disposition: inline
In-Reply-To: <201008162123.03208.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Mon, Aug 16, 2010 at 09:23:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Dan,
> 
> On Tuesday 03 August 2010 05:27:47 pm Dan Carpenter wrote:
> > winbond_init_one() returns 0 on success and an error code on failure.
> > In the original code, we always just released the regions and return
> > -ENODEV.  This was introduce in 2006 by 7e45b0e5f6f6 "[PATCH] libata:
> > Winbond support".
> 
> You might like to pick up
> 
> 	http://patchwork.ozlabs.org/patch/39358/
> 
> instead..
> 

I don't have the hardware, but yes, probably it's better to replace this
driver since it has never been able to load.

regards,
dan carpenter

