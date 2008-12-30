From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI problem with hotplug
Date: Tue, 30 Dec 2008 09:38:54 +0900
Message-ID: <49596D9E.3040904@kernel.org>
References: <494178E3.6030305@cybernetics.com> <49588784.4020808@kernel.org> <4958E3DC.7080009@cybernetics.com> <49591710.7040102@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50541 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbYL3AjD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 19:39:03 -0500
In-Reply-To: <49591710.7040102@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Tony Battersby <tonyb@cybernetics.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Robert Hancock wrote:
> Tony Battersby wrote:
>>> The BIOS could be tristating the ports.  Does it work if you issue
>>> manual rescan (echo - - - > /sys/class/scsi_host/hostN/scan)?
>>>   
>> No luck.  I get:
>>
>> ata1: hard resetting link
>> ata1: SATA link down (SStatus 0 SControl 0)
>> ata1: EH complete
>>
>> And the drive isn't seen.
> 
> Well, if the controller reports link down there likely isn't much the
> kernel can do about it. I assume that ata1 is in fact where that drive
> gets detected if it's plugged in at boot - you could try all the other
> hosts to be sure..

This is consistent with the BIOS tristating those ports.  I don't
remember the name of the register.  I'll look it up later.

Thanks.

-- 
tejun
