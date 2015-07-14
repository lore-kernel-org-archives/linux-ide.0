From: arne_f <arne_f@ipfire.org>
Subject: Re: [PATCH 1/2] libata: add ATA_HORKAGE_NOTRIM
Date: Tue, 14 Jul 2015 14:16:15 +0200
Message-ID: <73557bea6ace15e6dc087ede89ee1982@mail01.ipfire.org>
References: <1436873314-22563-1-git-send-email-arne_f@ipfire.org>
 <1436873314-22563-2-git-send-email-arne_f@ipfire.org>
 <55A4F5C8.3010908@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail01.ipfire.org ([178.63.73.247]:56186 "EHLO
	mail01.ipfire.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbGNMQR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 08:16:17 -0400
In-Reply-To: <55A4F5C8.3010908@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 2015-07-14 13:43, Sergei Shtylyov wrote:
> Hello.
> 
> On 7/14/2015 2:28 PM, Arne Fitzenreiter wrote:
> 
>> sone disks lose data at trim also with disabled ncq
>> so this add a switch to force disable trim.
> 
>    You forgot to sign off on the patch, so it can't be applied.
Ok. Next time i will not forget the "-s"
> 
> [...]
>> diff --git a/drivers/ata/libata-transport.c 
>> b/drivers/ata/libata-transport.c
>> index d6c37bc..3a13c7d 100644
>> --- a/drivers/ata/libata-transport.c
>> +++ b/drivers/ata/libata-transport.c
>> @@ -569,6 +569,8 @@ show_ata_dev_trim(struct device *dev,
>> 
>>   	if (!ata_id_has_trim(ata_dev->id))
>>   		mode = "unsupported";
>> +	else if (ata_dev->horkage & ATA_HORKAGE_NOTRIM)
>> +			mode = "forced_unsupported";
> 
>    Indented too much.
Should i change this to "unsupported" or better to something else?

Greets,
Arne

