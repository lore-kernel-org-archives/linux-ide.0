Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7916DC4332F
	for <linux-ide@archiver.kernel.org>; Thu, 15 Dec 2022 11:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiLOLfV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 15 Dec 2022 06:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiLOLeZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 15 Dec 2022 06:34:25 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6DC2E689
        for <linux-ide@vger.kernel.org>; Thu, 15 Dec 2022 03:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671104052; x=1702640052;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vG2CZTetzJqodNdGSRFaORhay86YlyQQZ/e8Z731P40=;
  b=ErRF3mg3aIDmedvS8B9pJMUNYdh6z973AHfXedtISgXCMiT2bjgi1pMa
   kTShGXy9O8qp/zo46h7YzmvCmQq/CHOnyLM6Z3FAQ7RvIAmxp/lsqJtHY
   1xTde4ISkcX3RlAuBJJXwcyKBEhX96C8M2eRGcW6ZOpMsDZoqq1IZqrdo
   zMPF6Z292F+lZ19A0PPqsV2FOZLq+cySX24UGyMjjqwqJLfOuCHhkESMj
   9lOWUlk9JArikurmFLIV1ufQAX2jg9Qyet7hyMlrWr8Vp8jFazTL1rvH9
   fbO4lc7aKDC151ZsDTTozP/xhpEhlbkJb2haeuRlh0yl/slppSyqdOKvY
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,247,1665417600"; 
   d="scan'208";a="218718097"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2022 19:34:12 +0800
IronPort-SDR: iLCm8ys/wnHQGsmOlkRAkkjkm1wEJixLS3wWDw5cziKDmFRfQyUbmMT0sfIfKLu/z61nGggXOA
 BUcSuw/vgB3/cYu0PoLIhn8WGBwMf0QGPEZvZxMVoWoIptaTq3sBOG2F2K73Vfi6LcLZ3kSUPI
 AZc5cjA2sDrJS8ZqlfUzkJNUp70E/DLTLbuqbUZuezORlhyO0ym9wLzLPnZZbG6r5K29pBBePk
 WhvHgjhhf5AAgNpH5E8qOz2vN0fDl2UEi2FqfxdbtdEwGS2qYiUKpiEykG400bO5jrPCIGDFwm
 oo8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 02:52:33 -0800
IronPort-SDR: x9M9Ud+6CHdP0Y0ytbd9VFL6mXdE7vXv1QKZx9LlDDdebEn8TktrMu6YolTIzntVsJJj0zkOhv
 DhtBlD3K6HTeNKoTY4GdkDhXrYEJN5cJwb5/RUcEDIeF95/aP9QCdrCksc4gFa3WArzQup0Pvt
 UHwQ20Q1zY1c7nqm5H7qygrJdddmOwmfCm/LVgsH9CniJsU8EMUErlk5gXMxVoE3fDaWm7q62l
 d7rqh8snSTrhXUyHPiPxl0pN8z+br9d6yY0dS+j5+OwX/wnr6dv3phHoXTD8c8upqnQDsCNofC
 MDk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 03:34:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NXqrM5QhXz1Rwrq
        for <linux-ide@vger.kernel.org>; Thu, 15 Dec 2022 03:34:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671104051; x=1673696052; bh=vG2CZTetzJqodNdGSRFaORhay86YlyQQZ/e
        8Z731P40=; b=SUCqnBoSyxXzwrObu+NiwLDm6z+8/tKRSnzbAu+pfd+2BgbgtS+
        iuHG9lSZ+MZsSLIfc0Vz4g+rSaeJU+ad91HCvovFAwuiSVkxD9pMOa8dSeEMuLKc
        LfsZzs8xwORcrhQ7BZtgibNP0nnHl/GmKkSDhD6oIl/9g7PdPN6CAvUSz5wEW6L1
        PLfKxRJqPmYcFhArMZHyRqzHw2n5iqzwXdElxWW4voeS3vrS1m/8+FK+NwCn8v3L
        YJl36XJGceWrqjqHlOt5qPZD9qy0eCYxY1cAxSU6A12c6ZQlA71B/XRKz03JhFwc
        q2VEqpqk/F3Pjq84yXMoOGMul7E63YeC5Gw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2L90fSyvrLRm for <linux-ide@vger.kernel.org>;
        Thu, 15 Dec 2022 03:34:11 -0800 (PST)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NXqrL0z9vz1RvLy;
        Thu, 15 Dec 2022 03:34:10 -0800 (PST)
Message-ID: <d991d4fd-3b5f-f0ef-5c96-2352a08e1262@opensource.wdc.com>
Date:   Thu, 15 Dec 2022 20:34:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] ata:libata-eh:Cleanup ata_scsi_cmd_error_handler
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Wenchao Hao <haowenchao@huawei.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuzhiqiang26@huawei.com, linfeilong@huawei.com
References: <20221215105747.1927412-1-haowenchao@huawei.com>
 <f552f2ab-895a-14dd-d391-a7b1c9930c88@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f552f2ab-895a-14dd-d391-a7b1c9930c88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/15/22 20:30, Sergei Shtylyov wrote:
