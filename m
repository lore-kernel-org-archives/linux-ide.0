From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/17] libata: implement PCI init helpers for new LLD
	init model
Date: Wed, 09 Aug 2006 12:02:16 +0100
Message-ID: <1155121337.5729.156.camel@localhost.localdomain>
References: <1154919840689-git-send-email-htejun@gmail.com>
	 <44D96E8E.9020801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12196 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030670AbWHIKnL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 06:43:11 -0400
In-Reply-To: <44D96E8E.9020801@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Ar Mer, 2006-08-09 am 01:11 -0400, ysgrifennodd Jeff Garzik:
> > +static const unsigned long ata_legacy_addr_tbl[][2] = {
> > +	{ ATA_PRIMARY_CMD, ATA_PRIMARY_CTL },
> > +	{ ATA_SECONDARY_CMD, ATA_SECONDARY_CTL}
> > +};
> > +

NAK. I purposefully didn't do this because the defines may not be
constants. Take a look at the PPC platforms where it will eventually
have to be a call into the machine dependant function table.


