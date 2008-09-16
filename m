From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Tue, 16 Sep 2008 19:32:48 +0400
Message-ID: <48CFD1A0.1010508@ru.mvista.com>
References: <48CC3516.9080404@ru.mvista.com>	<20080914.220512.126760706.anemo@mba.ocn.ne.jp>	<48CF8A87.6030908@ru.mvista.com> <20080917.002034.27955909.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:20681 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752713AbYIPPcD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Sep 2008 11:32:03 -0400
In-Reply-To: <20080917.002034.27955909.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Atsushi Nemoto wrote:

>>>>   This doesn't look consistent (aside from the TX4939IDE_REG8/16 issue) 
>>>>-- mm_outsw_swap() calls cpu_to_le16() before writing 16-bit data but 
>>>>this code doesn't. So, either one of those should be wrong...

>>>Thanks, this code should be wrong.  IDE_TFLAG_OUT_DATA is totally
>>>untested...

>>   Hum, not necessarily...
>>   If the data register is BE, this should work correctly, if I don't 
>>mistake (once you fix the data register's address).

> Hmm... or ide_tf_load()/ide_tf_read() is broken for big endian MIPS ?
> (and possibly SPARC etc.)

    Probably it is. But hardly anybody cares -- as I said, that flag seems 
totally useless.

> __ide_mm_writesw(port, &data, 1) should be used instead of writew()
> for IDE_TFLAG_OUT_DATA?

MBR, Sergei
