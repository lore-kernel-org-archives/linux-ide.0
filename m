From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
Date: Mon, 09 Feb 2009 01:53:21 +0900 (JST)
Message-ID: <20090209.015321.25909754.anemo@mba.ocn.ne.jp>
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
	<498EC5BA.4080002@ru.mvista.com>
	<498EC790.9070403@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:53649 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbZBHQxX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Feb 2009 11:53:23 -0500
In-Reply-To: <498EC790.9070403@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Sun, 08 Feb 2009 14:52:48 +0300, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >> +    __ide_flush_dcache_range((unsigned long)buf, count * 2);
> >> +}
> >
> >   Atsushi, does TX49 really suffer from the issue that these flushes 
> > are trying to address?
> 
>    Well, looking thru the TX4939 thread, it appears that I've asked this 
> question already. Isn't this related to VIVT caches?

No, TX49 has VIPT cache.  It is related to D-cache aliasing on PIO.
My first attempt to fix this issue goes back to 2004:

http://www.linux-mips.org/archives/linux-mips/2004-03/msg00185.html

And more generic lengthy discussion can be found on (as mentioned in
the previous tx4939 thread):

http://lkml.org/lkml/2006/1/13/156

---
Atsushi Nemoto
