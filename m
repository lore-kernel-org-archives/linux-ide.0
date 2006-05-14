From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 16/22] libata: implement new SCR handling and port on/offline
 functions
Date: Sat, 13 May 2006 21:10:49 -0400
Message-ID: <44668399.2060101@pobox.com>
References: <1147348791300-git-send-email-htejun@gmail.com> <44665314.4040805@pobox.com> <4466695B.4050204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:3724 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932403AbWENBLE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 21:11:04 -0400
In-Reply-To: <4466695B.4050204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Implement ata_scr_{valid|read|write|write_flush}() and
>>> ata_port_{online|offline}().  These functions replace
>>> scr_{read|write}() and sata_dev_present().
>>>
>>> Major difference between between the new SCR functions and the old
>>> ones is that the new ones have a way to signal error to the caller.
>>> This makes handling SCR-available and SCR-unavailable cases in the
>>> same path easier.  Also, it eases later PM implementation where SCR
>>> access can fail due to various reasons.
>>>
>>> ata_port_{online|offline}() functions return 1 only when they are
>>> affirmitive of the condition.  e.g.  if SCR is unaccessible or
>>> presence cannot be determined for other reasons, these functions
>>> return 0.  So, ata_port_online() != !ata_port_offline().  This
>>> distinction is useful in many exception handling cases.
>>
>> If its SATA-specific, it should have a "sata_" not "ata_" prefix.
>>
> 
> I thought about it but the 'S' in SCR stands for Serial ATA and we also 
> need to rename all PM functions to sata_pmp_xxx() - SCR and PMP are 
> already SATA specific.  Do you think that's the way to go?
> 
> For ata_port_on/offline(), I think it's better to leave them alone for 
> hotpluggable IDE hotbays with presence detection.

Yeah, I feel pretty strongly about the sata_ prefix, even for 
port_on/offline.  The implementation is purely SATA specific.

Should that ever change for sata_port_on/offline, it then becomes 
trivial to create a ->port_on/offline hook, and update all SATA drivers 
to pass sata_port_on/offline to it.  IOW, I think its unlikely that 
these functions, as implemented and used, will morph in the future from

	sata-port-on

to

	if (sata)
		sata-port-on
	else if (hotpluggable PATA bays)
		bay-on

Its much more likely we will create two separate functions for the 
separate functionality.  Thus, your ata_port_on will always be SATA 
specific, and deserving of the spiffy sata_ prefix.  And hey, we want to 
emphasize its SATA because SATA is cooler than PATA, too.

	Jeff



