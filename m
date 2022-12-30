Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF0C4708E
	for <linux-ide@archiver.kernel.org>; Fri, 30 Dec 2022 11:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiL3LWG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 30 Dec 2022 06:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiL3LWG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Dec 2022 06:22:06 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6991AD81
        for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2022 03:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672399324; x=1703935324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k0haUO7lpydMZjWrmlM2FYEkVr6EZGCm5hH62AUcvMo=;
  b=eRfe5wbhj7NJwBwzlCvijp19Y+BlbelSusHEulihIWBnHUJNyCoC8beC
   MieV7Uv2EOTjToghk2WMeBMVUEHs9GD5f/rm3nbmOQ72rltgJ11TOWATv
   WqZZfgwukcKNCpbEs6JmBo2luq1g9Noybg5hnksNjo0i6eIGxI+4waT6k
   IrNWpAWHZ1rpFNrNdE+jy6d33hvoBijS1+P4sWILPnzJkOkSPI0bUceuI
   bl3YmdtLc3ku/ymN94tPsKaVmMpb0zrbm+hOe71s0nDOdWzE58b2CjkVJ
   BtjDGVWWRPlFXZLT7p/kWn/c+zq5Yv1y5hJaJk0xijJewoM9Xt4pdN63y
   w==;
X-IronPort-AV: E=Sophos;i="5.96,287,1665417600"; 
   d="scan'208";a="224811299"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 19:22:03 +0800
IronPort-SDR: aFhOFAr9k8zY+ko6xOjp6lrcTIn45Urvewin9gHeSeRHr15A7pGJFRLMMwRjOYEBDXX0YfDuPJ
 dTL2TzqTxZIuwwL9WZ6iuN97BlKayU5k9Vjfk+pE9J1DUl7gUGMOBZyCppiwHObAnlVOcyjIdH
 TwduZLEolV79vEr2MUCWcnKDDYndkrW78xQYm4jjdqVF32iaV/efAnErcHk4j2QKcRs4UTkYyd
 Gsk1Huq5sS0RVzJbyTgvk1qWgvpP2VrSI9Eoj4T948ONWQO4LzZCJqTWN4ecQsJcUjAAmVxkOC
 Cfs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Dec 2022 02:34:22 -0800
IronPort-SDR: Y5QxM+8//eqDeQAR9ZUZarEuQAsS0IF1ubGi1utVlPazAnJS9c8iUUDng6eCBNnEH4RfFw+Z4v
 E/anx5Admf7W+jphaMTvy3eXBIugsqhrmysudxqlQEbofV0MSSP5Ag+9AJviL68hagtYaJD/2C
 8uovlUPpwz/QJcqU3JmAnTkBZG6X7jsVRwphkDsc/erIu0vCcsHVqhoakyASExKotMkWSYsr+s
 Hcy1QsetHpb3bjk/44tQ5jGl8a7uW4xFsiTsv7INpX+wwa7h02fD2MCbtcgjPgS++IVU7lWk4C
 TJk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Dec 2022 03:22:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nk2sR29M1z1Rwt8
        for <linux-ide@vger.kernel.org>; Fri, 30 Dec 2022 03:22:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672399322; x=1674991323; bh=k0haUO7lpydMZjWrmlM2FYEkVr6EZGCm5hH
        62AUcvMo=; b=s4nK57A+6OD5QRMBXoAUNrxwYunC29fY1WY17b/DbdlLwAcXTp3
        LAnR4tTObJedkxTZ+DHUPWfxzYTvdwtppTUkyyz03nEqFNx75gf8EoxI/JuK+FhR
        R/gy04XnqNSHgF1y/QVgDnEAAutNkHlVcMSpebFjSQ2JmJE7rjWfWwOpinaZsbsg
        xvqdPIptw5eSKnlAHddoJ9I9wAghweI7jRVKZadGs0Cs8+b0gN4TvkBPFrhLuiBP
        xiQNJRzpiE+CFl9YAcLPNZ9o/ZExSmkiXKpP4kb9SjDv6eipd74RIiL8QBNC+Hag
        V5rY9N5Ng6saAt9jm9v/wSW6IzF/Mxe/z4A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wVOUDae0hV8h for <linux-ide@vger.kernel.org>;
        Fri, 30 Dec 2022 03:22:02 -0800 (PST)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nk2sP2Vvcz1RvLy;
        Fri, 30 Dec 2022 03:22:01 -0800 (PST)
