From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: compile error if CONFIG_BLOCK not enabled related to linux/ide.h include
Date: Wed, 18 Jul 2007 12:47:26 +0200
Message-ID: <200707181247.26262.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0707172353050.29097@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.180]:63092 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbXGRKaB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 06:30:01 -0400
Received: by ik-out-1112.google.com with SMTP id b32so136867ika
        for <linux-ide@vger.kernel.org>; Wed, 18 Jul 2007 03:29:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707172353050.29097@blarg.am.freescale.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


Hi,

On Wednesday 18 July 2007, Kumar Gala wrote:
> M:      bzolnier@gmail.com
> L:      linux-ide@vger.kernel.org
> 
> We get the following compile error if CONFIG_BLOCK isn't enabled:
> 
>   CC      arch/powerpc/kernel/setup_32.o
> In file included from arch/powerpc/kernel/setup_32.c:14:
> include/linux/ide.h:558: error: expected specifier-qualifier-list before 'request_queue_t'
> include/linux/ide.h:696: warning: 'struct request' declared inside parameter list
> include/linux/ide.h:696: warning: its scope is only this definition or declaration, which is probably not what you want
> include/linux/ide.h:820: warning: 'struct request' declared inside parameter list
> include/linux/ide.h:853: error: field 'wrq' has incomplete type
> include/linux/ide.h:1205: error: expected ')' before '*' token
> make[1]: *** [arch/powerpc/kernel/setup_32.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2

include/linux/ide.h is exclusively for IDE subsystem

> What I'm trying to figure out is if include/linux/ide.h should be wrapped
> in a #if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE) or if there is
> some other desired way to handle this.

Plese remove <linux/ide.h> include, there doesn't seem to be any piece of
code in arch/powerpc/kernel/setup_32.c which needs it anyway.

Thanks,
Bart