> Hello!
> 
>   The subject should really look like "ata: libata-eh: Cleanup
> ata_scsi_cmd_error_handler()"...
> 
> On 12/15/22 1:57 PM, Wenchao Hao wrote:
> 
>> If ap->ops->error_handler is NULL, just return.
>>
>> V2:
>> - Check ap->ops->error_handler without taking the spin lock
> 
>    This normally belongs under ---...

I should read all emails before replying. I commented exactly the same :)

> 
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> ---
>>  drivers/ata/libata-eh.c | 96 ++++++++++++++++++++---------------------
>>  1 file changed, 48 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 34303ce67c14..c445c272e77f 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
> [...]
>> @@ -584,62 +589,57 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>  	 * timed out iff its associated qc is active and not failed.
>>  	 */
>>  	spin_lock_irqsave(ap->lock, flags);
>> -	if (ap->ops->error_handler) {
>> -		struct scsi_cmnd *scmd, *tmp;
>> -		int nr_timedout = 0;
>> -
>> -		/* This must occur under the ap->lock as we don't want
>> -		   a polled recovery to race the real interrupt handler
>> -
>> -		   The lost_interrupt handler checks for any completed but
>> -		   non-notified command and completes much like an IRQ handler.
>>  
>> -		   We then fall into the error recovery code which will treat
>> -		   this as if normal completion won the race */
>> -
>> -		if (ap->ops->lost_interrupt)
>> -			ap->ops->lost_interrupt(ap);
>> +	/* This must occur under the ap->lock as we don't want
> 
>    The multi-line comments should start with /* on its own line...
> 
>> +	 * a polled recovery to race the real interrupt handler
>> +	 *
>> +	 * The lost_interrupt handler checks for any completed but
>> +	 * non-notified command and completes much like an IRQ handler.
>> +	 *
>> +	 * We then fall into the error recovery code which will treat
>> +	 * this as if normal completion won the race
>> +	 */
>> +	if (ap->ops->lost_interrupt)
>> +		ap->ops->lost_interrupt(ap);
>>  
>> -		list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>> -			struct ata_queued_cmd *qc;
>> +	list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
>> +		struct ata_queued_cmd *qc;
>>  
>> -			ata_qc_for_each_raw(ap, qc, i) {
>> -				if (qc->flags & ATA_QCFLAG_ACTIVE &&
>> -				    qc->scsicmd == scmd)
>> -					break;
>> -			}
>> +		ata_qc_for_each_raw(ap, qc, i) {
>> +			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>> +			    qc->scsicmd == scmd)
>> +				break;
>> +		}
>>  
>> -			if (i < ATA_MAX_QUEUE) {
>> -				/* the scmd has an associated qc */
>> -				if (!(qc->flags & ATA_QCFLAG_FAILED)) {
>> -					/* which hasn't failed yet, timeout */
>> -					qc->err_mask |= AC_ERR_TIMEOUT;
>> -					qc->flags |= ATA_QCFLAG_FAILED;
>> -					nr_timedout++;
>> -				}
>> -			} else {
>> -				/* Normal completion occurred after
>> -				 * SCSI timeout but before this point.
>> -				 * Successfully complete it.
>> -				 */
>> -				scmd->retries = scmd->allowed;
>> -				scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>> +		if (i < ATA_MAX_QUEUE) {
>> +			/* the scmd has an associated qc */
>> +			if (!(qc->flags & ATA_QCFLAG_FAILED)) {
>> +				/* which hasn't failed yet, timeout */
>> +				qc->err_mask |= AC_ERR_TIMEOUT;
>> +				qc->flags |= ATA_QCFLAG_FAILED;
>> +				nr_timedout++;
>>  			}
>> +		} else {
>> +			/* Normal completion occurred after
> 
>    Here as well...
> 
>> +			 * SCSI timeout but before this point.
>> +			 * Successfully complete it.
>> +			 */
>> +			scmd->retries = scmd->allowed;
>> +			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>>  		}
>> +	}
>>  
>> -		/* If we have timed out qcs.  They belong to EH from
>> -		 * this point but the state of the controller is
>> -		 * unknown.  Freeze the port to make sure the IRQ
>> -		 * handler doesn't diddle with those qcs.  This must
>> -		 * be done atomically w.r.t. setting QCFLAG_FAILED.
>> -		 */
>> -		if (nr_timedout)
>> -			__ata_port_freeze(ap);
>> -
>> +	/* If we have timed out qcs.  They belong to EH from
> 
>    And here...
> 
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

