From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: request_queue_t depends on CONFIG_BLOCK
Date: Fri, 23 Mar 2007 19:29:19 +0100
Message-ID: <200703231929.19406.bzolnier@gmail.com>
References: <20070322215234.GA13219@aepfle.de> <20070322215351.GA7216@infradead.org> <20070323001002.GA14583@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:57641 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbXCWSVl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 14:21:41 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1109740uga
        for <linux-ide@vger.kernel.org>; Fri, 23 Mar 2007 11:21:40 -0700 (PDT)
In-Reply-To: <20070323001002.GA14583@aepfle.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Friday 23 March 2007, Olaf Hering wrote:
> On Thu, Mar 22, Christoph Hellwig wrote:
> 
> > On Thu, Mar 22, 2007 at 10:52:34PM +0100, Olaf Hering wrote:
> > > How can this compile error be fixed properly?
> > > request_queue_t is inside CONFIG_BLOCK,
> > > ide_drive_s (and likely others) use it unconditionally.
> > > 
> > > 
> > >   CC      arch/powerpc/kernel/setup_64.o
> > > In file included from linux-2.6.21-rc4/arch/powerpc/kernel/setup_64.c:23:
> > 
> > start looking for the problem here.  Why does you arch code include ide.h?
> 
> Because it is needed in a few places.

Is there really any PPC64 specific code which needs <linux/ide.h>
(ppc_ide_md is used only by PPC32)?

> Better hide everything in ide.h inside #ifdef CONFIG_IDE

<linux/ide.h> is _stricly_ for IDE subsystem, please fix PPC64 code instead

Thanks,
Bart
