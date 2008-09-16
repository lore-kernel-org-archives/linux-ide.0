From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Wed, 17 Sep 2008 00:20:34 +0900 (JST)
Message-ID: <20080917.002034.27955909.anemo@mba.ocn.ne.jp>
References: <48CC3516.9080404@ru.mvista.com>
	<20080914.220512.126760706.anemo@mba.ocn.ne.jp>
	<48CF8A87.6030908@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:55816 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbYIPPUV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Sep 2008 11:20:21 -0400
In-Reply-To: <48CF8A87.6030908@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Tue, 16 Sep 2008 14:29:27 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>    This doesn't look consistent (aside from the TX4939IDE_REG8/16 issue) 
> >> -- mm_outsw_swap() calls cpu_to_le16() before writing 16-bit data but 
> >> this code doesn't. So, either one of those should be wrong...
> >
> > Thanks, this code should be wrong.  IDE_TFLAG_OUT_DATA is totally
> > untested...
> 
>    Hum, not necessarily...
>    If the data register is BE, this should work correctly, if I don't 
> mistake (once you fix the data register's address).

Hmm... or ide_tf_load()/ide_tf_read() is broken for big endian MIPS ?
(and possibly SPARC etc.)

__ide_mm_writesw(port, &data, 1) should be used instead of writew()
for IDE_TFLAG_OUT_DATA?

---
Atsushi Nemoto
