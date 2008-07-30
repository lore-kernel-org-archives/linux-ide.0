From: gshan <gshan@alcatel-lucent.com>
Subject: Re: PIIX4: DMA timeout issue
Date: Wed, 30 Jul 2008 08:58:28 +0800
Message-ID: <488FBCB4.4080609@alcatel-lucent.com>
References: <488ED837.2060509@alcatel-lucent.com>
	<488F1C6C.9000002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cnrelay03.alcatel-sbell.com.cn ([211.144.215.19]:52817 "EHLO
	mail.alcatel-sbell.com.cn" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758112AbYG3A65 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2008 20:58:57 -0400
In-Reply-To: <488F1C6C.9000002@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> gshan wrote:
>> Hello, I sent mails on this issue before, but nobody made response.
>> There are 2 types of board for me. The hardware configuration for
>> those 2 boards are almost same except that one of them has 100GB
>> harddisk, and another type of board has 60GB harddisk. All harddisk
>> was access through PIIX4. I found this issue on board with 60GB
>> disk, but can't reproduce it on that with 100GB disk.
>>
>> When I uncompressed a large file (600MB) to a logic partition with 8GB
>> size, following errors was report on middle way (5 minutes about from 
>> start).
>> Anybody has ideas?
>>
>> hdc: dma_timer_expiry: dma status == 0x21
>> hdc: DMA timeout error
>> hdc: dma timeout error: status=0x58 { DriveReady SeekComplete 
>> DataRequest }
>> ide: failed opcode was: unknown
>> hdc: DMA disabled
>> ide1: reset: success
>
> Can you try disabling the IDE driver (CONFIG_IDE) and enabling the 
> newer libata driver?  (CONFIG_ATA)
Jeff, thanks a lot for your suggestions. I will try it if possible.
>
>     Jeff
>
>
>
>

