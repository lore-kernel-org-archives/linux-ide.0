From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: Handle drives that require a spin-up command
 before first access
Date: Sat, 28 Apr 2007 16:05:28 -0400
Message-ID: <4633A908.7070808@rtr.ca>
References: <4625497F.7010109@rtr.ca> <4633954B.6040306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1395 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136AbXD1UFb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 16:05:31 -0400
In-Reply-To: <4633954B.6040306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Jeff Garzik wrote:
> Mark Lord wrote:
>
>> This patch adds support to libata for the "power-up in standby"
>> mode where a "spin up now!" command (SET_FEATURES) is needed.
>> With this, libata will recognize such drives, spin them up,
>> and then re-IDENTIFY them if necessary to get a full/complete
>> set of drive features data.
>>
>> Drives in this state are determined by looking for
>> special values in id[2], as documented in the current ATA specs.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> applied
> 
> though I'm curious where the verify step went, that was in the previous 
> rev of the patch

Hi Jeff,

The difference between this patch and the first RFC version,
is that I've dropped the code that attempted to deal with
the *other* kind of power-up-in-standby that some drives use.

That form is enabled with a Jumper setting on the drive
(eg. WD 37GB Raptor drives) rather than through software,
and I was unable to figure out exactly what they wanted
while I still had them here to experiment on.

Those drives are no longer in my possession, so.. no support.

The majority of drives use the software enable/disable form,
which is (still) fully addressed by the patch you applied.

Thanks!

-ml
 

