Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1657DC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 23:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD606115A
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 23:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhKKXGe (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 11 Nov 2021 18:06:34 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38467 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhKKXGd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Nov 2021 18:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636671823; x=1668207823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K9GF9DeiyyJ2comeTBbivDq3SV6XmAwO5vZMnT33uxY=;
  b=Z4kiog6Vk88te6CUDGE484UVXL37DxLsiqtlDtBJfBVevaaY8I2yG2z9
   YLJnc+KiZ/iQ7YEivBPEllfPQMFI7w3cz0m6z0w7FRlkt5g0CH9NxvCyf
   CNkZhnxT+GXsOAgfNgdC/sZBgfQxpUIHxJHdMpfRbPkMeaPB0EQ6toIbV
   +YYZ4o8u78/nNsBWBgWzAU69937qsOdSabYZ7aZReCiy+Quyi1GKPNe49
   xOUzDscUvfQvc09ubJlBRv2MfXlnfrkYioWUrV9wqJhyjVmeCSDXizirj
   i0s//510nTPpGm34NwxbL/xku5x2HZmRTLOdWK3fGDuKTuf5B4NC2q9ax
   w==;
X-IronPort-AV: E=Sophos;i="5.87,227,1631548800"; 
   d="scan'208";a="289320068"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2021 07:03:43 +0800
IronPort-SDR: qV5X2IyZXwZ5RviyTUyI6vZnwAjw+Up1kdjWvWg2RFOIYwm69vVSmQZDvwS4yE2KhErMdyK3yg
 16fE4DZ1CEjQLOYOTzh77cTvjpd8LnZRC2MwphLaZkPvH2SdVmI6kzCLQ3YkdnOtscixw2x5Bk
 lFibzr+FUuWL9fGdd6r2Co1LMWQA0ggw4QS6Y7Pv7DYPKn+yp0EG82bXzsTWI7rquDJ3rHJ1xk
 x4Zrpz5iir4Un7cABJ6RfmQZeDIAb7U1pRLX5fOeicm1lE1jB6mDx7KzMCLQjRLR/4YjqzAWST
 3kK5sY9P8P/8X/KywA1YsAMk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 14:37:20 -0800
IronPort-SDR: gKnaOMDqlm9bYZp6jaMOVVB0VZd1z+v9r27/7eHBlphcrUUR86bbE2yM+RtcvFutwnq7FPDKut
 tBHnSu5ZkkRtYSxzOU6ykKu7htVkH1y2+8fKuaMlAeGgqLjtWEPkqyMmYiNPvQ8K+6oi4kR5qB
 3CelTxuiEjQ8bzFWBsxwFuVmL2hyPdwjaEAuqUUwHLKivztcS0whyaJ5aqWr+ElW2IfR0FVNmQ
 lBM6XpiA3RBZE3jSgZ7BKjbMw09fQyS8TAUH7Nm8tEMiGdqgJe8vfVLUw+2Y7PohQBpneOW1P9
 iVs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 15:03:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hqy2727hjz1RtVn
        for <linux-ide@vger.kernel.org>; Thu, 11 Nov 2021 15:03:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636671822; x=1639263823; bh=K9GF9DeiyyJ2comeTBbivDq3SV6XmAwO5vZ
        MnT33uxY=; b=KfudAHHeGV6ieE221tmJo9xoL1LFYRzqkPZnesXOB8PRAJSYK7O
        VSOG5pOtKghJ8P1ahWFRLlcfiatYPoR+xMNNZrAvRYnTzAXJ9Fag/Y9ejj6Qy3Lx
        +ky/NvHmrrgjBODtX2uZXOHqRamyif578f388pLvLroZFd5ViEwZw7/iI4N91qdt
        IIgVZexd1Nv3Nmj5HLZo8sm5rANuLN+/TiZjk2lbKJ+tNVroROZvzJOPah+hFzDh
        TiGA2ujYZsaKXPZoL20K34UPhgjcUFRLaB/N98ChTNnoO5ALhAcz1UWqYRnJa0Iu
        Ak1yGeCUXq4UjuiBDYNeGl0tZpNmWd2sppw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o6UeEplpnpDL for <linux-ide@vger.kernel.org>;
        Thu, 11 Nov 2021 15:03:42 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hqy252KlVz1RtVl;
        Thu, 11 Nov 2021 15:03:41 -0800 (PST)
Message-ID: <9eb04b1a-52a6-a8d3-b5b7-04df8cb4c2e2@opensource.wdc.com>
Date:   Fri, 12 Nov 2021 08:03:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] scsi: fix scsi device attributes registration
Content-Language: en-US
To:     Steffen Maier <maier@linux.ibm.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>
References: <20211111084551.446548-1-damien.lemoal@opensource.wdc.com>
 <0cdf8e28-2fcc-9aa6-e8cb-ef1c0c77bd69@linux.ibm.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <0cdf8e28-2fcc-9aa6-e8cb-ef1c0c77bd69@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/11 19:35, Steffen Maier wrote:
