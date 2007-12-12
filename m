From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 17/21] ide: drop 'initializing' argument from ide_register_hw()
Date: Wed, 12 Dec 2007 22:36:45 +0100
Message-ID: <200712122236.46043.bzolnier@gmail.com>
References: <200711182331.23988.bzolnier@gmail.com> <475ED463.5050607@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:40413 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbXLLW56 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 17:57:58 -0500
Received: by ug-out-1314.google.com with SMTP id z38so724490ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 12 Dec 2007 14:57:57 -0800 (PST)
In-Reply-To: <475ED463.5050607@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>

On Tuesday 11 December 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Rename init_hwif_data() to ide_init_port_data() and export it.
> 
> > * For all users of ide_register_hw() with 'initializing' argument set
> >   hwif->present and hwif->hold are always zero so convert these host
> >   drivers to use ide_find_port()+ide_init_port_data()+ide_init_port_hw()
> >   instead (also no need for init_hwif_default() call since the setup
> >   done by it gets over-ridden by ide_init_port_data() call).
> 
>     But init_hwif_default() gets called *after* ide_init_port_data() call, at 
> least in ide_register_hw()...

This is a mistake in the patch description:

s/ide_init_port_data/ide_init_port_hw/

[ I fixed it locally ]

> > * Drop 'initializing' argument from ide_register_hw().
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/ide.c
> > ===================================================================
> > --- a/drivers/ide/ide.c
> > +++ b/drivers/ide/ide.c
> > @@ -116,7 +116,7 @@ EXPORT_SYMBOL(ide_hwifs);
> >  /*
> >   * Do not even *think* about calling this!
> >   */
> 
>     Isn't this comment being obsoleted by the patch?

It is still valid because ide_init_port_data() destroys
"hdx=" and "idex=" kernel parameters...

Thanks,
Bart
