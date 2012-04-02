From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] PATA host controller driver for ep93xx
Date: Mon, 2 Apr 2012 08:08:34 +0000
Message-ID: <201204020808.34529.arnd@arndb.de>
References: <4F7418E7.4060500@metasoft.pl> <201203302018.43681.arnd@arndb.de> <4F795AD1.4070101@metasoft.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63731 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab2DBIIp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Apr 2012 04:08:45 -0400
In-Reply-To: <4F795AD1.4070101@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rafal Prylowski <prylowski@metasoft.pl>, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, hsweeten@visionengravers.com, linux-ide@vger.kernel.org, joao.ramos@inov.pt, bzolnier@gmail.com

On Monday 02 April 2012, Rafal Prylowski wrote:
> > 
> > And I think this should be consequently be sorted below nonstandard ports, instead of the SFF list.
> > 
> >       Arnd
> 
> I selected "PATA SFF controllers with BMDMA" list because the driver
> inherits .ata_bmdma_port_ops (this is in libata-sff.c, which is compiled
> only if ATA_SFF is set).

Ok, I see. Is it actually the right one to inherit from though?

You end up overriding most of the opterations that are set there again,
the only ones that you use are:

ata_bmdma_error_handler, ata_bmdma_post_internal_cmd, ata_bmdma_qc_issue,
ata_sff_qc_fill_rtf, ata_sff_freeze, ata_sff_thaw, ata_sff_prereset,
ata_sff_postreset and ata_sff_error_handler.

Are you sure they are all doing the righ thing on your hardware? If
not, it might be better to explicitly just set the ones you need and
see if that still uses any sff functions in the end.

	Arnd
