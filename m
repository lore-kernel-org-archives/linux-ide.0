Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30720C38A2D
	for <linux-ide@archiver.kernel.org>; Fri, 21 Oct 2022 22:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJUWpi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJUWpg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2022 18:45:36 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EBB1826FC
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2022 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666392335; x=1697928335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FROvtYZcA9PHigno5I71uxxg9UzIqYGya/YEj0Ho+kQ=;
  b=CH6Ue5LKzt1zS3GCAP66PQvDdNFk2QlwBJAaY8aYEc6Kje2frT/F+2tA
   ZGPDtN4xKM5qycA/aUyi32P5IjpbcTIluHEkXbmQBNo/KHJdq45URMCO8
   0HeF0O/Mcu2wuvpsCrgsdh5LTNSi1Dwt+VR4QIT7FKxPX4gIcqFjQ+LIh
   OO3g/l8ExfzALN8t6xpzU8rNRUVTxm2Eet1++/T6OKBiWv9fu1fdnWPrR
   RuXva7xGVKoubUyeNWXtrHgC3fXTl5gjRNrSUZ09AnKBQm3tPzE3xmqXD
   UxcKE0sjD8qFHh7kcQ5twMPYUmH7RCrWO7GvZ8yh3f38I3lZHTh3b0h5C
   w==;
X-IronPort-AV: E=Sophos;i="5.95,203,1661788800"; 
   d="scan'208";a="214467072"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2022 06:45:34 +0800
IronPort-SDR: UURFl1mu7JxjlGv5oewIygPVzZqKgYSiWjIMWt2LYcFTcNwiNgMAGmCst0YncVKqutuC++iURb
 hmpFUsKSHq/rNltjesL3k736NbC9u1uHxr0XdlsH4q8hHYpoTwYtm8h+APtNBfaGAJCEqcw22X
 hhSPdqBmbwMGx/ifo3dIAiH5g2D/9h/zl/cDqWp5RlmWomrFLQKohX84NceB4gpsM0mCqMc3Z2
 OJ0A7dyEwDgXG2qvYRMuMuaXbM0SDDrIRz0IE9Zo+3dwh6jN90/1NM2Y1HBOxnU/eSRUGfXeHW
 sdsmFro1pBsdBrHp3wIJEBei
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 14:59:20 -0700
IronPort-SDR: Ofi9ZvtFScF1TFB9cxZlvpjtKE8tk6o4drsXiR3UDch/bPIaTBV/eDRSoECxl91OXcw2VPsshV
 6VIDfgSk71lxW7qI/qc6CnJ0cxiQi1GsSDrMCTLYuhJEaBhDxyGVdDkS4FWs9MrJF1oe7N9zd2
 t/BsNWJ8WnpW5lsDZnGUGvzIsd5R1m0r9+RRo58c932/qwJlWuoWM9Fjqw2AolflG/MGwSE+J/
 DHaWbr7QBI1b1V+TMUHrmu9YnekmusllLOzCv4m/GIxLxXWb90ubzYoifnYYvXDChk9/40vYxZ
 vdY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 15:45:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MvKLP3HGpz1RwqL
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2022 15:45:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666392332; x=1668984333; bh=FROvtYZcA9PHigno5I71uxxg9UzIqYGya/Y
        Ej0Ho+kQ=; b=GUszhZ8CR8+PI2C3bWU1Jy11Kl54d178xw3ldpyVPoL43HHFdI8
        WeasIV1OlSGTfjvMPHb9CQ9ofhjdkwpcZpCDTN2VDvqLzL1LcPhK8n16kwE8UM0/
        dCaBjdg0NKu/27jNuAiTYRfTUnxGXVdI02/LL2+DgFZJLQyvkBAXyMSYBO7cPM57
        7X8vEql2OLeko6AavAF6cHpTyvkisLMRZIpVN+oqDWHk8EEWdEUcGPlPkTPwRxKC
        xEkC7QASEaIlUgiWO4RAnoa0uhrWu4d4mei7P9WnHDmBcLarfR6bTBD9gZ13ybVs
        AtnnObkAoeSt3HYPjtmzbnXWt1w0mxN8TFg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o3SVkPj5Qo68 for <linux-ide@vger.kernel.org>;
        Fri, 21 Oct 2022 15:45:32 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MvKLN2DqDz1RvLy;
        Fri, 21 Oct 2022 15:45:32 -0700 (PDT)
