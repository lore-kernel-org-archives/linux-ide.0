From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] drivers/ide/Kconfig IDEPCI_SHARE_IRQ and IDEDISK_MULTI_MODE
Date: Mon, 22 Oct 2007 17:23:44 +0400
Message-ID: <471CA460.5040107@ru.mvista.com>
References: <604640.68715.qm@web52004.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:8891 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750937AbXJVNXf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 09:23:35 -0400
In-Reply-To: <604640.68715.qm@web52004.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matti Linnanvuori <mattilinnanvuori@yahoo.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Matti Linnanvuori wrote:

> Correct IDEPCI_SHARE_IRQ description to keeping interrupts enabled
> when calling the PCI IDE action handler.
> Add IDEPCI_SHARE_IRQ and IDEDISK_MULTI_MODE help text from hdparm
> manual page.

> Signed-off-by: Matti Linnanvuori <mattilinnanvuori@yahoo.com>

    NAK.

> @@ -154,6 +154,18 @@ config BLK_DEV_IDEDISK
>  config IDEDISK_MULTI_MODE
>  	bool "Use multi-mode by default"
>  	help
> +	  Multiple sector mode is a feature of most modern IDE hard
> + 	  drives, permitting the transfer of multiple sectors per I/O
> +	  interrupt, rather than the usual one sector per interrupt.
> +	  When this feature is enabled, it typically reduces operating
> +	  system overhead for disk I/O by 30-50%. On many systems, it
> +	  also provides increased data throughput of anywhere from 5%
> +	  to 50%. Some drives, however (most notably the WD Caviar
> +	  series), seem to run slower with multiple mode enabled. Some
> +	  drives claim to support multiple mode, but lose data at some
> +	  settings. Under rare circumstances, such failures can result

    The speed increase data provided here are largely useless, since multiple 
mode only applies to PIO transfers. At least, the comment should make this 
clear...

> +	  in massive filesystem corruption.
> +
>  	  If you get this error, try to say Y here:
>  
>  	  hda: set_multmode: status=0x51 { DriveReady SeekComplete Error }
> @@ -367,11 +379,16 @@ config BLK_DEV_IDEPCI
>  	bool
>  
>  config IDEPCI_SHARE_IRQ
> -	bool "Sharing PCI IDE interrupts support"
> +	bool "Keeping interrupts enabled when calling the PCI IDE action handler support"

    Keeping IRQ enabled is only a side effect of IRQ sharing...

>  	depends on BLK_DEV_IDEPCI
>  	help
> -	  Some ATA/IDE chipsets have hardware support which allows for
> -	  sharing a single IRQ with other cards. To enable support for
> +	  A setting of Y permits the driver to unmask other interrupts
> +	  during processing of a disk interrupt, which greatly improves
> + 	  Linux's responsiveness and eliminates "serial port overrun"
> +	  errors. Use this feature with caution: some drive/controller
> +	  combinations do not tolerate the increased I/O latencies
> +	  possible when this feature is enabled, resulting in massive
> +	  filesystem corruption. To enable support for
>  	  this in the ATA/IDE driver, say Y here.

    Comments do not really describe the IRQ sharing option anymore.

>  	  It is safe to say Y to this question, in most cases.

MBR, Sergei
