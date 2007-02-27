From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA Problem: port is slow to respond
Date: Tue, 27 Feb 2007 23:42:51 +0900
Message-ID: <45E4436B.9090102@gmail.com>
References: <200702161050.51523.sigmund.lkml@synflood.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:21439 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbXB0Omy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 09:42:54 -0500
Received: by an-out-0708.google.com with SMTP id b33so1137532ana
        for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 06:42:53 -0800 (PST)
In-Reply-To: <200702161050.51523.sigmund.lkml@synflood.homelinux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sigmund Scheinbar <sigmund.lkml@synflood.homelinux.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Sigmund Scheinbar wrote:
> The following messages appear while booting/in dmesg [1]: 
> 
> [...]
> ata2: port is slow to respond, please be patient (Status 0x80)
> ata2: port failed to respond (30 secs, Status 0x80)
> ata2: softreset failed (device not ready)
> ata2: softreset failed, retrying in 5 secs
> ata2: port is slow to respond, please be patient (Status 0x80)
> ata2: port failed to respond (30 secs, Status 0x80)
> ata2: COMRESET failed (device not ready)
> ata2: hardreset failed, retrying in 5 secs
> ata2: port is slow to respond, please be patient (Status 0x80)
> ata2: port failed to respond (30 secs, Status 0x80)
> ata2: COMRESET failed (device not ready)
> ata2: reset failed, giving up

It seems whatever device connected to that ata2 went out for lunch and
never returned.

> A further issue which -  imho is coupled w/ this one - is that my 
> cd/dvd+rw (also sata) combo drive does not work: 
> firstly there is no indication in dmesg that it was found and 
> secondly it behaves like dead: it does not open if i press the 
> button and it does not blink; it can be opened until
> these message appear on the screen. I need to unplug and the replug
> it after shutting down/reboot so that on the next bootup the bios 
> is able to find it (else it would still behave like dead)! 
> The drive itself is ok i guess (a least it works fine on a differen OS).

Is it happen to be a samsung one?

> [8.5.] PCI information ('lspci -vvv' as root)
> 
> http://wieland.homelinux.org/hp_dc5750/lspci-vvv.txt

Your webserver is timing out.

> Also it seems that the System is not capeable of recongnizing 
> the HDD:
> hdparm -i /dev/sda
> HDIO_GET_IDENTITY failed: Inappropriate ioctl for device

This will work from 2.6.21; however, "hdparm -I" works now and is the
preferred way to get ID data.

> I tried several kernel version in the meantime, starting w/
> the standard debian testing i386 kernel, then tried different 
> vanilla versions 2.6.18.6, 2.6.19, 2.6.19.3 which are all 
> affected in the same way. However 2.6.20 behaves 
> differtly: there is another error message which scrolls over
> the screen so fast that i'm not able to read it, the only 
> thing i was able to catch that it also concerns (s)ata, looking like
> 'ata2.0: [...] failed [...]' 

Any chance you can post dmesg from 2.6.20?  Does it fail to detect the
device your root partition resides?

-- 
tejun
