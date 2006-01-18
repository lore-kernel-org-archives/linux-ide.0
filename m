From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: Re: BUG?: VIA IDE transfer-rate problem
Date: Thu, 19 Jan 2006 00:41:35 +0100
Message-ID: <200601190041.36138.pvrusb2@toplitzer.net>
References: <200601131909.07981.pvrusb2@toplitzer.net> <200601181536.16868.pvrusb2@toplitzer.net> <58cb370e0601180813pfb6baffr953e5be26223ea1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:47751 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1030461AbWARXlp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2006 18:41:45 -0500
In-Reply-To: <58cb370e0601180813pfb6baffr953e5be26223ea1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

>
> Did disabling ACPI change something?
>

No, it didn't

>
> When CPU is idle HLT instruction is used by default (for power saving).
> Probably chipset detects when CPU is entering low power mode and
> also enters low power mode.  Switching between low and normal power
> modes is slow and results in degraded performance.
>
> The question is whether/how we can program chipset to not enter
> low power mode.
>


Ok. Was just a bit digging through the sourcecode. Found a
function called disable_hlt. Some further digging.
Found in drivers/block/floppy.c a usage of disable_hlt.
It's called (if I haven't missunderstood something) 
whenever a DMA transfer is setup. enable_hlt is called
when a transfer stops/is cancled etc...

Does such thing makes sense for IDE DMA-transfers too? 
(Maybe I've missed something)


Cheers
Helmut

-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656
