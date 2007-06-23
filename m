From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Stop mapping ROMs
Date: Sat, 23 Jun 2007 22:54:24 +0400
Message-ID: <467D6C60.5050305@ru.mvista.com>
References: <20070622142252.2ec0d148@the-village.bc.nu> <467BD5B9.3080307@ru.mvista.com> <200706231942.31049.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15251 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751167AbXFWSwn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 14:52:43 -0400
In-Reply-To: <200706231942.31049.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz

Bartlomiej Zolnierkiewicz wrote:

>>>Various old IDE drivers go mapping ROM devices for no apparent reason and
>>>without using the ROM mapping API we now have. They don't actually use

>>    Hm, do you mean the sysfs based aproach? I've tried that and somehow it 
>>failed to work for me -- that's because I deferred removing this stuff from 
>>the drivers.

> Could you elaborate a bit about sysfs based approach?

    You can see the code is in drivers/pci/pci-sysfs.c.
    I have HPT370 as PCI device 11 -- and it fails with it in this way:

root@192.168.222.8:~# ls  -l   /sys/devices/pci0000\:00/0000\:00\:0b.0/rom
-r-------  1 root root 131072 Jun 23 21:36 21:36 
/sys/devices/pci0000:00/0000:00:0b.0/rom
root@192.168.222.8:~# echo 1 > /sys/devices/pci0000\:00/0000\:00\:0b.0/rom
root@192.168.222.8:~# od  -h   /sys/devices/pci0000\:00/0000\:00\:0b.0/rom
0000000

> If it indeed doesn't work we should ping PCI people about it.

    As you can see, the file isn't empty but 'od' fails to dump anything -- 
I've just verified this still happens with the most recent i386 kernel.
I suspect this is because ROM mapping fails... :-/

>>>mapped so rather than port them lets just junk it for the next -rc1.

>>    I'd agree to the patch -- the drivers were mapping ROMs in a bad way, 
>>often using the default addresses.

> I added your ACK to the patch.

    Well, if you think it's important... :-)
    (Yeah, I've read the recent LKML thread. :-)

> Thanks,
> Bart

MBR, Sergei
