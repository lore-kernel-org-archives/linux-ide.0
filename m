From: Andrew Ryder <tireman@shaw.ca>
Subject: Re: Marvell 88SE9480 Port Multiplier Support
Date: Sun, 8 Oct 2017 19:20:26 -0400
Message-ID: <5573e51a-c7bb-0494-c3a0-c2f1901135ca@shaw.ca>
References: <c93b6306-2e82-8a63-e909-f82641b0215b@shaw.ca>
 <1507481144.3150.4.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out-no.shaw.ca ([64.59.134.13]:35532 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdJHXG6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 8 Oct 2017 19:06:58 -0400
In-Reply-To: <1507481144.3150.4.camel@HansenPartnership.com>
Content-Language: en-GB
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide@vger.kernel.org

I guess I'll just bite the bullet and switch over. It's too bad there
isn't much of an alternative to HighPoints cards though, the sata pmp
has worked well though aside from HighPoints buggyness.

Thanks
Andrew

On 10/08/2017 12:45 PM, James Bottomley wrote:
> On Sun, 2017-10-08 at 00:12 -0400, Andrew Ryder wrote:
>> Hello,
>>
>> Does the mvsas support port multiplier for the marvell 88SE9480 chip?
> 
> Not at the present time.  The code to handle SATA port multipliers is
> stubbed out in libsas/sas_ata.c
> 
> The reason is fairly simple: usually if you're connecting drives via a
> SAS host adapter, you want to use SAS expanders because they're way
> more featureful and performant than SATA port multipliers, so there's
> not much customer pull for support.
> 
>> I purchased an Addonics http://addonics.com/products/ad2ms6gpx8-e.php
>> but the card fails to see any of the attached drives.
>>
>> I found an old message saying it might support sata pmp?
>> https://lkml.org/lkml/2014/4/24/413
> 
> This patch set was never merged.  There were significant problems with
> the EH portion, which Dan Williams reviewed and sent a load of feedback
> for but no future patch set incorporating the modifications was ever
> forthcoming.
> 
> James
> 
> 
>> I've attached a dmesg output also and I'm running kernel 4.9.36 if
>> that
>> helps.
>>
>> Andrew
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
