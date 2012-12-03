From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2 12/14] sata_highbank: utilize common ata_platform_remove_one()
Date: Mon, 3 Dec 2012 10:12:45 -0800
Message-ID: <CAN8TOE_npd7i8o4RtW4DF1DPwb4FW9kJrn7t0U0kqUN5ewVG4A@mail.gmail.com>
References: <1351842388-27210-13-git-send-email-computersforpeace@gmail.com>
	<1351883526-32412-1-git-send-email-computersforpeace@gmail.com>
	<50BC7C22.2010608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:49673 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2LCSMr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 13:12:47 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2385983iay.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 10:12:47 -0800 (PST)
In-Reply-To: <50BC7C22.2010608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Sergei Shtylyov <sshtylyov@mvista.com>

On Mon, Dec 3, 2012 at 2:17 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 11/02/2012 03:12 PM, Brian Norris wrote:
>>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>> ---
>> v2: fix whitespace
>>
>>   drivers/ata/sata_highbank.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>
>
> applied patches 1-11

Thanks.

> patch #12 failed to apply (even manually), so I stopped there

There was just a trivial change to the #ifdef next to the (unrelated,
but adjacent) ahci_highbank_suspend function. I'll resend 12-14, as a
v2 series, plus a (new) compile-error fix for pata_of_platform.

BTW, Tejun posted his "Ack" in reply to the original series. I'll
include it in my version 2 of the original patches, but I noticed you
didn't add it in libata-dev.git.

Brian