> On 11/11/21 09:45, Damien Le Moal wrote:
>> Since the sdev_gendev device of a scsi device defines its attributes
>> using scsi_sdev_attr_groups as the groups field value of its device
>> type, the execution of device_add() in scsi_sysfs_add_sdev() register
>> with sysfs only the attributes defined using scsi_sdev_attr_groups. As
>> a results, the attributes defined by an LLD using the scsi host
>> sdev_groups attribute groups are never registered with sysfs and not
>> visible to the users.
>>
>> Fix this problem by removing scsi_sdev_attr_groups and manually setting
>> the groups field of a scsi device sdev_gendev to point to the scsi
>> device gendev_attr_groups. As the first entry of this array of
>> attribute groups is scsi_sdev_attr_group, using gendev_attr_groups as
>> the gendev groups result in all defined attributes to be created in
>> sysfs when device_add() is called.
>>
>> Fixes: 92c4b58b15c5 ("scsi: core: Register sysfs attributes earlier")
>> cc: Bart Van Assche <bvanassche@acm.org>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>   drivers/scsi/scsi_sysfs.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>> index d3d362289ecc..92c92853f516 100644
>> --- a/drivers/scsi/scsi_sysfs.c
>> +++ b/drivers/scsi/scsi_sysfs.c
>> @@ -1301,11 +1301,6 @@ static struct attribute_group scsi_sdev_attr_group = {
>>   	.is_bin_visible = scsi_sdev_bin_attr_is_visible,
>>   };
>>   
>> -static const struct attribute_group *scsi_sdev_attr_groups[] = {
>> -	&scsi_sdev_attr_group,
>> -	NULL
>> -};
>> -
>>   static int scsi_target_add(struct scsi_target *starget)
>>   {
>>   	int error;
>> @@ -1575,7 +1570,6 @@ int scsi_sysfs_add_host(struct Scsi_Host *shost)
>>   static struct device_type scsi_dev_type = {
>>   	.name =		"scsi_device",
>>   	.release =	scsi_device_dev_release,
>> -	.groups =	scsi_sdev_attr_groups,
>>   };
>>   
>>   void scsi_sysfs_device_initialize(struct scsi_device *sdev)
>> @@ -1601,6 +1595,7 @@ void scsi_sysfs_device_initialize(struct scsi_device *sdev)
>>   		}
>>   	}
>>   	WARN_ON_ONCE(j >= ARRAY_SIZE(sdev->gendev_attr_groups));
>> +	sdev->sdev_gendev.groups = sdev->gendev_attr_groups;
>>   
>>   	device_initialize(&sdev->sdev_dev);
>>   	sdev->sdev_dev.parent = get_device(&sdev->sdev_gendev);
>>
> 
> Damien, which kernel were you using?
> 
> Isn't this fixed by?:
> 
> next:
> 
> https://lore.kernel.org/linux-scsi/163478764102.7011.9375895285870786953.b4-ty@oracle.com/t/#mab0eeb4a8d8db95c3ace0013bfef775736e124cb
> ("scsi: core: Fix early registration of sysfs attributes for scsi_device")
> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=5.16/scsi-staging&id=3a71f0f7a51259b3cb95d79cac1e19dcc5e89ce9
> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=5.16/scsi-queue&id=3a71f0f7a51259b3cb95d79cac1e19dcc5e89ce9
> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=for-next&id=3a71f0f7a51259b3cb95d79cac1e19dcc5e89ce9
> =>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?h=next-20211028&id=503f375baa99edff894eb1a534d2ac0b4f799573
> 
> soon in vanilla:
> 
> https://lore.kernel.org/linux-scsi/163612851260.17201.4106345384610850520.pr-tracker-bot@kernel.org/t/#md79869a3966ccceb30eef658b85743e49cf31dc1

I discovered the problem while testing libata tree which is currently based on
Linus master. So I completely missed this fix, which is even simpler than what I
sent :) I should have checked Martin's tree first !
Thanks for pointing this out. I tested and everything is fine.

Martin, Bart,

My apologies for the noise :)

-- 
Damien Le Moal
Western Digital Research
