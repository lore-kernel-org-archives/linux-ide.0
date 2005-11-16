From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ata_port->device[] question
Date: Wed, 16 Nov 2005 10:16:07 -0500
Message-ID: <437B4D37.8040304@pobox.com>
References: <Pine.LNX.4.58.0511151328070.28745@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:43956 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030361AbVKPPQK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 10:16:10 -0500
In-Reply-To: <Pine.LNX.4.58.0511151328070.28745@shark.he.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide@vger.kernel.org

Randy.Dunlap wrote:
> libata-core.c, around line 1299, says:
> 
> static inline u8 ata_dev_knobble(const struct ata_port *ap)
> {
> 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device->id)));
> }
> 
> That's the same as this: (right?)
> 
> 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device[0]->id)));
> 	                                                                ~~~
> 
> and is this intentional?
> I.e., always using device[0] for this bridge check?

really it should be ap->device[0].id if I'm not mistaken

	Jeff



