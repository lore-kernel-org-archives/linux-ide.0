From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 16:52:04 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <407EA194.20904@gmx.de>
References: <200404150236.05894.kos@supportwizard.com> <200404151826.54488.kos@supportwizard.com> <1082039593.19568.75.camel@lotte.street-vision.com> <200404151848.05857.kos@supportwizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:40107 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264273AbUDOOwI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Apr 2004 10:52:08 -0400
In-Reply-To: <200404151848.05857.kos@supportwizard.com>
List-Id: linux-ide@vger.kernel.org
To: Konstantin Sobolev <kos@supportwizard.com>
Cc: Justin Cormack <justin@street-vision.com>, Ryan Geoffrey Bourgeois <rgb005@latech.edu>, Kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Konstantin Sobolev wrote:
> On Thursday 15 April 2004 18:33, Justin Cormack wrote:
> 
>>On Thu, 2004-04-15 at 15:26, Konstantin Sobolev wrote:
>>
>>>On Thursday 15 April 2004 18:00, Justin Cormack wrote:
>>>
>>>>hmm, odd. I get 50MB/s or so from normal (7200, 8MB cache) WD disks,
>>>>and Seagate from the same controller. Can you send lspci,
>>>>/proc/interrupts and dmesg...
>>>
>>>Attached are files for 2.6.5-mm5 with highmem, ACPI and APIC turned off.
>>
>>ah. Make a filesystem on it and mount it and try again. I see you have
>>no partition table and so probably no filesystem. This means the block
>>size is set to default 512byte not 4k which makes disk operations slow.
>>Any filesystem should default to block size of 4k, eg ext2.
> 
> 
> Very interesting!
> created partition table,
> kos sata # mkfs.ext2 /dev/sda1
> [..skipped..]
> kos mnt # cd /
> kos / # mkdir wd
> kos / # mount /dev/sda1 /wd
> kos / # hdparm -t -a8192 /dev/sda

[snip]

> So first time it gave the same loosy 27 MB/s and subsequent tests give pretty 
> good 68 MB/s! Why?

I once reported that to lkml but got no reaction. siimage.c doesn't show 
this behaviour.

Prakash
