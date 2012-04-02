From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH 1/3] PATA host controller driver for ep93xx
Date: Mon, 02 Apr 2012 11:28:36 +0200
Message-ID: <4F797144.400@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl> <201203302018.43681.arnd@arndb.de> <4F795AD1.4070101@metasoft.pl> <201204020808.34529.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:54422 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab2DBJ2p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Apr 2012 05:28:45 -0400
In-Reply-To: <201204020808.34529.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, hsweeten@visionengravers.com, linux-ide@vger.kernel.org, joao.ramos@inov.pt, bzolnier@gmail.com

On 2012-04-02 10:08, Arnd Bergmann wrote:
> On Monday 02 April 2012, Rafal Prylowski wrote:
>>
>> I selected "PATA SFF controllers with BMDMA" list because the driver
>> inherits .ata_bmdma_port_ops (this is in libata-sff.c, which is compiled
>> only if ATA_SFF is set).
> 
> Ok, I see. Is it actually the right one to inherit from though?
> 
> You end up overriding most of the opterations that are set there again,
> the only ones that you use are:
> 
> ata_bmdma_error_handler, ata_bmdma_post_internal_cmd, ata_bmdma_qc_issue,
> ata_sff_qc_fill_rtf, ata_sff_freeze, ata_sff_thaw, ata_sff_prereset,
> ata_sff_postreset and ata_sff_error_handler.
> 
> Are you sure they are all doing the righ thing on your hardware? If
> not, it might be better to explicitly just set the ones you need and
> see if that still uses any sff functions in the end.
> 
> 	Arnd

I think that inheriting from .ata_bmdma_port_ops is quite reasonable.
Another option would be to inherit from .ata_sff_port_ops and implement
.qc_issue hook (like in pata_octeon_cf.c), but this way we end up
reimplementing the same things from libata-sff.c, IMHO. Also, I think
that it's not possible to write PATA driver without this SFF stuff
(at least for me - I'm not libata expert).
I reviewed code paths from all hooks used in ep93xx driver to make sure
that we use only ep93xx_pata_read/ep93xx_pata_write instead of ioread/iowrite.

RP
