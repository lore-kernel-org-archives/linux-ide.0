From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Thu, 9 Aug 2007 22:48:44 +0200
Message-ID: <200708092248.44675.bzolnier@gmail.com>
References: <200708052245.16406.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:8360 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756938AbXHIUta (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 16:49:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so165816nfb
        for <linux-ide@vger.kernel.org>; Thu, 09 Aug 2007 13:49:29 -0700 (PDT)
In-Reply-To: <200708052245.16406.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rah@bash.sh


While at it:

On Sunday 05 August 2007, Sergei Shtylyov wrote:

> Index: linux-2.6/drivers/ata/pata_hpt37x.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/pata_hpt37x.c
> +++ linux-2.6/drivers/ata/pata_hpt37x.c
> @@ -8,12 +8,10 @@

this driver is lacking author/maintainer info:

/*
 * Libata driver for the highpoint 37x and 30x UDMA66 ATA controllers.
 *
 * This driver is heavily based upon:
 *
 * linux/drivers/ide/pci/hpt366.c               Version 0.36    April 25, 2003
 *

>   * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
>   * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
>   * Portions Copyright (C) 2003		Red Hat Inc
> - * Portions Copyright (C) 2005-2006	MontaVista Software, Inc.
> + * Portions Copyright (C) 2005-2007	MontaVista Software, Inc.

reference to hpt366 version should also be updated (or removed)

>   *
>   * TODO
> - *	PLL mode
> - *	Look into engine reset on timeout errors. Should not be
> - *		required.
> + *	Look into engine reset on timeout errors. Should not be	required.
>   */
>  
>  #include <linux/kernel.h>
