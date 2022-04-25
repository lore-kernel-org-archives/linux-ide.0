Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77244C433FE
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 00:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbiDYAl3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 20:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240007AbiDYAl2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 20:41:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00805AA65
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 17:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650847106; x=1682383106;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=3GKo3akmPmbsoMGomkRR004mzFEvzpwtTzal1nbSqPE=;
  b=r21I9EtbYWbHGg8Ii3kXXdbhXr+d06g9Jxx/F9NqM3i65NPe69iSGWh4
   VIb74Jq8czaZRSP6DqiqQPHL88oGzDbfDYPkajS7mg3lUA7GTg007luWb
   LaAc9kQXHxjTYMX/RyiUJk5HT1yKmBsey8r+1q0NVFv3IWGg73k0bheCt
   9qMlxiP+OFUWhJxRStDe8GpMu8pPtYOYUZIHSk1vqM5I0hJszFR9KqbN0
   R4Tp49HOmymlBUxxxYhOdY+uQHE1v3y6sTzLEak4ZTnkW/RIFMNe/t554
   Vl1cgiN9n1xJjsOnAzzwHzxXzfF4PTfT4ZWvahOJUG7nlwtJzo9OnqBWw
   A==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="302912981"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 08:38:23 +0800
IronPort-SDR: CdbiPqNXllwmH9x6HIA9U5aspCASHytHAgcuxSagecCph5sqJauNdHrDtrUpKEU/wB1+e+QGfg
 MdKlrKiTDwL7qHwMq81+PyblPFJ89FUL7SITJdrU8xWF9Au1juhZeGKkM73qtgvesOEvfZEyg3
 alFY7Z+OtN+cgwpgXlN+4FGlt44cbqy32RctQXM5Nssc24K2DSKzwRCXJweUK67JaeC8jZHBga
 Fxeqon8RlS/L1So8ptNAUeYZtBjBvmE/BctqICUaOt3MXyfBt16Pv/UquQvyTDE4KxpcByMbmU
 Q35F+AgV4xKTYLCQLvsGWz2h
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:09:19 -0700
IronPort-SDR: lXXMjmLA6wcaHOp8KwcXa2zF130Fko5Syw8vw6gnyjkzVxWxTiS7gztB37SV5nv86PzgqEPVXg
 f8kO60jyIRQfIK7BALGnUKZ06MyKcMdagD7PKaT883dL6yNho3OXJMfB/EHGLn22OAuTtmskH8
 SbrKdlYj9lMuL65TiqfknOGcro7gRlSF4nPzvRY1jNqIN0imw0hjjy66gc+oiW0mmMM1ueiulR
 7P4Wl21+ZNt+DTOVhUf3S2hj20cNCB+ZF/4px5nFe02GzuTXx8tfr0FVmiRyfY4lZCanZx8Bng
 Krw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 17:38:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmmMb4bhGz1SVnx
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 17:38:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650847099; x=1653439100; bh=3GKo3akmPmbsoMGomkRR004mzFEvzpwtTza
        l1nbSqPE=; b=XepVK9VKtgWYgdcctEgyewN+KILSteQzCsBEdPkefIX7d4Xn5OJ
        9WZbhMCJKuxJ1wl9zDgJGJRA4JcM/IiL+52W6UpthgH3zuw+hossAjuwpSKJ4BY3
        0zMdQQdv7eInw8iW7nIQeWiVuoMWZl810eUgR87vqv1o6AA6nehNM5gFvaN52GyT
        sqUUWx++daxof40d2swOYDVUR1lsRWW4bq8BXFplq9zRZkEvsxeUKhtiVHTmoT/u
        eXvxQH6JlbgKRLkLAkZyB7K8ZpTAJ7Gir3Td6ICTotCcIkyGMTtvCg5RZZFkXHtg
        dEHvxWd3/itbRB2vT5Exg5kN6mb0eMG+yqA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nHrgd4JOXfE9 for <linux-ide@vger.kernel.org>;
        Sun, 24 Apr 2022 17:38:19 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmmMZ2YmVz1Rvlx;
        Sun, 24 Apr 2022 17:38:18 -0700 (PDT)
Message-ID: <39f1ac3d-d8d8-1585-360f-ab534dac2a00@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 09:38:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] ata: pata_marvell: Check the 'bmdma_addr' beforing
 reading
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Zheyu Ma <zheyuma97@gmail.com>, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20220421013920.3503034-1-zheyuma97@gmail.com>
 <e29fd64e-62ea-746e-f0fb-02ce86b4e61e@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e29fd64e-62ea-746e-f0fb-02ce86b4e61e@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/22/22 08:47, Damien Le Moal wrote:
> On 4/21/22 10:39, Zheyu Ma wrote:
>> Before detecting the cable type on the dma bar, the driver should check
>> whether the 'bmdma_addr' is zero, which means the adapter does not
>> support DMA, otherwise we will get the following error:
>>
>> [    5.146634] Bad IO access at port 0x1 (return inb(port))
>> [    5.147206] WARNING: CPU: 2 PID: 303 at lib/iomap.c:44 ioread8+0x4a/0x60
>> [    5.150856] RIP: 0010:ioread8+0x4a/0x60
>> [    5.160238] Call Trace:
>> [    5.160470]  <TASK>
>> [    5.160674]  marvell_cable_detect+0x6e/0xc0 [pata_marvell]
>> [    5.161728]  ata_eh_recover+0x3520/0x6cc0
>> [    5.168075]  ata_do_eh+0x49/0x3c0
>>
>> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>> ---Changes in v2:
>>      - Delete the useless 'else'
> 
> Note for future contributions: The change log should be placed *after* 
> the "---" that comes before the "diff" line below. Otherwise, the change 
> log pollutes the commit message.
> 
> I fixed that and applied to for-5.18-fixes. Thanks.

I completely overlooked that this needs a CC stable...

Greg,

Could you please pickup this commit for stable ?
In Linus tree/rc4, it is:

aafa9f958342 ("ata: pata_marvell: Check the 'bmdma_addr' beforing reading")

Thanks !

> 
>> ---
>>   drivers/ata/pata_marvell.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
>> index 0c5a51970fbf..014ccb0f45dc 100644
>> --- a/drivers/ata/pata_marvell.c
>> +++ b/drivers/ata/pata_marvell.c
>> @@ -77,6 +77,8 @@ static int marvell_cable_detect(struct ata_port *ap)
>>   	switch(ap->port_no)
>>   	{
>>   	case 0:
>> +		if (!ap->ioaddr.bmdma_addr)
>> +			return ATA_CBL_PATA_UNK;
>>   		if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
>>   			return ATA_CBL_PATA40;
>>   		return ATA_CBL_PATA80;
> 
> 


-- 
Damien Le Moal
Western Digital Research
