From: Tejun Heo <htejun@gmail.com>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710,
 pcmcia based sata_sil24, PMP, and NCQ drive
Date: Sun, 03 Sep 2006 21:03:22 +0200
Message-ID: <44FB26FA.4070704@gmail.com>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org> <44F440BE.80000@gmail.com> <20060829164424.GA1603@geeks.org> <44F8365C.2020609@gmail.com> <20060901172435.GA26975@geeks.org> <20060902053459.GA4467@geeks.org> <20060903062653.GA4340@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:22759 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932130AbWICTDe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Sep 2006 15:03:34 -0400
Received: by py-out-1112.google.com with SMTP id n25so2271221pyg
        for <linux-ide@vger.kernel.org>; Sun, 03 Sep 2006 12:03:33 -0700 (PDT)
In-Reply-To: <20060903062653.GA4340@geeks.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derek Taubert <taubert@geeks.org>
Cc: linux-ide@vger.kernel.org

Derek Taubert wrote:
> On Fri, Sep 01, 2006 at 10:34:59PM -0700, Derek Taubert wrote:
>> I'm now suspecting that the performance problems are due to bus issues
>> on the PCMCIA/PCI side.  Will poke around there and maybe try this with
>> a different laptop...
> 
> Found the problem!!!!

Great.

> The Cache Line Size field in the 3124 PCI Config Space needed to be
> set properly.  I suspect that this caused the 3124 DMA engine to issue
> non-burst reads for all data going toward the disk.  Since my old
> laptop has two bridges between host memory and the 3124, it surely made
> for some long read latencies (and thus very bad throughput).
> 
> Before:
> root@linux-srv:~ # od -Ax -t x4 /sys/bus/pci/devices/0000:06:00.0/config
> 000000 31241095 02b00087 01800001 00004000
> 000010 16008004 00000000 16000004 00000000
> 000020 00001c01 00000000 00000000 31241095
> 000030 00000000 00000064 00000000 0000010a
> 000040 00525407 12c3fff8 00000000 00000000
> 000050 00000000 00800005 00000000 00000000
> 000060 00000000 06224001 19002000 00000000
> 000070 00000000 00000000 00000000 00000000
> 
> I copied /sys/bus/pci/devices/0000:06:00.0/config to a temp file, used
> bvi to edit it, and then copied it back using dd:
> dd if=/tmp/sil24_config of=/sys/bus/pci/devices/0000:06:00.0/config bs=4 skip=3 seek=3 count=1 conv=notrunc
> 
> After:
> root@linux-srv:~ # od -Ax -t x4 /sys/bus/pci/devices/0000:06:00.0/config
> 000000 31241095 02b00087 01800001 00004008
> 000010 16008004 00000000 16000004 00000000
> 000020 00001c01 00000000 00000000 31241095
> 000030 00000000 00000064 00000000 0000010a
> 000040 00525407 12c3fff8 00000000 00000000
> 000050 00000000 00800005 00000000 00000000
> 000060 00000000 06224001 19002000 00000000
> 000070 00000000 00000000 00000000 00000000
> 
> root@linux-srv:~ # dd if=/dev/zero of=/dev/sda1 bs=1M count=1000
> 1000+0 records in
> 1000+0 records out
> 1048576000 bytes (1.0 GB) copied, 16.7798 seconds, 62.5 MB/s
> 
> Phew!  I was just about to spend a ridiculous amount of money on ebay for
> a logic analyzer...

How much was the price?

> I'm not sure if this will affect PCI-X configurations, but it is
> certainly worth trying.

Can you post full result of "lspci -vvv -xxx"?  I'm curious why things 
ended up that way.

Thanks.

-- 
tejun

-- 
VGER BF report: U 0.5
