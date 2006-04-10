From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux Question
Date: Mon, 10 Apr 2006 13:56:54 -0400
Message-ID: <443A9C66.5090705@garzik.org>
References: <2E9B8131C44AF746B1E06BF9B15A434B088E3821@mail.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35773 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932065AbWDJR46 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Apr 2006 13:56:58 -0400
In-Reply-To: <2E9B8131C44AF746B1E06BF9B15A434B088E3821@mail.siliconimage.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlos Pardo <Carlos.Pardo@siliconimage.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Carlos Pardo wrote:
> Does anyone know a way to do 64bit/32bit division in linux kernel space? I'm rewriting a lot of code to use the do_div macro in div64.h but I'm wondering if there's an easier way of doing this.  Anyone fought this problem before?

(please turn on word wrap)

Here's the whole story:

A 64/32 division is normally promoted to 64/64 when generating the asm, 
IIRC.  With gcc, on a 32-bit platform such as x86, a 64/64 division 
causes gcc to emit a function call to do the division, rather than doing 
it inline.  The 64/64 division operation on 32-bit is so expensive that 
it is done in libgcc (a shared library), rather than directly by code 
generated from the compiler.

The kernel never links with libgcc (or any other lib, such as libc), 
never uses floating point/SSE registers[1], and thus can never contain 
code that causes gcc to call libgcc functions.

Often 64/64 can be reduced manually to 64/32, but that requires the use 
of do_div() to prevent gcc from generating a call to function that does 
not exist in the kernel.

So yes, you'll have to use do_div(), if you cannot accomplish the 
division via power-of-2 shifting or similar techniques.

	Jeff



[1] well, there are rare cases such as RAID XOR
