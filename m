Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164FC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 16 Mar 2022 23:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbiCPXY2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Mar 2022 19:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245693AbiCPXYX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Mar 2022 19:24:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068AA5F87
        for <linux-ide@vger.kernel.org>; Wed, 16 Mar 2022 16:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647472988; x=1679008988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YG3c9enGf73FZQYfT2r6IIW+DLqVkhyrPxUwVJug/IQ=;
  b=WJbCkY2Kldbk3/WcYZQF6dRc5c7T+tyARLZDDb2sBFDMOd4njifG41CP
   LFcwB/uRxuC2tL5iWaTMxUHqKQ4V/CCV8e9ngj9pKs+Ocp9l+1envD8jW
   39FugdPsySRA5nptiRlvdEOmOH2X8GFq+YCT+OuWdzpXtxmYZZ8LxJuPv
   RqbgAfdeXsKOsMEsukdQEhXpiUkLQOoXQPEoFJtMvx73FZpVU1AiMJbk9
   IVRe910S//pZs0UNb7G/UpZj1A8415ZxXTLCPqqlY2wwAwAq/apkZ6DOH
   oGmLDsMC+36lMBjNZic1kno9Zx8LRDsnHX16iBR2/yJ2k2veCNTHJVZEo
   g==;
X-IronPort-AV: E=Sophos;i="5.90,187,1643644800"; 
   d="scan'208";a="194466686"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2022 07:23:07 +0800
IronPort-SDR: AKa2FN3Dj3Xg+ZYXlFWb/4ZWqNU+3q64kDN7fa9OIF1iSEgb2CvAyMrpvwESzc+KNUFgsmBYpo
 Rck/bNmzQLjBaJfx3fzBC1w7HS7aupZA0Zte4piBC94eZ2bYjYPyuDY5CO+w56cNnPJKwLvbR1
 FS1GHFormXL9wXaZGRN1nxw7JwP8BqBwUvT0y42JiGkOwhfyrTw/DhDGYp4pJ+Jpvqz0FTxajw
 GYAjAX2SiLmtsVuG46A1sbtFbLvLiUDVL7OcI/KRpSq3D0ts9W06333090t4gsmyQZOx/1LCHH
 skfcU3qgfrHo0SL2SAgpzVx5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:54:13 -0700
IronPort-SDR: QdrZbNtBI7DH2MZeCtclrwO5/tZ5XquBfmR7FvOGuEk+IzD++bwNA8twMvTSMLW3nd5i7qtYmG
 sI0/xjX5BEpVfSosunLT6mkRaJroERQVWnOlmNMsEGPnZ2FalgFogo2/267wwo2Ht9aDFzBrW5
 mLBpdV2P9BY46P0s3CX35vPX/t+VmQ1AG8TykRH6C/iL+yzz+rAK4PdF4Yt6y10Fw0dad8cveN
 LZW/TLft+q32IPOH0qS+8G+sSTpQcNf1NddMwo5JCrozBk0s2zdqXBGao800J8KfHoVZdA6w7p
 gN0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:23:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJmXq45Pgz1SVp4
        for <linux-ide@vger.kernel.org>; Wed, 16 Mar 2022 16:23:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647472986; x=1650064987; bh=YG3c9enGf73FZQYfT2r6IIW+DLqVkhyrPxU
        wVJug/IQ=; b=ZlcFFOQcJwkYtdSKzLDONIb2R/8b/na7A+bzhx2GgA5SDvB/32c
        W3MDmSMa/WPnB99MS3E1rylqGWPLP1zOl6AnqutB5uKozKsB4PmK2QNbGPcRF3Ne
        VWaa5kPeuuTkmecfDDpAYrVMwCHAIINOokN6PGxDb1+HuyD1Pzodt5wlyLmRi6+v
        zC79Vpvs1jEVY/NM+9ApnR3tamSuJf1Eo7T9pd8ibyFhW+akqTRpdS2FjvVKKUdv
        twzp+zrY/IWyri/yAc+DmYYqIU+POmlNaRym8nAiFfJKXewULvxLpHsX514orlaE
        blxs+zkHba7Gr9YGe8TqBYT7QvhOGG3TsWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zP3oacPKoR9P for <linux-ide@vger.kernel.org>;
        Wed, 16 Mar 2022 16:23:06 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJmXn10xpz1Rvlx;
        Wed, 16 Mar 2022 16:23:04 -0700 (PDT)
Message-ID: <c44014e6-37ca-8a6b-3e8a-5d659bbe1f1d@opensource.wdc.com>
Date:   Thu, 17 Mar 2022 08:23:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH RFC 2/2] libata: Use scsi cmnd budget token for qc tag for
 SAS host
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        ming.lei@redhat.com, hare@suse.de, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.wilck@suse.com
References: <1647340746-17600-1-git-send-email-john.garry@huawei.com>
 <1647340746-17600-3-git-send-email-john.garry@huawei.com>
 <99541f2d-2aea-6bd7-e3b6-21dbc355875d@opensource.wdc.com>
 <650c667f-ca55-821d-4e0f-29fce69a68fc@huawei.com>
 <20220316083439.GA6701@lst.de>
 <4dfcddff-7736-e01e-7fcf-804de77ac623@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4dfcddff-7736-e01e-7fcf-804de77ac623@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/16/22 19:46, John Garry wrote:
> On 16/03/2022 08:34, Christoph Hellwig wrote:
>> In addition to the comments from Damien:  I think we should kill
>> ata_qc_new_init as well.  It is a bit pointless and having it in
>> libata-core.c when it pokes into scsi internals also doesn't make sense.
>>
>> So maybe something like:
> 
> Seems reasonable to me at least.

Yep, that will be a nice cleanup.

> 
> But I'd send these as 2x separate patches.
> 
>>    *	sata_async_notification - SATA async notification handler
>>    *	@ap: ATA port where async notification is received
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index ed8be585a98f7c..5e0bc7b05a107e 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -638,24 +638,44 @@ EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
>>   static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>>   					      struct scsi_cmnd *cmd)
>>   {
> ...
> 
>>   
>> -		if (scsi_cmd_to_rq(cmd)->rq_flags & RQF_QUIET)
>> -			qc->flags |= ATA_QCFLAG_QUIET;
>> +	if (ap->flags & ATA_FLAG_SAS_HOST) {
>> +		/* XXX: add a comment here why SAS is different */
> 
> I think this is simply because SAS hosts have shost.can_queue > 32
> 
>> +		if (WARN_ON_ONCE(cmd->budget_token >= ATA_MAX_QUEUE))
>> +			goto fail;
>> +		tag = cmd->budget_token;
> 
> thanks,
> John


-- 
Damien Le Moal
Western Digital Research
