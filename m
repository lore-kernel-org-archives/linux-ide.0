From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: How to reread disk size?
Date: Sat, 20 Feb 2010 12:37:19 -0600
Message-ID: <4B802BDF.9020509@gmail.com>
References: <4B7F234F.9000107@shiftmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f209.google.com ([209.85.217.209]:52675 "EHLO
	mail-gx0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab0BTSpd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Feb 2010 13:45:33 -0500
Received: by gxk1 with SMTP id 1so1278205gxk.19
        for <linux-ide@vger.kernel.org>; Sat, 20 Feb 2010 10:45:32 -0800 (PST)
In-Reply-To: <4B7F234F.9000107@shiftmail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Asdo <asdo@shiftmail.org>
Cc: linux-ide@vger.kernel.org

On 02/19/2010 05:48 PM, Asdo wrote:
> Hi all,
> I have a system with hot swappable bays but one of the involved
> controllers apparently does not support hot swap:
> (I have unfortunately an old kernel: 2.6.24)
>
> 00:1f.2 IDE interface: Intel Corporation 631xESB/632xESB/3100 Chipset
> SATA IDE Controller (rev 09) (prog-if 8f [Master SecP SecO PriP PriO])
> Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 19
> I/O ports at 18c8 [size=8]
> I/O ports at 18ac [size=4]
> I/O ports at 18c0 [size=8]
> I/O ports at 18a8 [size=4]
> I/O ports at 18b0 [size=16]
> Memory at da804400 (32-bit, non-prefetchable) [size=1K]
> Capabilities: [70] Power Management version 2
>
>
> I have swapped the disk with a larger one (750GB -> 1TB) but it blockdev
> --getsize64 still sees the old size. It has not realized I have swapped
> disk.
>
> In the past I was doing:
>
> blockdev --rereadpt /dev/sdX
>
> and it usually worked on other controllers to reread the size visible
> from "blockdev --getsize" or "blockdev --getsize64". One time I think it
> even worked on exactly *that* controller... but it's not working now,
> it's strange.
>
> Is there a technique, or I am out of luck?
> The machine should not be rebooted
> I would even enter the size manually if possible: I know how many LBA
> blocks are in that disk.

What dmesg output do you get when you do this?
