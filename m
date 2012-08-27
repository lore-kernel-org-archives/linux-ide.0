From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] ahci: implement aggressive SATA device sleep support
Date: Mon, 27 Aug 2012 12:08:24 -0400
Message-ID: <CAFtxgO5Np8NnqJFf04t9-jVPdmJ4oNGbVC6-X78j-UBCg36d6A@mail.gmail.com>
References: <1345761072-2123-1-git-send-email-shane.huang@amd.com>
	<503647B3.6050706@pobox.com>
	<43EB3AB3EEFE8D43B525F4D2EAF507E107E1A41A@SCYBEXDAG03.amd.com>
	<50379F65.3070009@pobox.com>
	<43EB3AB3EEFE8D43B525F4D2EAF507E107E1BAEB@SCYBEXDAG03.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:49585 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752707Ab2H0QI0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2012 12:08:26 -0400
Received: by lagy9 with SMTP id y9so2632481lag.19
        for <linux-ide@vger.kernel.org>; Mon, 27 Aug 2012 09:08:24 -0700 (PDT)
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E107E1BAEB@SCYBEXDAG03.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>

On Mon, Aug 27, 2012 at 6:36 AM, Huang, Shane <Shane.Huang@amd.com> wrote:
>> To avoid attempting to enable on older devices, you will need an
>> appropriate test (ata_id_has_ncq perhaps?)
>
> So far I don't find better method to exclude old devices than yours.
>
>
>> As you figured out in the other email, I was referring to sata_settings
>
> I'm going to modify both sata_settings and ID[78].

Sounds good.


>> I just do not like programming the device, when power policy may
>> indicate otherwise.
>>
>> Most conservative is to leave devslp feature in reset state and not
>> touch device or host until power policy dictates it is time to program
>> host + device.
>
> OK, I'll move setting feature back to ahci_set_aggressive_devslp().
> I'm trying to avoid setting feature each time for every sleep to
> improve performance.
>
> Adding pp->device_devslp_enabled with the code below does not make
> much difference because it is still called for every sleep.
> Do you have good suggestion?
>
> Any should we also call setting feature to disable device DevSlp
> for each !sleep?

Well we want to issue the ATA command to the device at each -power
policy- transition, not for each aggressive sleep.

     Jeff
