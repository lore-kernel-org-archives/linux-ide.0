Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B879C433FE
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 23:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJGXwg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 19:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJGXwf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 19:52:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C300251417
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665186754; x=1696722754;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/XPX68YbfcsqdQo5snbqAzOlcH+QgsmCpUqEiyF1fVg=;
  b=NbA8Y6ZQBMK4f2qx9C8FW5bti9kiDxJEx2WdbcTpV+9/pfXaQ9SW+Kuc
   qIO8sk1wkyrw7tYgQfONpZ7zg31mYC8FVO8YNU4k1K1LLjCl67L4H0Rk0
   sz/iO1Ks1LZqrcOiSU896uL6Hj4Khqz8A/epxNGRZEVkWq28XlaCCV/te
   SMWtAtk9dPOjsXu0ZJStjMdyfK8mQBFMhWGL/sNKdswknte5HuocisTxN
   H6IDdG2+PdbOFygidrCTonpGVJ8txW2COHdH2LtgzWnH68ZAMevAA+6z7
   KpjjOc6m117xzVLkvvto0m0qr5IYS5vxQWu89FSOZ1Wn4uYkvTpvZjnt/
   g==;
X-IronPort-AV: E=Sophos;i="5.95,168,1661788800"; 
   d="scan'208";a="325378919"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2022 07:52:34 +0800
IronPort-SDR: Vd50tMSSHBHyQOItd5DQjKMLqzufrKIVInHf11gIATtYUyHCgKh61PH5qPwnDqSBPzTzJCbZw1
 X8bJ87NQLSxRcCvER8xNbwaEAaPYr0JnFQh2lZsXnGGZwuCSziC1BAMzgCvOpIjVbkuTPvHYbr
 65ogzTFjQHct7WYECZnXZ085CGo4fCaQA9lxjULLxVEZLs8y/kAkBZY4JkA5rtjcfcDrf+69It
 uoF58AJm+p4Dto8kh6h0NKtUPLa7DFggKA8kgGfHF95WNaK0y00SKdQlwE4A4LNpI5ftMqBOA+
 +L0ALCUMQ/JP54n2o7BtHEGY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 16:12:18 -0700
IronPort-SDR: e6TEwbMimJS7SSuCNSjBvUnb9EijrIqmcEPIcwpkaeh+f9PP4VZKUDuMf0NU4v4I1RT0nS/CW9
 PWOzj4L+5A88bhe5sh3XL3onj10UxKIdUNska3+lzOrAq3NdGklXZYnjLZGeloqM3HlgEgmEDv
 1+S9moXKgdsaA+TpwsUj2G9KK2MbA5wy/z8NjbI1uNg/fFXOAtysZ3jEp5dUZeW1UIOljthR+I
 MOOqNtzqit4axNL7iGaMHnDeUBPCI9HK5YeKCeoPtbxuTLnYsgu4rFk/nmUd7jNJEUiHSMY32/
 l0E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 16:52:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MklV95x2Yz1RvTp
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 16:52:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665186753; x=1667778754; bh=/XPX68YbfcsqdQo5snbqAzOlcH+QgsmCpUq
        EiyF1fVg=; b=GVBaqD3BYg5rSWx/Ivox/D/kqJgornDSjJPOOG4VZwTgeyONpF3
        JCzVW8ckuqDiTnKiKD2hU96SktzRdXd9xCPh9d5n0DLoFE8Ml/E3Yb7dtT21ZV6o
        mkOvJpig5Fa70m9275pa4jfUO+1FUuKXE/xa7AIkCJ+G7/Iao2NSfZKVVrM71k89
        T3qtL2Nv3SZJEAlC9V78Vxnc88aPqfBQd2UEx/sPwAqdB+AKXqL0jB4q2hCF04hY
        B7oY3dP4UNQN2WnEfNfmDqbTtoRcPtPvxwok7MLsFCAhqgB79FxbMnAQzG3ME7xA
        G0rlrnsfF6LKpzh+sEb1cvfNYoVQJ0QThuQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KUmwEmDeuRCC for <linux-ide@vger.kernel.org>;
        Fri,  7 Oct 2022 16:52:33 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MklV85Lwjz1RvLy;
        Fri,  7 Oct 2022 16:52:32 -0700 (PDT)
Message-ID: <30fc7577-55ed-f780-a217-25ddc75e9bd9@opensource.wdc.com>
Date:   Sat, 8 Oct 2022 08:52:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 4/4] ata: libata-core: do not retry reading the log on
 timeout
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "john.garry@huawei.com" <john.garry@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
 <20221007132342.1590367-5-niklas.cassel@wdc.com>
 <ac65e0db-05a8-65a1-4439-c1021e23d022@opensource.wdc.com>
 <Y0C6pUSjHqIZF0Hg@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y0C6pUSjHqIZF0Hg@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/8/22 08:47, Niklas Cassel wrote:
> On Sat, Oct 08, 2022 at 07:33:54AM +0900, Damien Le Moal wrote:
>> On 10/7/22 22:23, Niklas Cassel wrote:
>>> ata_read_log_page() first tries to read the log using READ LOG DMA EXT.
>>> If that fails it will instead try to read the log using READ LOG EXT.
>>>
>>> ata_exec_internal_sg() is synchronous, so it will wait for the command to
>>> finish. If we actually got an error back from the device, it is correct
>>> to retry. However, if the command timed out, ata_exec_internal_sg() will
>>> freeze the port.
>>>
>>> There is no point in retrying if the port is frozen, as
>>> ata_exec_internal_sg() will return AC_ERR_SYSTEM on a frozen port,
>>> without ever sending the command down to the drive.
>>>
>>> Therefore, avoid retrying if the first command froze the port, as that
>>> will result in a misleading AC_ERR_SYSTEM error print, instead of printing
>>> the error that actually caused the port to be frozen (AC_ERR_TIMEOUT).
>>
>> Beside ata_read_log_page(), are there any other path that do a retry after
>> ata_exec_internal_sg() fails ?
> 
> Let me check and get back to you.
> 
>>
>> Another note: this is patch 4/4 but I did not get any patch 3/4...
> 
> It is here:
> https://lore.kernel.org/linux-scsi/20221007132342.1590367-1-niklas.cassel@wdc.com/T/#t
> 
> My scripts probably didn't add you since you are not a maintainer or
> reviewer for drivers/scsi. I should probably have added you manually.

Yes please, always send full series.

> 
>>
>>>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>> ---
>>>  drivers/ata/libata-core.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 1cf326dd7c41..6ae5787103e7 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -2000,7 +2000,8 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>>>  	if (err_mask) {
>>>  		if (dma) {
>>>  			dev->horkage |= ATA_HORKAGE_NO_DMA_LOG;
>>> -			goto retry;
>>> +			if (!ata_port_is_frozen(dev->link->ap))
>>> +				goto retry;
>>>  		}
>>>  		ata_dev_err(dev,
>>>  			    "Read log 0x%02x page 0x%02x failed, Emask 0x%x\n",
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research

-- 
Damien Le Moal
Western Digital Research

