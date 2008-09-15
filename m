From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Mon, 15 Sep 2008 23:01:32 +0900 (JST)
Message-ID: <20080915.230132.126142464.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<48CC3516.9080404@ru.mvista.com>
	<48CD7A2F.9020306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:58086 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693AbYIOOBT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Sep 2008 10:01:19 -0400
In-Reply-To: <48CD7A2F.9020306@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Mon, 15 Sep 2008 00:55:11 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >    Hum... but is it really correct to convert from/to LE order above? 
> > I'm prett sure that data is expected in LE order -- look ar 
> > ide_fix_driveid() for example...
> >
> 
>    Assuming that the IDE data words' MSB appears at offset 6 and LSB at 
> offset 7 (which would seem logical), the data is actually in BE (CPU) 
> orger, so
> mm_insw_swap() should use cpu_to_le16() and mm_outsw_swap() le16_to_cpu()...

Thanks, I see.

---
Atsushi Nemoto
