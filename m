From: Tejun Heo <tj@kernel.org>
Subject: Re: PIIX4: DMA timeout issue
Date: Fri, 01 Aug 2008 16:43:54 +0900
Message-ID: <4892BEBA.2000602@kernel.org>
References: <488ED837.2060509@alcatel-lucent.com>	<488F1C6C.9000002@garzik.org>	<48902EB5.8070102@alcatel-lucent.com> <20080730114934.5a593cf4@lxorguk.ukuu.org.uk> <48913FFD.5070901@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57597 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbYHAHpG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 03:45:06 -0400
In-Reply-To: <48913FFD.5070901@alcatel-lucent.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gshan <gshan@alcatel-lucent.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

gshan wrote:
> 
>>> Another question is my PIIX4 chip has device ID + vendor ID of
>>> 0x71108086. But it finally
>>> was mapped to following ID of piix_pci_tbl[] array. Device of 0x7110
>>> and 0x7010 should
>>> be quit different, right?
>>>     
>>
>> Yes - I find tht one very odd - you might need to debug a bit to see what
>> is occuring if you think this is the case.
>>
>> Alan
>>   
> Alan/Jeff, I tried to install ATA driver on PIIX4. After fixing IRQ number
> to 143 for primary and secondary channel. I got following output and
> it seems the driver has been loaded sucessfully. However, I couldn't
> see any information from /proc/devices. Do you have any ideas?

You need the SCSI disk driver - sd_mod.ko.

-- 
tejun
