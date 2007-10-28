From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: [PATCH-RFC] Promise TX4 implement hw-bug workaround
Date: Sun, 28 Oct 2007 14:52:30 +0300
Message-ID: <472477FE.3000701@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl> <4717CB10.3080509@lxnt.info> <471807DF.8010100@gmail.com> <47191C3A.5040909@lxnt.info> <47194497.3040101@gmail.com> <471A783E.9060607@lxnt.info> <47233C10.4020100@lxnt.info> <472340D3.7090507@lxnt.info> <47235646.6050202@lxnt.info> <4724648C.9080409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:62281 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbXJ1LCL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Oct 2007 07:02:11 -0400
In-Reply-To: <4724648C.9080409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, MisterE <MisterE2002@zonnet.nl>, benh@kernel.crashing.org, jgarzik@pobox.com

Jeff Garzik wrote:
> BTW, looking at the Promise code I see
> 
>> cam_con.h:
>> /* for ASIC bug, limit the last element of SG byteCount must < 32
>> Dword */
>> #define SG_COUNT_ASIC_BUG       32
>> //#define SG_COUNT_ASIC_BUG     128
> 
>     and in the code itself
> 
>> /* check PRD table, last element <= (32 Dword), fix ASIC bug */
> 
> (though the code obviously uses SG_COUNT_ASIC_BUG==32, as the first
> paste indicates)
> 
> so it seems like Promise first used 128 (32 dwords), but then backed
> down to 32 (8 dwords).
> 

Which version is this define from?

Both versions that are available now from their website define it at 41*4:


/* for ASIC bug, limit the last element of SG byteCount must <= 41 Dword */
#define SG_COUNT_ASIC_BUG       41*4
//#define SG_COUNT_ASIC_BUG     32
//#define SG_COUNT_ASIC_BUG     128


-- 

./lxnt








