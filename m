From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: [PATCH-RFC]
Date: Sat, 27 Oct 2007 17:44:51 +0400
Message-ID: <472340D3.7090507@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info> <471807DF.8010100@gmail.com> <47191C3A.5040909@lxnt.info> <47194497.3040101@gmail.com> <471A783E.9060607@lxnt.info> <47233C10.4020100@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:53436 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907AbXJ0Ny3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Oct 2007 09:54:29 -0400
In-Reply-To: <47233C10.4020100@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, MisterE <MisterE2002@zonnet.nl>, benh@kernel.crashing.org, jgarzik@pobox.com, jeff@garzik.org

Alexander Sabourenkov wrote:
> Hello.
> 
> There appears to be a hardware bug in that it chokes on scatterlist
> if the last item is larger than 164 bytes.
> 
> The patch that follows fixes my problem on 2.6.22.
> 
> I can't think of a way to avoid second pass over scatterlist without
> duplicating code (ata_qc_prep() and ata_fill_sg() from libata-core.c).
> 
> 

Sorry, this was wrong patch :(. Two days looking at vendor code must
have driven me insane. Will send the correct one asap.

-- 

./lxnt

