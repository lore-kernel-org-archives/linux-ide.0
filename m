From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: check SATA_SETTINGS log with HW Feature Ctrl
Date: Fri, 14 Dec 2012 09:37:33 -0500
Message-ID: <50CB39AD.7070104@pobox.com>
References: <1353185081-11349-1-git-send-email-shane.huang@amd.com> <50BC77DA.1060401@pobox.com> <43EB3AB3EEFE8D43B525F4D2EAF507E107F2FA7F@SCYBEXDAG04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49028 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2LNOhg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2012 09:37:36 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so3949544vby.19
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2012 06:37:36 -0800 (PST)
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E107F2FA7F@SCYBEXDAG04.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>

On 12/11/2012 04:25 AM, Huang, Shane wrote:
> Jeff,
>
>>> This patch is not tested on SATA HDD with DevSlp supported.
>>>
>>> Reported-by: Borislav Petkov <bp@amd64.org>
>>> Signed-off-by: Shane Huang <shane.huang@amd.com>
>>> ---
>>>    drivers/ata/libata-core.c |    3 +--
>>>    include/linux/ata.h       |    1 +
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> applied
>
> Please suspend this patch because I just received two new
> DevSlp drives but found word 78 bit 5 is _not_ set.
>
> I'm checking with the drive vendor whether he gave me
> the wrong information. If bit 5 is not the necessary and
> sufficient condition, I will implement another patch to
> replace ata_device->sata_settings into ->devslp_timing.

reverted



