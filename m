From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFT PATCH] ia64: generic_defconfig: convert to use libata PATA
 drivers
Date: Mon, 17 Aug 2015 20:26:02 +0300
Message-ID: <55D2192A.2080803@cogentembedded.com>
References: <1439826388-31456-1-git-send-email-b.zolnierkie@samsung.com>
 <1439826388-31456-2-git-send-email-b.zolnierkie@samsung.com>
 <55D2097A.7090203@cogentembedded.com> <13721070.NVYmjefytC@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35330 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbbHQR0G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Aug 2015 13:26:06 -0400
Received: by lbcbn3 with SMTP id bn3so86372684lbc.2
        for <linux-ide@vger.kernel.org>; Mon, 17 Aug 2015 10:26:05 -0700 (PDT)
In-Reply-To: <13721070.NVYmjefytC@amdc1976>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/17/2015 07:31 PM, Bartlomiej Zolnierkiewicz wrote:

>>> IDE subsystem has been deprecated since 2009 and the majority
>>> (if not all) of Linux distributions have switched to use
>>> libata for ATA support exclusively.  However there are still
>>> some users (mostly old or/and embedded non-x86 systems) that
>>> have not converted from using IDE subsystem to libata PATA
>>> drivers.  This doesn't seem to be good thing in the long-term
>>> for Linux as while there is less and less PATA systems left
>>> in use:
>>>
>>> * testing efforts are divided between two subsystems
>>>
>>> * having duplicate drivers for same hardware confuses users
>>>
>>> This patch converts generic_defconfig to use libata PATA
>>> drivers (sgiioc4 IDE host driver has no corresponding libata
>>> driver yet so it is not converted).
>>>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[...]

>>> diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/generic_defconfig
>>> index 81f686d..f55be82 100644
>>> --- a/arch/ia64/configs/generic_defconfig
>>> +++ b/arch/ia64/configs/generic_defconfig
>> [...]
>>> @@ -62,6 +59,9 @@ CONFIG_SCSI_QLOGIC_1280=y
>>>    CONFIG_ATA=y
>>>    CONFIG_ATA_PIIX=y
>>>    CONFIG_SATA_VITESSE=y
>>> +CONFIG_PATA_CMD64X=y
>>> +CONFIG_PATA_MPIIX=y

>>      If you're enabling the MPIIX support (which I doubt is necessary), why not

> I also doubt that it is necessary but IDE's piix host driver
> includes support for it

    Borked. :-)

> (so after conversion MPIIX is also enabled).

    MPIIX was for laptops only, IIUC.

>> enable the "old" PIIX support?

> Oversight on my side, will fix.

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

MBR, Sergei