Message-ID: <d0315388-460b-37c9-298e-97f86b7965b7@opensource.wdc.com>
Date:   Sat, 22 Oct 2022 07:45:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 0/3] Improve libata support for FUA
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
References: <20221021053809.237651-1-damien.lemoal@opensource.wdc.com>
 <165565d4-f391-b13c-b450-26f115bb4cf9@maciej.szmigiero.name>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <165565d4-f391-b13c-b450-26f115bb4cf9@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/22/22 06:02, Maciej S. Szmigiero wrote:
> On 21.10.2022 07:38, Damien Le Moal wrote:
>> These patches cleanup and improve libata support for the FUA device
>> feature. Patch 3 enables FUA support by default for any drive that
>> reports supporting the feature.
>>
>> Damien Le Moal (2):
>>    ata: libata: cleanup fua handling
>>    ata: libata: Enable fua support by default
>>
>> Maciej S. Szmigiero (1):
>>    ata: libata: allow toggling fua parameter at runtime
>>
> 
> Thanks Damien for the series!
> 
> I've looked at the code changes and have basically two points:
> 1) There seems to be no way to revalidate the FUA setting for an existing
> disk, since it is now only taken into account in ata_dev_config_fua().
> 
> As far as I can see, this function is only called on probe paths
> (and during exception handling), so if the "libata.fua" parameter is
> toggled the new setting would only affect newly (re-)attached disks.

Yes. Indeed. Forcing an ATA revalidation needs some more trickery as the
regular sd_revalidate() does not lead to ata_dev_configure() being called
again.

> Previously, this parameter was read directly in ata_scsiop_mode_sense()
> (specifically in ata_dev_supports_fua() called from there), which could
> be called to re-compute the FUA setting for an existing disk by
> re-writing the "cache_type" sysfs attribute (as described in my commit
> message).
> 
> If that's indeed the case this severely limits the usefulness of having
> this parameter runtime-writable, and I agree with your discussion with
> Hannes that it isn't probably needed now (after all, probably nobody
> has an explicit "libata.fua=0" in their kernel command line, since this
> was the default setting anyway).

OK. Then I will drop your patch. Safer that way.

> 2) It would be good to collect known-broken disks from the similar FUA
> enabling attempt in 2012 [1] and add them to the blacklist upfront, so
> these users won't have to report them again.

The code only had one Maxtor drive blacklisted for FUA. Patch one adds it
to the horkage table.

> 
> The problematic disks reported in that thread were:
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: ATA-7: WDC WD2500JS-41MVB1, 10.02E01, max UDMA/133
>> ata1.00: 488397168 sectors, multi 16: LBA48 
>> ata1.00: configured for UDMA/133
>> scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500JS-41M 10.0 PQ: 0 ANSI: 5
> 
>> [    2.845750] ata1.00: ATA-9: OCZ-VERTEX3 MI, 2.06, max UDMA/133
>> [    2.845754] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
>> [    2.865726] ata1.00: configured for UDMA/133
>> [    2.865955] scsi 0:0:0:0: Direct-Access     ATA      OCZ-VERTEX3 MI   2.06 PQ: 0 ANSI: 5
>> [    2.866722] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/111 GiB)
> 
>> [    3.934157] ata1.00: ATA-9: INTEL SSDSC2CT120A3, 300i, max UDMA/133
>> [    3.934266] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32)
>> [    3.954145] ata1.00: configured for UDMA/133
>> [    3.954441] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2CT12 
>> 300i PQ: 0 ANSI: 5
>> [    3.955233] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 
>> GB/111 GiB)

OK. I will check that thread and add these drives to the horkage list.
Thanks !

> 
> Thanks,
> Maciej
> 
> [1]: https://lore.kernel.org/lkml/CA+6av4=uxu_q5U_46HtpUt=FSgbh3pZuAEY54J5_xK=MKWq-YQ@mail.gmail.com/
> 

-- 
Damien Le Moal
Western Digital Research

