From: Willy Tarreau <w@1wt.eu>
Subject: Re: SATA 2.4 ICH8
Date: Mon, 19 May 2008 22:26:25 +0200
Message-ID: <20080519202625.GC5108@1wt.eu>
References: <480B925B.1080408@sbcglobal.net> <20080424221143.GB20775@1wt.eu> <48311942.8000407@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:4504 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763449AbYESU1U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 16:27:20 -0400
Content-Disposition: inline
In-Reply-To: <48311942.8000407@sbcglobal.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: steve@conceptoverdrive.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Steve,

On Sun, May 18, 2008 at 11:08:02PM -0700, Steve Rosenbluth wrote:
> Hello Willie,
> 
> Attached is the patch you asked for (ICH8 SATA controller definition).

OK thanks, I'm queueing it for 2.4.37.

> I have also supplied two other patches for 2.4.36.4
> 
> From the enclosed README :
> 
> "The following patches are for kernel 2.4.36.4 sources
> obtained from kernel.org :
> 
> intel_sata_ich8.patch
> This patches drivers/scsi/ata_piix.c
> It allows the kernel to access a SATA drive on an Intel ICH8 controller
> using the ich7 driver. This has been tested and it seems quite stable.
> 
> sigset_cast.patch
> This patches include/linux/signal.h
> There is an implicit cast from an integer to an
> unsigned long (sigset_t) which causes compilers to generate warnings.
> Different compilers could possibly produce different code.
> This change has been tested over several years of use and is stable.

OK, it makes sense. Another solution could have been to use ~0 instead of
(unsigned long)-1, but at least using -1 is easier to match with other
places. It would be kind to send the same patch for 2.6-mainline too.

> processor_colons_gcc-2.95.3.patch
> This patches include/asm/processor.h
> Sometime between 2.4.29 and 2.4.36.2 spaces were deleted between colons
> which causes compiler gcc 2.95.3 to fail to parse the header
> when compiling applications which include it.
> Adding back the spaces solves the problem on gcc 2.95.3.

Amusing. Interestingly, I mostly build my kernels with 2.95.3 too and never
got this funny thing. But I think that 2.95.3 has existed in so many flavors
that all we know is that it's based on some 2.95.[234] + more or less a ton
of patches.

> gcc 4.1.1 also compiles the kernel OK with this patch."

I have no worries about this :-)

OK, I'm queueing your patches.

Thanks Steve!
Willy

