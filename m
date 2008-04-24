From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata-eh copy result_tf flags from outgoing tf
Date: Wed, 23 Apr 2008 22:24:41 -0400
Message-ID: <480FEF69.8000407@rtr.ca>
References: <480F9D29.4070603@rtr.ca> <480FB4AF.2060907@gmail.com> <480FC82F.8080404@rtr.ca> <480FDC0D.60302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3066 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbYDXCYp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 22:24:45 -0400
In-Reply-To: <480FDC0D.60302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>>> Maybe it's better to set ATA_TFLAG_LBA48 | ATA_TFLAG_ISADDR | 
>>> ATA_TFLAG_DEVICE?  After all, all fields are available after that 
>>> memcpy().
>> ..
>>
>> I just did it the same way as the standard version in libata-core does 
>> it.
>> In this particular case, we know it was NCQ, so we know that the original
>> tf->flags have (ATA_TFLAG_LBA48|ATA_TFLAG_ISADDR|ATA_TFLAG_DEVICE) set.
>>
>> I figured better to copy than just overwrite, because new flags might 
>> come along.
> 
> Those flags are to tell which parts of the TF are valid or should be 
> read in case of TFLAG_LBA48.  So, a TF after tf_read should always have 
> TFLAG_ISADDR and TFLAG_DEVICE.  TFLAG_LBA48 works both ways.  If it was 
> set when tf_read is called the higher part of LBA is read and the 
> resulting tf should have TFLAG_LBA48 set.  But yeah the original code 
> isn't like that.  If you can fix it up together with the NCQ path, it 
> would be great.
..

No, I'm not going to touch the mainline path.  tf_read is used to read
the taskfile, but it doesn't always contain an LBA address, so I'm not so
sure that forcing TFLAG_ISADDR is always correct.

And since I don't know that code as well as you, I don't want to end up
having to help debug something that might break as a result.

This may warrant two patches.. one to fix the NCQ bug (already posted),
and perhaps another from you or Jeff if you want to change the behaviour.

Cheers
