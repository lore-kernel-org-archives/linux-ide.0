From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH-RFC] Promise TX4 implement hw-bug workaround
Date: Sat, 27 Oct 2007 19:09:16 +0100
Message-ID: <20071027190916.5687fcaa@the-village.bc.nu>
References: <200710030726.l937QXuV026661@harpo.it.uu.se>
	<47035355.2040405@lxnt.info>
	<135469746.20071017143929@zonnet.nl>
	<47160601.80506@lxnt.info>
	<1785297944.20071017170444@zonnet.nl>
	<4717CB10.3080509@lxnt.info>
	<471807DF.8010100@gmail.com>
	<47191C3A.5040909@lxnt.info>
	<47194497.3040101@gmail.com>
	<471A783E.9060607@lxnt.info>
	<47233C10.4020100@lxnt.info>
	<472340D3.7090507@lxnt.info>
	<47235646.6050202@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35225 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750866AbXJ0SH0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 14:07:26 -0400
In-Reply-To: <47235646.6050202@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Alexander Sabourenkov <screwdriver@lxnt.info>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, MisterE <MisterE2002@zonnet.nl>, benh@kernel.crashing.org, jgarzik@pobox.com, jeff@garzik.org

> I can't think of a way to avoid second pass over scatterlist without
> duplicating code (ata_qc_prep() and ata_fill_sg() from libata-core.c).

This appears to be incomplete:

> +			VPRINTK("Splitting last PRD.\n");
> +
> +			ap->prd[idx - 1].flags_len -= cpu_to_le32(SG_COUNT_ASIC_BUG);
> +			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
> +			
> +			addr = le32_to_cpu(ap->prd[idx - 1].addr) + len - SG_COUNT_ASIC_BUG;
> +			len  = SG_COUNT_ASIC_BUG;
> +			ap->prd[idx].addr = cpu_to_le32(addr);
> +			ap->prd[idx].flags_len = cpu_to_le32(len);
> +			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
> +
> +			idx++;

What guarantees you have enough PRD entries to do this without changing
the limit in the structures ?

Otherwise looks good
