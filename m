From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Thu, 18 Sep 2008 00:12:10 +0900 (JST)
Message-ID: <20080918.001210.51866849.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<48D02C3C.90705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:51187 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbYIQPL5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Sep 2008 11:11:57 -0400
In-Reply-To: <48D02C3C.90705@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Wed, 17 Sep 2008 01:59:24 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +		unsigned int *table = hwif->dmatable_cpu;
> >   
> 
>    s/unsigned int/__le32/ perhaps?

Yes.  And __le64 would be much better.

> > +		while (1) {
> > +			cpu_to_le64s((u64 *)table);
> >   
> 
>    Wait, PRD is already already in LE format, so this should be 
> le64_to_cpus().

OK.

> > +			if (*table & 0x80000000)
> >   
> 
>    Hum... you don't have to check that with ide_build_dmatable() 
> returning the PRD count...

Indeed.  I'll do it.  Thanks.
