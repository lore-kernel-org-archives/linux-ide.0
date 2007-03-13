From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Tue, 13 Mar 2007 06:46:27 -0400
Message-ID: <45F68103.7070509@emc.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca> <45F64765.10805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:53116 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbXCMKqg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 06:46:36 -0400
In-Reply-To: <45F64765.10805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>



Tejun Heo wrote:
> Mark Lord wrote:
>   
>> The READ/WRITE LONG commands are theoretically obsolete,
>> but the majority of drives in existance still implement them.
>>
>> The WRITE_LONG and WRITE_LONG_ONCE commands are of particular
>> interest for fault injection testing -- eg. creating "media errors"
>> at specific locations on a disk.
>>
>> The fussy bit is that these commands require a non-standard
>> sector size, usually 520 bytes instead of 512.
>>
>> This patch adds support to libata for READ/WRITE LONG commands
>> issued via SG_IO/ATA_16.
>>
>> This patch was generated against a 2.6.21-rc3-git7 base:
>>     
>
> I think it would be better if this comes in two patches.  One to add
> qc->sect_size and convert all users of ATA_SECT_SIZE to qc->sect_size
> and the other one to implement READ/WRITE LONG.  Another question is
> whether this needs to be included into mainline.  This is definitely
> useful but it is mostly for debugging/testing.
>
> Hmmm... But we're gonna need qc->sect_size anyway for devices with
> larger sector sizes and overhead for supporting READ/WRITE LONG is
> nearly nill, so I'm voting for inclusion.
>
> Thanks.
>   
I just want to add that this patch has been incredibly useful for us in 
testing the error handling & RAID. Nothing like "real" media errors on 
demand to validate your assumptions ;-)

ric

