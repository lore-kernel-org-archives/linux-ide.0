From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 2/4] pata_octeon_cf: perform host detach, removal on exit
Date: Mon, 3 Dec 2012 22:10:03 -0800
Message-ID: <CAN8TOE_Zmd8ek-OXqHKiuQ57aUF7BdLFX2KOD-20tt8EBDhg+Q@mail.gmail.com>
References: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com>
	<1354559682-30965-2-git-send-email-computersforpeace@gmail.com>
	<50BD4331.6010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41163 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab2LDGKE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2012 01:10:04 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so5593500ieb.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 22:10:03 -0800 (PST)
In-Reply-To: <50BD4331.6010904@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, David Daney <david.daney@cavium.com>

Jeff,

Per David's comments, I recommend that this patch be dropped from inclusion.

Hi David,

On Mon, Dec 3, 2012 at 4:26 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 12/03/2012 10:34 AM, Brian Norris wrote:
>> This driver does not detach and remove its ata_host properly on device
>> removal. Add the common .remove helper.
>>
>> Note: I do not know this driver well enough to ensure this is the right
>> thing to do. Merge this patch with caution.
>>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
>> Cc: David Daney <david.daney@cavium.com>
>> ---
>> v2: no change (rebased along with previous patch)
>>
>>   drivers/ata/pata_octeon_cf.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
>> index 1d61d5d..d8df93b 100644
>> --- a/drivers/ata/pata_octeon_cf.c
>> +++ b/drivers/ata/pata_octeon_cf.c
>> @@ -921,6 +921,7 @@ free_cf_port:
>>
>>   static struct platform_driver octeon_cf_driver = {
>>         .probe          = octeon_cf_probe,
>> +       .remove         = ata_platform_remove_one,
>
>
> Can you point me at the definition of ata_platform_remove_one()?

It's a recent addition, and this series (v2/v3) is just part of the
already-accepted series. Jeff already queued it all up in
libata-dev.git:
https://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=shortlog;h=refs/heads/ALL

> I can seem to find it.  Without knowing what that does, I would be inclined
> to NACK the whole thing.

A NACK is probably the right thing. I was mostly converting a few
other drivers which used some simple, common patterns to use my new
common code, but this driver was missing it altogether. It looks like
there may be bigger issues, though, as you point out.

> How did you test the patch?

I didn't; I don't have a cavium-octeon system.

> This patch is likely to be incomplete as the driver is also missing the
> module_exit() things.
>
> It might be simpler to just make the driver "bool" instead of "tristate" in
> the Kconfig.

As noted earlier, I don't have much interest in this driver. I agree
that there are some other issues with the driver; I think it leaks
memory if it is ever allowed to unload, for one. Feel free to submit
an alternative patch to prevent this driver from being built as a
module.

Brian
