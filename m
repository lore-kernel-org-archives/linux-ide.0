From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH #sx4] sata_sx4: fixup interrupt handling
Date: Wed, 13 May 2009 18:42:51 -0500
Message-ID: <4A0B5AFB.1050705@redhat.com>
References: <20090513230221.GB5863@dhcp-210.hsv.redhat.com> <4A0B5768.7000309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:52111 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbZEMXoi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 May 2009 19:44:38 -0400
In-Reply-To: <4A0B5768.7000309@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: mikpe@it.uu.se, tj@kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> David Milburn wrote:
>> Issuing ATA_CMD_SET_FEATURES (0xef) times out because 
>> pdc20621_interrupt ignores command completion since
>> ATA_TFLAG_POLLING flag is set.
>>
>> This has already been fixed for sata_promise:
>>
>> commit 51b94d2a5a90d4800e74d7348bcde098a28f4fb3
>> Author: Tejun Heo <htejun@gmail.com>
>> Date:   Fri Jun 8 13:46:55 2007 -0700
>>
>>     sata_promise: use TF interface for polling NODATA commands
>>
>> Also, this patch includes Mikael's original patches:
>>
>> http://marc.info/?l=linux-ide&m=121135828227724&w=2
>> http://marc.info/?l=linux-ide&m=121144512109826&w=2
>>
>> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
>> Signed-off-by: David Milburn <dmilburn@redhat.com>
>> ---
>>  drivers/ata/sata_sx4.c |   22 +++++++++-------------
>>  1 files changed, 9 insertions(+), 13 deletions(-)
> 
> Oh, and:  does vanilla upstream sata_sx4 work at all?

I know it was not working on 2.6.29.2, I will try a more recent
kernel with and without the patch.

Thanks,
David

> 
> If not, that would justify fast-forwarding the #sx4 branch into 2.6.30 
> (with your fixes, obviously)...
> 
> Thanks,
> 
>     Jeff
> 
> 
> 
> 

