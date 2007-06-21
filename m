From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide/dma not working from 2.6.19 to 2.6.21
Date: Thu, 21 Jun 2007 22:17:36 +0400
Message-ID: <467AC0C0.5020300@ru.mvista.com>
References: <7ac1e90c0706210447k7c1bdb26y43d62e930ce7728e@mail.gmail.com> <467A9923.6010203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:64696 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754190AbXFUSPy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 14:15:54 -0400
In-Reply-To: <467A9923.6010203@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bahadir Balban <bahadir.balban@gmail.com>
Cc: linux-ide@vger.kernel.org

I wrote:

>> ide0 at 0x90050050-0x90050057,0x90050062 on irq 84
>> <7>Probing IDE interface ide1...
>> <6>hda: max request size: 512KiB
>> <4>hda: lost interrupt
>> <4>hda: lost interrupt
>> <4>hda: lost interrupt

>    Hm, that's interesting -- I'm not sure how the driver rewrite could 
> have affected the interrupt delivery for PIO commands (there's no prior 
> "DMA interrupt recovery" messages).  Might be some other issue here...

>> <6>hda: 160836480 sectors (82348 MB) w/1719KiB Cache, 
>> CHS=16383/255/63, UDMA(33)
>> <4>hda: lost interrupt
>> <6>hda: cache flushes supported
>> <6> hda: <4>hda: dma_timer_expiry: dma status == 0x21
>> <4>hda: DMA timeout error
>> hda: dma timeout error: status=0x51 { DriveReady SeekComplete Error }
>> hda: dma timeout error: error=0x84 { DriveStatusError BadCRC }

>    This is too familiar -- that's how the driver used to behave on

    ...non-x86 targets before the 2.6.20-rc1 change -- although it usually 
exhibited it on higher speeds until the IDE core fekk back to UltraATA/33 or 
/44, then it started to work...

>> Does IDE support in linux depend on certain BIOS settings or any other
>> motherboard specific details? I am asking because neither the new ata
>> nor the old ide layer worked for the cards I tried on ARM (JMB363,
>> IT8212, Promise TX2 133 -> worked only with 2.6.19 old ide layer).

>    As for the Promise -- it used to before 2.2.20-rc1, and it shouldn't 
> since.

    I meant "used to depend on BIOS settings" here.

MBR, Sergei


