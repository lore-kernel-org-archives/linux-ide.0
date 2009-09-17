From: Tejun Heo <tj@kernel.org>
Subject: Re: Commit 54c38444fad6a99b4b19512f8f0055d69115e69e
Date: Thu, 17 Sep 2009 16:30:42 +0900
Message-ID: <4AB1E5A2.5090006@kernel.org>
References: <4AB0D258.60503@kernel.org> <4AB1E116.6030600@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40242 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759282AbZIQHaL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 03:30:11 -0400
In-Reply-To: <4AB1E116.6030600@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> On 09/16/2009 07:56 AM, Tejun Heo wrote:
>> Jeff,
>>
>> Commit 54c38444fad6a99b4b19512f8f0055d69115e69e triggers
>> WARN_ON_ONCE(ap->pflags&  ATA_PFLAG_FROZEN); in ata_qc_complete().
>>> From the commit history, it seems the change was to add DMA engine
>> disable to sil_freeze(), right?  I can't see why changing the orders
>> would matter there.  ata_port_abort() just changes the internal state
>> of libata and doesn't affect low level driver or the hardware.
> 
> ata_port_abort does more than change internal state:  it calls
> ata_qc_complete, which could trigger a taskfile register read.
> 
> All SFF BMDMA controllers /must/ disable the DMA engine, before touching
> the taskfile device register block.

Ah.. right, the result tf filling.  Well, then, I guess we'll have to
move the WARN_ON_ONCE().  I'll post a patch soon.

Thanks.

-- 
tejun
