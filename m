From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: request_queue_t depends on CONFIG_BLOCK
Date: Fri, 23 Mar 2007 21:29:29 +0100
Message-ID: <200703232129.29331.bzolnier@gmail.com>
References: <20070322215234.GA13219@aepfle.de> <200703231929.19406.bzolnier@gmail.com> <20070323191428.GA23413@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:7797 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbXCWUVq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 16:21:46 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1132413uga
        for <linux-ide@vger.kernel.org>; Fri, 23 Mar 2007 13:21:45 -0700 (PDT)
In-Reply-To: <20070323191428.GA23413@aepfle.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Friday 23 March 2007, Olaf Hering wrote:
> On Fri, Mar 23, Bartlomiej Zolnierkiewicz wrote:
> 
> > > Because it is needed in a few places.
> > 
> > Is there really any PPC64 specific code which needs <linux/ide.h>
> > (ppc_ide_md is used only by PPC32)?

I suspect that the answer to my question is "not really", if so then
shouldn't the problem that you've encountered be fixed with a one-line patch
which removes <linux/ide.h> include from arch/powerpc/kernel/setup_64.c?

Please try it.

> This is about CONFIG_BLOCK=n, not about arch/... Is all non-driver
> code which has to poke into ide code supposed to put an #ifdef
> CONFIG_IDE around #include <linux/ide.h>?

Such code is _broken_ (as you've just found out) by _implicitly_ depending
on CONFIG_IDE specific data structures and functions.  Please note that
<linux/ide.h> is CONFIG_IDE specific and CONFIG_IDE depends on CONFIG_BLOCK=y
so <linux/ide.h> should _not_ be included et all for CONFIG_BLOCK=n case...

PS IDE subsystem has allowed per arch/platform host drivers for years and if
somebody needs help in fixing the existing arch/... (ab)users of <linux/ide.h>
I'll be glad to provide it.

Thanks,
Bart
