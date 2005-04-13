From: Brett Russ <russb@emc.com>
Subject: Re: hdregs.h puts csfo at word 129 - wrong, that's vendor specific
Date: Wed, 13 Apr 2005 18:18:58 -0400
Message-ID: <425D9AD2.4060808@emc.com>
References: <4243693F.9090008@yahoo.com> <42437F78.8090703@pobox.com> <4244BF65.6070109@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.lss.emc.com ([168.159.2.31]:60898 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261159AbVDMWVB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Apr 2005 18:21:01 -0400
In-Reply-To: <4244BF65.6070109@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: andre@linux-ide.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Chris Hann <chann94501@yahoo.com>, linux-ide list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This appears to have been dropped.  The last word 
(http://article.gmane.org/gmane.linux.ide/3588) was from Alan who said 
Andre would know the history.

Andre, can you help answer?

Thanks
BR

Brett Russ wrote:
> Jeff Garzik wrote:
> 
>> Chris Hann wrote:
>>
>>> ide-disk.c checks csfo bit 0 to see if the cache is available on a 
>>> device
>>> hdregs.h maps csfo to word 129 of the Identify Device information
>>> the latest ATA documentation, e00159r3 Mandatory IDENTIFY DEVICE 
>>> information, says words 129-159 are Vendor specific.
>>>
>>> Why is the driver switching on cache operations based on a word that 
>>> has nothing to do with cache?
>>
>>
>>
>> Good question...  I would guess that it's some pre-ATA4 legacy magic, 
>> but that's just a guess.
> 
> 
> I just checked the specs for ATA[134567] (didn't have 2) and all of them 
> show word 129 as vendor specific, as Chris found.
> 
> The code that's in libata-dev shows in idedisk_setup():
> 
>         /* write cache enabled? */
>         if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
>                 drive->wcache = 1;
> 
> 
> Bart, what's the point of the csfo bit check?  If it's specific to one 
> non-ATA compliant device shouldn't it be testing something else along 
> with that bit?
> 
> BR
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

