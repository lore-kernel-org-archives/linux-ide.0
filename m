From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
Date: Fri, 24 Oct 2008 23:20:57 +0900 (JST)
Message-ID: <20081024.232057.85420526.anemo@mba.ocn.ne.jp>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
	<200810232247.05686.bzolnier@gmail.com>
	<4901AD8F.4000007@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:61485 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbYJXOUu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 10:20:50 -0400
In-Reply-To: <4901AD8F.4000007@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: bzolnier@gmail.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Fri, 24 Oct 2008 15:12:15 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>    I've realized that I have a question to Atsushi on why he chose the 
> same way of implemnting the register accesses as on TX4939 despite 
> TX4938 IDE is not really a SoC but a board level device (so probable 
> should be using the normal, not the "raw" I/O accessors)...

Well, because it behaves like SoC registers, not as other PCI IDE
registers (which are swapped on big endian).

Maybe new board designer can chose another option, so it might be
worth to add 'do_swap' member in tx4938ide_platform_info.  But anyway
current code just works with both endian on RBTX4938 board :-)

---
Atsushi Nemoto
