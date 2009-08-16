From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] at91_ide: remove headers specific for at91sam9263
Date: Sat, 15 Aug 2009 18:55:25 -0700 (PDT)
Message-ID: <20090815.185525.02497521.davem@davemloft.net>
References: <1250330561-10975-1-git-send-email-geomatsi@gmail.com>
	<200908151615.52689.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53704
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752032AbZHPBzN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Aug 2009 21:55:13 -0400
In-Reply-To: <200908151615.52689.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stf_xl@wp.pl
Cc: geomatsi@gmail.com, linux-ide@vger.kernel.org

From: Stanislaw Gruszka <stf_xl@wp.pl>
Date: Sat, 15 Aug 2009 16:15:52 -0400

> On Saturday 15 August 2009 06:02, Sergey Matyukevich wrote:
>> This driver requires only static memory controller definitions and macroses
>> contained in generic header at91sam9_smc.h.
>> 
>> Those extra headers are misleading since this driver also works fine for
>> at91sam9260 SoC: tests were performed on afeb9260 board.
>> 
>> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> 
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Applied to ide-next-2.6, thanks!
