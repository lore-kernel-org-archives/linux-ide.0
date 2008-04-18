From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE allmodconfig: probe_4drives error
Date: Sat, 19 Apr 2008 01:18:22 +0200
Message-ID: <200804190118.23089.bzolnier@gmail.com>
References: <48092593.4040700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:7660 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbYDRXCV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Apr 2008 19:02:21 -0400
Received: by fg-out-1718.google.com with SMTP id l27so671823fgb.17
        for <linux-ide@vger.kernel.org>; Fri, 18 Apr 2008 16:02:19 -0700 (PDT)
In-Reply-To: <48092593.4040700@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

On Saturday 19 April 2008, Jeff Garzik wrote:
> allmodconfig on i386 from latest linux-2.6.git (the one w/ the kgdb 
> build error):
> 
> WARNING: modpost: Found 15 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>    UPD     include/linux/compile.h
>    Building modules, stage 2.
> Root device is (9, 0)
> Setup is 12536 bytes (padded to 12800 bytes).
> System is 1896 kB
> CRC 116c83e7
> Kernel: arch/x86/boot/bzImage is ready  (#1)
> ERROR: "probe_4drives" [drivers/ide/ide-core.ko] undefined!
> [...]

Heh, this is the "magical" error that Andrew hit before [1],
it will get auto-fixed by next IDE update.

[1] http://www.gossamer-threads.com/lists/linux/kernel/892459#892459

Thanks,
Bart
