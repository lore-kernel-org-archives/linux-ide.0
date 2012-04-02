From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] PATA host controller driver for ep93xx
Date: Mon, 2 Apr 2012 10:24:05 +0000
Message-ID: <201204021024.05497.arnd@arndb.de>
References: <4F7418E7.4060500@metasoft.pl> <201204020808.34529.arnd@arndb.de> <4F797144.400@metasoft.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53199 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab2DBKcj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Apr 2012 06:32:39 -0400
In-Reply-To: <4F797144.400@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>
Cc: linux-arm-kernel@lists.infradead.org, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, hsweeten@visionengravers.com, linux-ide@vger.kernel.org, joao.ramos@inov.pt, bzolnier@gmail.com

On Monday 02 April 2012, Rafal Prylowski wrote:
> I think that inheriting from .ata_bmdma_port_ops is quite reasonable.
> Another option would be to inherit from .ata_sff_port_ops and implement
> .qc_issue hook (like in pata_octeon_cf.c), but this way we end up
> reimplementing the same things from libata-sff.c, IMHO. Also, I think
> that it's not possible to write PATA driver without this SFF stuff
> (at least for me - I'm not libata expert).
> I reviewed code paths from all hooks used in ep93xx driver to make sure
> that we use only ep93xx_pata_read/ep93xx_pata_write instead of ioread/iowrite.
> 
Ok, thanks for the confirmation.

	Arnd

