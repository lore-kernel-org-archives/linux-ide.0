From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: kernel 2.6.6 amd8111 dma bugs
Date: Wed, 02 Jun 2004 20:59:22 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40BE85FA.7000902@clanhk.org>
References: <Pine.LNX.4.44.0405281511020.1326-100000@sasami.anime.net> <20040529074245.GQ20657@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.clanhk.org ([69.93.101.154]:16518 "EHLO
	mail.hardcore-gaming.net") by vger.kernel.org with ESMTP
	id S265433AbUFCB72 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jun 2004 21:59:28 -0400
In-Reply-To: <20040529074245.GQ20657@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Dan Hollis <goemon@anime.net>, linux-ide@vger.kernel.org

Jens Axboe wrote:

>On Fri, May 28 2004, Dan Hollis wrote:
>  
>
>>replies to email as i'm not subscribed to the list.
>>
>>There seem to be regular dma timeouts:
>>
>>hdc: dma_timer_expiry: dma status == 0x24
>>hdc: DMA interrupt recovery
>>hdc: lost interrupt
>>hda: dma_timer_expiry: dma status == 0x24
>>hda: DMA interrupt recovery
>>hda: lost interrupt
>>
>>Hardware:
>>
>>Opteron 140, Tyan Tomcat K8S (S2850)
>>    
>>
>
>Try disabling ACPI (in .config or boot acpi=off iirc)
>  
>
I had that problem, but not with ACPI, only when I forced APIC on.  It 
was on the VIA controller which uses the same driver.

-ryan
