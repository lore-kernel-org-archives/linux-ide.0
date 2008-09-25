From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Thu, 25 Sep 2008 22:41:23 +0900 (JST)
Message-ID: <20080925.224123.74566929.anemo@mba.ocn.ne.jp>
References: <20080922.013256.128618380.anemo@mba.ocn.ne.jp>
	<48DA2543.4050304@ru.mvista.com>
	<48DA8658.2040107@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:56556 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbYIYNk6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Sep 2008 09:40:58 -0400
In-Reply-To: <48DA8658.2040107@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: bzolnier@gmail.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Wed, 24 Sep 2008 22:26:32 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >   Frankly speaking, I couldn't make out much of tht passage:
> 
> > <CAUSION>
> > The write to the register by the Device/Head register may cause an 
> > unexpected function by write wrong
> > data to the register. So please rewrite to the System Control register 
> > after write to the Device/Head
> > register to secure write to System Control register in ATA100 Core.
> 
>     I thought that this was related to loading the correct transfer mode for 
> the selected drive. But if it's not only that, it would be quite pointless to 
> also implement selectproc() method if you have to hook the tf_load() method...

Hmm, indeed.  I'will try to get rid of selectproc.

---
Atsushi Nemoto
