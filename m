From: Santiago Vila <sanvila@unex.es>
Subject: Re: Bug 11581
Date: Mon, 27 Oct 2008 12:58:12 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0810271242590.2778@cantor.unex.es>
References: <Pine.LNX.4.64.0810141314590.2555@cantor.unex.es>
 <9ea470500810140453m6e1f7eb6raf179ee78414e19e@mail.gmail.com>
 <Pine.LNX.4.64.0810141709450.4529@cantor.unex.es> <20081026154657.GA2578@gollum.tnic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from guadiana.unex.es ([158.49.17.23]:38065 "EHLO guadiana.unex.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbYJ0L62 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 07:58:28 -0400
In-Reply-To: <20081026154657.GA2578@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi.

Would you believe that I get compilation errors for 2.6.18?

  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `getnstimeofday':
(.text+0xec8e): undefined reference to `__umoddi3'
kernel/built-in.o: In function `do_gettimeofday':
(.text+0xed39): undefined reference to `__udivdi3'
kernel/built-in.o: In function `do_gettimeofday':
(.text+0xed56): undefined reference to `__umoddi3'
kernel/built-in.o: In function `do_timer':
(.text+0xfbe0): undefined reference to `__udivdi3'
kernel/built-in.o: In function `do_timer':
(.text+0xfbfd): undefined reference to `__umoddi3'
make[1]: *** [.tmp_vmlinux1] Error 1

This is using linux-source-2.6.18.tar.bz2 which comes with the Debian
linux-source-2.6.18 package, from which the "last working kernel" is
derived.

Now I'm going to try this:

(A) Vanilla 2.6.18 from kernel.org.

(B) A build environment based on Debian stable (I'm using testing almost
  everywhere these days).

(C) Both (A) and (B) at once.


but other ideas are welcome.

Stay tuned.
