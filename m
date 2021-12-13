Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99FBC433FE
	for <linux-ide@archiver.kernel.org>; Mon, 13 Dec 2021 23:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbhLMXut (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:50:49 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20364 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbhLMXus (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Dec 2021 18:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639439448; x=1670975448;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Iq4rE9AFlBiu4pRFoedEB6+mxmMnRKKVlnEefSaiag=;
  b=WefsoRjUtHP2CVd80t4QPEeN+EwgZpeP2gHyLg3EXDFDCBALFCQQUryI
   bgghXp+QnAdR/9gDkSTCXsYMA8bMni7laFD/0U7KXGkg7bqjY6M3L1Cs6
   fJrklAJGGhiOM6pkJp8BDpu60rylHEw8u4BXFaJMNuX+hnCmaqhj4SVhe
   EmpTILD1PhJ9c466YMKOurM/pFchavYdBpE1I0GvVFc4Vim+8CZDqovJH
   qBFdAHMXq2QXwym6WY41x4lLmWLtL6NOR0RadogkHQ5G71V20j2NzHu5V
   Gp+O6ZkB9WFiyRwJUhhm/z+OaCJk+lLnhUMPVS3hZNaKKIg9mAfWSRHhY
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,203,1635177600"; 
   d="scan'208";a="292150124"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2021 07:50:47 +0800
IronPort-SDR: 6ILKaNfG3Otyrjpexa/18Hy38mKK8l+fxpxhbaw0FbQZZOMyWfZoE7Dxao91KXg74Mo8udAJWn
 puRaZMCxPrUtAkUHpL50QWt+zZUuDgsAMmXyfFiBIJlfmrNIdLRgstNp1tnkd2plIBRD9xo1Xn
 8hSzV5XN94cgtKD7hrYXGfToNBV8+PStjoSQBc2aBHKBzukXyMiuuKGiIP7M15SFkI3sYekKpY
 xf7nZzSrkhpqiMG1y9JdzCkxjxm2lLNMw/1h74jfq/i7Ff+OunB8pSBWharKbVRCSLv2MthrDp
 3x8XisZT7a9dvuarnlehukJP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 15:23:45 -0800
IronPort-SDR: 0ZLqTcS4NCmCj/cilCQFt9QXfwKAYXj/RgNEqhkZeqrghalkI6aAGvpKxRlEGvacOcClqdpFiZ
 53SdTFusy900AXxs0kJfd+/C2KEP3N/Ws/3AqU6cqvQuY4izgKC0b3bgXBdEniDdI7oHijPUpT
 hWZZ92HkUTHGQiWj6CvuJx1pZX5gbIb2uCeR7pgm4J4lpKHSdXNGzHfywj4ltAo8FXa12t3cbQ
 D8/SDmUAQGD+6bvuEpNMu2LKUvwbTJ6n1ErkA5UdLhCaW2ymn13o9PRXP6x7chV/smINum2b19
 g+c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 15:50:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JCdYg22Ngz1RvTh
        for <linux-ide@vger.kernel.org>; Mon, 13 Dec 2021 15:50:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639439446; x=1642031447; bh=/Iq4rE9AFlBiu4pRFoedEB6+mxmMnRKKVln
        EefSaiag=; b=feKGBx2dIHnJG/aZ+RQwphZMMS3qSmD+iE0jeNehLP/XhGuyIhM
        qB7llE8i/xqghihakytBfeTJLU+C/nBSXQD5UWPmrqgSDuJPnpGvEkDGH+JBhUGm
        xTRAx1qE6QsT3MYLQ2zLYjAjJElxCJws3x4YO1r34LpqREGtWn9EnCORRIE3nrLf
        gyTeMNGvTRKbD9h8QI0gkOHF2FKJGiuvJkOQNBSuBIa4LjxTcjn71Y0cd2tS3zM0
        oYHBOl/xwqxoetQV7tSMZv47N17yxJFYUR3OjOeShYx4tareZRn2M/JWXSlq+M6w
        oz+7CvPisX8U69b3R1uBJJu8JlJ1hdfj+AA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EDM-hZHiFTE4 for <linux-ide@vger.kernel.org>;
        Mon, 13 Dec 2021 15:50:46 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JCdYf0N7mz1RtVG;
        Mon, 13 Dec 2021 15:50:45 -0800 (PST)
Message-ID: <632b632d-a34b-5a75-973b-29586ef9ecae@opensource.wdc.com>
Date:   Tue, 14 Dec 2021 08:50:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH RESEND 2] libata: if T_LENGTH is zero, dma direction
 should be DMA_NONE
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1f57bc3d-d125-7e09-4699-0338ddcc50f1@oracle.com>
 <c6212443-e40a-2813-1920-905e89884204@opensource.wdc.com>
 <e3ff85bc-bf01-c90d-298f-4cbd30b460c1@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <e3ff85bc-bf01-c90d-298f-4cbd30b460c1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/14 7:15, George Kennedy wrote:
> 
> 
> On 12/13/2021 4:37 PM, Damien Le Moal wrote:
>> On 2021/12/14 0:33, George Kennedy wrote:
>>> Avoid data corruption by rejecting pass-through commands where
>>> T_LENGTH is zero (No data is transferred) and the dma direction
>>> is not DMA_NONE.
>>>
>>> Cc:<stable@vger.kernel.org>  # 5.4.y
>> 5.4 only ? What about other LTS versions ? They do not have that bug ?
> Our distros are based on 5.4.y, 5.15.y and 4.14.y, so the fix should go 
> there,
> but it looks like the fix is also needed in: 5.14.y, 5.13.y, 5.10.y, and 
> 4.19.y.

Then please resend with:

Cc: stable@vger.kernel.org

No version specified.

> 
> Thank you,
> George
>>
>>> Reported-by: syzkaller<syzkaller@googlegroups.com>
>>> Signed-off-by: George Kennedy<george.kennedy@oracle.com>
>>> ---
>>>    drivers/ata/libata-scsi.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 1b84d55..d428392 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -2859,6 +2859,12 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>>>    		goto invalid_fld;
>>>    	}
>>>    
>>> +	/* if T_LENGTH is zero (No data is transferred), then dir should be DMA_NONE */
>>> +	if ((cdb[2 + cdb_offset] & 3) == 0 && scmd->sc_data_direction != DMA_NONE) {
>>> +		fp = 2 + cdb_offset;
>>> +		goto invalid_fld;
>>> +	}
>>> +
>>>    	if (ata_is_ncq(tf->protocol) && (cdb[2 + cdb_offset] & 0x3) == 0)

cdb[2 + cdb_offset] & 3) is used again for the ncq test, so you can group things:

	if (!(cdb[2 + cdb_offset] & 0x3)) {
		/*
		 * When T_LENGTH is zero (no data is transferred),
		 * then dir should be DMA_NONE.
		 */
		if (scmd->sc_data_direction != DMA_NONE) {
			fp = 2 + cdb_offset;
			goto invalid_fld;
		}

		if (ata_is_ncq(tf->protocol))
			tf->protocol = ATA_PROT_NCQ_NODATA;
	}

>>>    		tf->protocol = ATA_PROT_NCQ_NODATA;
>>>    
>>> -- 1.8.3.1
>>>
>>
> 


-- 
Damien Le Moal
Western Digital Research
