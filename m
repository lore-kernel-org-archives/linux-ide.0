From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: Which disk is ata4?
Date: Thu, 30 Aug 2012 19:13:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1208301912560.27195@frira.zrqbmnf.qr>
References: <CALCETrW-LFzcHYgx=thQiuTfU8RdRBrtXwE7QboWpNrjz4An4A@mail.gmail.com> <alpine.LNX.2.01.1208301809370.25988@frira.zrqbmnf.qr> <CALCETrVBTWvvJvziAoDzdUyC10jSKHmx38qyNXxJKVVpaB+7Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from seven.inai.de ([5.9.24.206]:48277 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840Ab2H3RNR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Aug 2012 13:13:17 -0400
In-Reply-To: <CALCETrVBTWvvJvziAoDzdUyC10jSKHmx38qyNXxJKVVpaB+7Pg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bjoern Franke <bjo@nord-west.org>, Borislav Petkov <bp@alien8.de>, Tim Nufire <linux_ide_tim@ibink.com>

On Thursday 2012-08-30 18:57, Andy Lutomirski wrote:

>On Thu, Aug 30, 2012 at 9:14 AM, Jan Engelhardt <jengelh@inai.de> wrote:
>> On Thursday 2012-08-30 06:38, Andy Lutomirski wrote:
>>
>>>One of my disks went out to lunch for a while.  Logs below.
>>>
>>>[784786.047673] ata4.00: exception Emask 0x10 SAct 0x7800 SErr 0x0
>>>action 0x6 frozen
>>>
>>>Which one is it?  The only useful thing in /sys/class/ata_port/ata4 is
>>>the device symlink, which points at
>>>/sys/devices/pci0000:00/0000:00:1f.2/ata4.
>>
>> For example, ata2 here:
>>
>> $ cd /sys/devices
>> $ find . -name ata2
>> ./pci0000:00/0000:00:1f.2/ata2
>> ./pci0000:00/0000:00:1f.2/ata2/ata_port/ata2
>> $ cd ./pci0000:00/0000:00:1f.2/ata2
>> $ ls -dl host*/targ*
>> drwxr-xr-x 4 root root 0 Aug 30 18:09 host1/target1:0:0
>
>Aha!  This works on 3.5 but not on 3.2.

3.4.x here..
