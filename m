From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-eh copy result_tf flags from outgoing tf
Date: Thu, 24 Apr 2008 11:42:42 +0900
Message-ID: <480FF3A2.2040703@gmail.com>
References: <480F9D29.4070603@rtr.ca> <480FB4AF.2060907@gmail.com> <480FC82F.8080404@rtr.ca> <480FDC0D.60302@gmail.com> <480FF228.2000704@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:15136 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbYDXCmu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 22:42:50 -0400
Received: by py-out-1112.google.com with SMTP id u52so4688500pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 19:42:50 -0700 (PDT)
In-Reply-To: <480FF228.2000704@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
>>>> Maybe it's better to set ATA_TFLAG_LBA48 | ATA_TFLAG_ISADDR | 
>>>> ATA_TFLAG_DEVICE?  After all, all fields are available after that 
>>>> memcpy().
>>> ..
>>>
>>> I just did it the same way as the standard version in libata-core 
>>> does it.
>>> In this particular case, we know it was NCQ, so we know that the 
>>> original
>>> tf->flags have (ATA_TFLAG_LBA48|ATA_TFLAG_ISADDR|ATA_TFLAG_DEVICE) set.
>>>
>>> I figured better to copy than just overwrite, because new flags might 
>>> come along.
>>
>> Those flags are to tell which parts of the TF are valid or should be 
>> read in case of TFLAG_LBA48.  So, a TF after tf_read should always 
>> have TFLAG_ISADDR and TFLAG_DEVICE.  TFLAG_LBA48 works both ways.  If 
>> it was set when tf_read is called the higher part of LBA is read and 
>> the resulting tf should have TFLAG_LBA48 set.  But yeah the original 
>> code isn't like that.  If you can fix it up together with the NCQ 
>> path, it would be great.
> ..
> 
> Actually, the TF after tf_read in this case should have TFLAG_LBA in there
> as well.  And TFLAG_DEVICE looks unnecessary (but harmless).

Yeah.. right.

> Copying from the outgoing tf gets all of those.

Not for all cases tho.  There are commands which don't necessarily use 
the LBA fields but reading it back on failure is still a good idea.

-- 
tejun
