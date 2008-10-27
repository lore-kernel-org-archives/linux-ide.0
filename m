From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: Bug 11581
Date: Mon, 27 Oct 2008 14:02:01 +0100
Message-ID: <9ea470500810270602q319b22ecse219f390357d3ed1@mail.gmail.com>
References: <Pine.LNX.4.64.0810141314590.2555@cantor.unex.es>
	 <9ea470500810140453m6e1f7eb6raf179ee78414e19e@mail.gmail.com>
	 <Pine.LNX.4.64.0810141709450.4529@cantor.unex.es>
	 <20081026154657.GA2578@gollum.tnic>
	 <Pine.LNX.4.64.0810271242590.2778@cantor.unex.es>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:49764 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbYJ0NCE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 09:02:04 -0400
Received: by gxk9 with SMTP id 9so2248069gxk.13
        for <linux-ide@vger.kernel.org>; Mon, 27 Oct 2008 06:02:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0810271242590.2778@cantor.unex.es>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Santiago Vila <sanvila@unex.es>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi,

On Mon, Oct 27, 2008 at 12:58 PM, Santiago Vila <sanvila@unex.es> wrote:
> Hi.
>
> Would you believe that I get compilation errors for 2.6.18?
>
>  CC      arch/i386/lib/strstr.o
>  CC      arch/i386/lib/usercopy.o
>  AR      arch/i386/lib/lib.a
>  GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
> kernel/built-in.o: In function `getnstimeofday':
> (.text+0xec8e): undefined reference to `__umoddi3'
> kernel/built-in.o: In function `do_gettimeofday':
> (.text+0xed39): undefined reference to `__udivdi3'
> kernel/built-in.o: In function `do_gettimeofday':
> (.text+0xed56): undefined reference to `__umoddi3'
> kernel/built-in.o: In function `do_timer':
> (.text+0xfbe0): undefined reference to `__udivdi3'
> kernel/built-in.o: In function `do_timer':
> (.text+0xfbfd): undefined reference to `__umoddi3'
> make[1]: *** [.tmp_vmlinux1] Error 1
>
> This is using linux-source-2.6.18.tar.bz2 which comes with the Debian
> linux-source-2.6.18 package, from which the "last working kernel" is
> derived.

I bet they've got some patches ontop of the vanilla kernel which do
64-bit division...

> Now I'm going to try this:
>
> (A) Vanilla 2.6.18 from kernel.org.

I think that'll be enough to try.

-- 
Regards/Gruss,
Boris
