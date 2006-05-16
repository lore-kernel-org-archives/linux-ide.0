From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 10:25:31 -0400
Message-ID: <4469E0DB.1040709@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:21229 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751146AbWEPOZi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 10:25:38 -0400
In-Reply-To: <4469B93E.6010201@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>

Ric Wheeler wrote:
> 
> Jeff Garzik wrote:
> 
>> TESTING:
>> * Although most drivers by count received few operational changes, the
>> common probe path was updated, so all drivers need fresh "yes, it sees
>> all my disks" regression testing.
>>
>> * ahci and sata_sil24 were touched a lot, and so need additional
>> testing.
>>
>> * sata_sil and ata_piix also need healthy re-testing of all basic
>> functionality.
>>
>>
>>  
>>
> I have been running a moderate write workload on this (built using 
> linux-2.6.17-rc4 with your patch applied on top).  Last night, I ran on 
> a set of clean AHCI based boxes (no bad drives) and got a serious of 
> occasional spurious interrupts logged:
> 
> 
> May 15 21:24:38 centera kernel: ReiserFS: sdd14: Using r5 hash to sort 
> names
> May 15 21:52:44 centera kernel: ata1: spurious interrupt (irq_stat 0x8 
> active_tag -84148995 sactive 0x800)
> May 15 22:00:02 centera run-crons[26837]: logrotate returned 1
> May 15 22:16:00 centera kernel: ata1: spurious interrupt (irq_stat 0x8 
> active_tag -84148995 sactive 0x4)
> May 15 22:29:14 centera kernel: ata1: spurious interrupt (irq_stat 0x8 
> active_tag -84148995 sactive 0x7e007fff)
> May 15 22:35:04 centera kernel: ata3: spurious interrupt (irq_stat 0x8 
> active_tag -84148995 sactive 0x4fffffff)
> 
> Full messages file and lspci below, but note that this hardware has been 
> running ahci with this config in production for over a year now.

Definitely new behavior.  In each case you have irq_stat == 0x8, which 
indicates a Set Device Bits FIS has been received.

	Jeff


