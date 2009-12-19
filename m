From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and
    UDMA5 instead of UDMA6
Date: Sat, 19 Dec 2009 18:29:19 -0500
Message-ID: <4B2D61CF.2010901@pobox.com>
References: <4B2A3D25.9030209@hardwarefreak.com> <4B2A720B.2040809@pobox.com>	 <4B2AE779.9060109@hardwarefreak.com> <4B2AF2C2.9010708@pobox.com>	 <4B2AFBDD.30601@hardwarefreak.com> <4B2AFF7B.4000007@gmail.com>	 <4B2B0642.3010501@hardwarefreak.com> <51f3faa70912172100p103e7698ne8a4216fe6471634@mail.gmail.com> <4B2BDD55.5090800@hardwarefreak.com> <4B2D1893.4060407@gmail.com> <4B2D5EA9.1040106@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:37472 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbZLSX3V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2009 18:29:21 -0500
Received: by yxe17 with SMTP id 17so3947313yxe.33
        for <linux-ide@vger.kernel.org>; Sat, 19 Dec 2009 15:29:21 -0800 (PST)
In-Reply-To: <4B2D5EA9.1040106@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On 12/19/2009 06:15 PM, Stan Hoeppner wrote:
> Robert Hancock put forth on 12/19/2009 12:16 PM:
>> On 12/18/2009 01:51 PM, Stan Hoeppner wrote:
>>> Robert Hancock put forth on 12/17/2009 11:00 PM:
>>>> On Thu, Dec 17, 2009 at 10:34 PM, Stan
>>>> Hoeppner<stan@hardwarefreak.com>   wrote:
>>>
>>>>> So, how does this "phantom" UDMA setting affect either libata or
>>>>> sata_sil?  If it effects nothing, why is it hanging around?  Is this a
>>>>> backward compatibility thing for the kernel's benefit?  I'm not a
>>>>> kernel
>>>>> hacker or programmer (yet), so please forgive my ignorant questions.
>>>>
>>>> It doesn't affect either the driver or the controller. Only the drive
>>>> may possibly care - that would be if there's a SATA-to-PATA bridge
>>>> involved (as some early SATA drives had internally, for example) and
>>>> there's an actual PATA bus that needs to be programmed properly for
>>>> speed. Other than that, it's basically vestigial.
>>>
>>> So in sata_sil.c version 2.4, the following are only present in the case
>>> one of these early drives with an onboard PATA-SATA bridge is connected?
>>>
>>>           SIL_QUIRK_UDMA5MAX      = (1<<   1),
>>>
>>> } sil_blacklist [] = {
>>>
>>>           { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
>>>
>>>
>>> static const struct ata_port_info sil_port_info[] = {
>>>           /* sil_3512 */
>>>           {
>>>                   .flags          = SIL_DFL_PORT_FLAGS |
>>> SIL_FLAG_RERR_ON_DMA_ACT,
>>>                   .pio_mask       = ATA_PIO4,
>>>                   .mwdma_mask     = ATA_MWDMA2,
>>>                   .udma_mask      = ATA_UDMA5,
>>>                   .port_ops       =&sil_ops,
>>>           },
>>>
>>>    *      20040111 - Seagate drives affected by the Mod15Write bug are
>>> blacklisted
>>>    *      The Maxtor quirk is in the blacklist, but I'm keeping the
>>> original
>>>    *      pessimistic fix for the following reasons...
>>>    *      - There seems to be less info on it, only one device gleaned
>>> off the
>>>    *      Windows driver, maybe only one is affected.  More info would be
>>> greatly
>>>    *      appreciated.
>>>    *      - But then again UDMA5 is hardly anything to complain about
>>>
>>>           /* limit to udma5 */
>>>           if (quirks&   SIL_QUIRK_UDMA5MAX) {
>>>                   if (print_info)
>>>                           ata_dev_printk(dev, KERN_INFO, "applying
>>> Maxtor "
>>>                                          "errata fix %s\n", model_num);
>>>                   dev->udma_mask&= ATA_UDMA5;
>>>                   return;
>>>           }
>>>
>>>
>>> Might it be beneficial, if merely to keep people like myself from asking
>>> questions, to set the default for the 3512 to UDMA6 max instead of UDMA5
>>> max, and only set UDMA5 in the case of a blacklisted Maxtor?  I'm sure
>>> I'm not the first person to see in dmesg that my drive is showing
>>> UDMA/133 capability but sata_sil is "limiting" the drive to UDMA/100.
>>> If this setting is merely window dressing for all but the oldest borked
>>> SATA1 drives with bridge chips, why not fix up this code so it at least
>>> "appears" the controller is matching the mode the new pure SATA drive is
>>> reporting?
>>
>> For whatever reason the sata_sil driver only indicates it supports
>> UDMA5, not UDMA6. So it appears that Maxtor quirk doesn't really do
>> anything, all drivers will only get programmed as UDMA5 max anyway.
>
> According to the source comments Jeff seems to hint that it's a conscious
> decision he made for sata_sil chips, although he doesn't elaborate as to all the
> "why's" in the comments.  Jeff, would you shed more light on this please?  It
> probably makes no difference in my case, I'm just curious.

Which source comments?

I do not recall why sata_sil is limited to udma5.  udma5 limit does 
predate the now-ancient conversion of udma_mask from 0x3f to ATA_UDMA5.

According to the SiI docs and sample code, it seems like udma6 is 
supported by the hardware.

As you are guessing, s/ATA_UDMA5/ATA_UDMA6/ is unlikely to make any 
measurable difference.

	Jeff




