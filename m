From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller
 using libata
Date: Thu, 16 Nov 2006 23:46:01 +0000
Message-ID: <20061116234601.78325642@localhost.localdomain>
References: <11637151391017-git-send-email-tnt@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:24495 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1424590AbWKPXkv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Nov 2006 18:40:51 -0500
In-Reply-To: <11637151391017-git-send-email-tnt@246tNt.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Linux PPC Embedded <linuxppc-embedded@ozlabs.org>, Linux IDE <linux-ide@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Nicolas DET <nd@bplan-gmbh.de>, Sven Luther <sl@bplan-gmbh.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, John Rigby <jcrigby@gmail.com>, Sylvain Munaut <tnt@246tNt.com>

On Thu, 16 Nov 2006 23:12:19 +0100
Sylvain Munaut <tnt@246tNt.com> wrote:

> * The manual states we should check for the TIP bit before all
> PIO transaction. That's not really supported by libata and requires
> reimplementing almost all the hooks. But after talking to Freescale,
> it turnsout it's not really necessary. So this driver doesn't implement
> that check. I noticed no problem so far ...
>

All PIO transactions meaning each PIO command sequence or each register
read/write ? In the former case is it not enough just to wrap the command
write ?

> * This driver doesn't use the standard function to compute timing
> because the 5200 needs more timing parameters that are not handled
> by the generic call (ta and t4).

I'd rather the generic code was taught to compute any extra times you
need but it seems clean enough.

