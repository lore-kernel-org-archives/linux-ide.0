From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH-RFC] Promise TX4 implement hw-bug workaround
Date: Sun, 28 Oct 2007 06:29:32 -0400
Message-ID: <4724648C.9080409@garzik.org>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info> <471807DF.8010100@gmail.com> <47191C3A.5040909@lxnt.info> <47194497.3040101@gmail.com> <471A783E.9060607@lxnt.info> <47233C10.4020100@lxnt.info> <472340D3.7090507@lxnt.info> <47235646.6050202@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59677 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbXJ1K3g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Oct 2007 06:29:36 -0400
In-Reply-To: <47235646.6050202@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, MisterE <MisterE2002@zonnet.nl>, benh@kernel.crashing.org, jgarzik@pobox.com

BTW, looking at the Promise code I see

> cam_con.h:
> /* for ASIC bug, limit the last element of SG byteCount must < 32 Dword */
> #define SG_COUNT_ASIC_BUG       32
> //#define SG_COUNT_ASIC_BUG     128

	and in the code itself

> /* check PRD table, last element <= (32 Dword), fix ASIC bug */

(though the code obviously uses SG_COUNT_ASIC_BUG==32, as the first 
paste indicates)

so it seems like Promise first used 128 (32 dwords), but then backed 
down to 32 (8 dwords).

Either way, we definitely have an ASIC bug to work around, it seems...

	Jeff



