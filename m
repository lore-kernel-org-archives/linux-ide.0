From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: [PATCH-RFC] Promise TX4 implement hw-bug workaround
Date: Sun, 28 Oct 2007 23:03:37 +0300
Message-ID: <4724EB19.6030009@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se>	<47035355.2040405@lxnt.info>	<135469746.20071017143929@zonnet.nl>	<47160601.80506@lxnt.info>	<1785297944.20071017170444@zonnet.nl>	<4717CB10.3080509@lxnt.info>	<471807DF.8010100@gmail.com>	<47191C3A.5040909@lxnt.info>	<47194497.3040101@gmail.com>	<471A783E.9060607@lxnt.info>	<47233C10.4020100@lxnt.info>	<472340D3.7090507@lxnt.info>	<47235646.6050202@lxnt.info> <20071027190916.5687fcaa@the-village.bc.nu> <47238104.4000601@lxnt.info> <47244677.6030909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:50670 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbXJ1TNa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Oct 2007 15:13:30 -0400
In-Reply-To: <47244677.6030909@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, MisterE <MisterE2002@zonnet.nl>, benh@kernel.crashing.org, jgarzik@pobox.com

Jeff Garzik wrote:
> 
> Alan's point was that the existing code will give you up to
> LIBATA_MAX_PRD entries.  After the post-virtual-merge splitting code in
> ata_fill_sg() executes, the worst case result is ATA_MAX_PRD entries.
> 
> Thus, since your code has the potential to increase the number of s/g
> entries above that, it can potentially corrupt memory, lock up the
> machine, all the wonderful things that can happen when you run off the
> end of the s/g list.
> 
> The fix is to decrease .sg_tablesize (LIBATA_MAX_PRD - 2 perhaps?) so
> that you guarantee this worst case never occurs, by guaranteeing that
> the system never sends you enough s/g entries to cause your code to go
> out of bounds.
> 

Ah, now I understand. Thanks for the explanation.

I take it something guarantees that s/g entry size can not exceed 128K.


-- 

./lxnt