Message-ID: <602e37be-38fa-0143-a6fe-010aa74197d8@opensource.wdc.com>
Date:   Fri, 30 Dec 2022 20:21:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 7/7] ata: libata: Enable fua support by default
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-8-damien.lemoal@opensource.wdc.com>
 <Y67DaUBSFBU9xoIU@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y67DaUBSFBU9xoIU@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/30/22 19:54, Niklas Cassel wrote:
> On Tue, Nov 08, 2022 at 02:55:44PM +0900, Damien Le Moal wrote:
>> Change the default value of the fua module parameter to 1 to enable fua
>> support by default for all devices supporting it.
>>
>> FUA support can be disabled for individual drives using the
>> force=[ID]nofua libata module argument.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> ---
>>  drivers/ata/libata-core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 97ade977b830..2967671131d2 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -127,9 +127,9 @@ int atapi_passthru16 = 1;
>>  module_param(atapi_passthru16, int, 0444);
>>  MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices (0=off, 1=on [default])");
>>  
>> -int libata_fua = 0;
>> +int libata_fua = 1;
>>  module_param_named(fua, libata_fua, int, 0444);
>> -MODULE_PARM_DESC(fua, "FUA support (0=off [default], 1=on)");
>> +MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on [default])");
>>  
>>  static int ata_ignore_hpa;
>>  module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
>> -- 
>> 2.38.1
>>
> 
> Before this commit:
> -For a SCSI mode sense:
>  FUA bit will not get set in the simulated SCSI cmd output buffer,
>  since ATA_DFLAG_FUA is not be set, since libata_fua == 0.
> -For a SCSI WRITE_16 / WRITE_16 command:
>  ata_scsi_rw_xlat() sets ATA_TFLAG_FUA, regardless if ATA_DFLAG_FUA
>  is set or not. ata_set_rwcmd_protocol() will return a FUA command
>  as long as ATA_TFLAG_FUA is set.
> 
> After this commit:
> -For a SCSI mode sense:
>  FUA bit will get set in the simulated SCSI cmd output buffer,
>  since ATA_DFLAG_FUA is set, since libata_fua == 1.
> -For a SCSI WRITE_16 / WRITE_16 command:
>  ata_scsi_rw_xlat() sets ATA_TFLAG_FUA, regardless if ATA_DFLAG_FUA
>  is set or not. ata_set_rwcmd_protocol() will return a FUA command
>  as long as ATA_TFLAG_FUA is set.
> 
> 
> Perhaps this commit should more clearly say that this commit only affects
> the simulated output for a SCSI mode sense command?
> 
> Currently, the commit message is a bit misleading, since it makes the
> reader think that a SCSI write command with the FUA bit was not propagated
> to the device before this commit, which AFAICT, is not true.

It was not with the default libata.fua = 0, since the drive would never be
exposed as having FUA support. See ata_dev_supports_fua() and its test for
"!libata_fua" and how that function was used in ata_scsiop_mode_sense().

The confusing thing here is that indeed there is no code preventing
propagating FUA bit to the device in libata-core/libata-scsi for any
REQ_FUA request. But the fact that devices would never report FUA support
means that the block layer would never issue a request with REQ_FUA set.

> 
> If the intention of this series was to only send a ATA write command to
> the device, if the device has the ATA_DFLAG_FUA flag set, then perhaps the
> series should include a new commit which either:
> -Adds a check to ata_scsi_rw_xlat() so that it only sets ATA_TFLAG_FUA if
> ATA_DFLAG_FUA is set;

See above. I do not think that is needed since the block layer will never
ever send a REQ_FUA request when ATA_DFLAG_FUA is not set.

> or
> -Adds a check to ata_scsi_rw_xlat() which returns an error if the SCSI
> command has the FUA bit set, but ATA_DFLAG_FUA is not set.

That would be possible for passthrough commands only. What is going to
happen is that we'll now get an error for that write if the drive does not
support NCQ or has NCQ disabled.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

