From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Which disk is ata4?
Date: Thu, 30 Aug 2012 09:57:48 -0700
Message-ID: <CALCETrVBTWvvJvziAoDzdUyC10jSKHmx38qyNXxJKVVpaB+7Pg@mail.gmail.com>
References: <CALCETrW-LFzcHYgx=thQiuTfU8RdRBrtXwE7QboWpNrjz4An4A@mail.gmail.com>
 <alpine.LNX.2.01.1208301809370.25988@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60291 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab2H3Q6K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2012 12:58:10 -0400
Received: by wibhr14 with SMTP id hr14so566781wib.1
        for <linux-ide@vger.kernel.org>; Thu, 30 Aug 2012 09:58:08 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.01.1208301809370.25988@frira.zrqbmnf.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bjoern Franke <bjo@nord-west.org>, Borislav Petkov <bp@alien8.de>, Tim Nufire <linux_ide_tim@ibink.com>

On Thu, Aug 30, 2012 at 9:14 AM, Jan Engelhardt <jengelh@inai.de> wrote:
> On Thursday 2012-08-30 06:38, Andy Lutomirski wrote:
>
>>One of my disks went out to lunch for a while.  Logs below.
>>
>>[784786.047673] ata4.00: exception Emask 0x10 SAct 0x7800 SErr 0x0
>>action 0x6 frozen
>>
>>Which one is it?  The only useful thing in /sys/class/ata_port/ata4 is
>>the device symlink, which points at
>>/sys/devices/pci0000:00/0000:00:1f.2/ata4.
>
> For example, ata2 here:
>
> $ cd /sys/devices
> $ find . -name ata2
> ./pci0000:00/0000:00:1f.2/ata2
> ./pci0000:00/0000:00:1f.2/ata2/ata_port/ata2
> $ cd ./pci0000:00/0000:00:1f.2/ata2
> $ ls -dl host*/targ*
> drwxr-xr-x 4 root root 0 Aug 30 18:09 host1/target1:0:0

Aha!  This works on 3.5 but not on 3.2.  Mystery solved (except on my
poor Ubuntu LTS box that has the host directories under the pci device
instead of under the ata devices).

Consider this report solved by "fixed in newer kernel".  I thought I
had checked for that.

It would be nice if the dmesg startup logs showed the serial number
along with the model number.

--Andy
