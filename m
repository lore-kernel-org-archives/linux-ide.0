From: Kumar Gala <galak@kernel.crashing.org>
Subject: compile error if CONFIG_BLOCK not enabled related to linux/ide.h
 include
Date: Wed, 18 Jul 2007 00:02:46 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0707172353050.29097@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41111 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbXGRFDK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jul 2007 01:03:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

M:      bzolnier@gmail.com
L:      linux-ide@vger.kernel.org

We get the following compile error if CONFIG_BLOCK isn't enabled:

  CC      arch/powerpc/kernel/setup_32.o
In file included from arch/powerpc/kernel/setup_32.c:14:
include/linux/ide.h:558: error: expected specifier-qualifier-list before 'request_queue_t'
include/linux/ide.h:696: warning: 'struct request' declared inside parameter list
include/linux/ide.h:696: warning: its scope is only this definition or declaration, which is probably not what you want
include/linux/ide.h:820: warning: 'struct request' declared inside parameter list
include/linux/ide.h:853: error: field 'wrq' has incomplete type
include/linux/ide.h:1205: error: expected ')' before '*' token
make[1]: *** [arch/powerpc/kernel/setup_32.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

What I'm trying to figure out is if include/linux/ide.h should be wrapped
in a #if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE) or if there is
some other desired way to handle this.

This seems to stem from the fact that include/linux/blkdev.h is wrapped in
a CONFIG_BLOCK and thus request_queue_t isn't always defined.

- k


