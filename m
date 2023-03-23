Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E8AC74A5B
	for <linux-ide@archiver.kernel.org>; Thu, 23 Mar 2023 22:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCWWiB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Mar 2023 18:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCWWiA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2023 18:38:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF2D19B0
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2023 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679611079; x=1711147079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vHziMEpRTG/Xm7IGduGXmXkvW8yHuQd9ddphiPn/Ms0=;
  b=PMSpGI6nxUWA0iCkCwM08PExVLehyQ7NgDBeZryauRptOtxWHny2cfLK
   yZTN/dEbvv4RltZJxOgXFLlsDuBpq0TFdnAFx6BCF5eh7fklNPOp2cpmS
   78irMihDq5RJLf3o7nBe/NCvMoBVF5NndKKIZQ530BoDVq5neSDM9vlZp
   rpAVIgCevkJikKHD4Q7iNbAOwu8qepH4mV5SYV9wEJHb2W/Uk0dq0yUeV
   z4Biz1+wGTH9EqRh8KyyVtFGay2vqzyxHzPSAkmCrnuFGCMrobvEY9zTz
   69VvIc3z9E57vG5PtyCm8+tdlCr0Qfy/JkufGqugMB5sSX9xR5rAYMI4D
   g==;
X-IronPort-AV: E=Sophos;i="5.98,286,1673884800"; 
   d="scan'208";a="224655533"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 06:37:58 +0800
IronPort-SDR: o+K7Uk/qRSdTyMknHqmq//8vmCA1zp2Sggg41pulQKCWE9NCxQfX8mxhUGtuU7PWVYtjPABQs0
 cb858g2yfLRM/paFvHQPENLvs0IQN8VPnQtEw2s58M+8ugccF4ztQZZgXMsfZyv5e+uVywgXH4
 av7zpE2ANavmnAt7iMIL7CT2TVEdABauTIPdkjAkRX+JGTCPAd5JKhbGb4ZhjjCM4EsUPvPAeK
 iMk1+UDQpjOjaKU8EvelQz1iycw3ulRRaCEaLE0KM8rVtegweg1veS/0w4eEdj5ew0lNd8EG7m
 uNs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2023 14:48:33 -0700
IronPort-SDR: y1PUHqV94GzQNYETefGtttYZqtA9cKpELhpcI6xDEUHE/mClIYK1VQ/nRJuqvCudv6uDD69cpN
 Y09uNFkBA1UabT2RNBKWvVF7kIXrpo4kGym+Zf+TmCvhvSeIa3Zkncew5U/ia7U1H673/Ex0K/
 2GcLh+B1vCghR10v7fkzzPd268thmNGWQhkT8vt2Ix1fJsg6dUStMvlivDglg0Zj4JwQFJownj
 j4azQqATTfo1rhNGRiFj1P8vD59tsyd/vNagJyYyUau9GqpAfcNElrHh6m5CFrEh7F3UNCVlNH
 eP4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2023 15:37:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PjKx20blyz1RtVp
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2023 15:37:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679611077; x=1682203078; bh=vHziMEpRTG/Xm7IGduGXmXkvW8yHuQd9ddp
        hiPn/Ms0=; b=uAcI9XJxTFZp7enN1BpyJLDMUi6wLRNrYI7NQh3iknme2Bz4UYC
        6fAXbojRPe4KuOs6UZ1QvU62ep2j2d9SrMHlOJfLkNggkP7FZvBzneCW27p+13zG
        blRdLIUgKT/r3tGRp+j6KBO6b9L1nETK1qrZdNATzKyfRPX2h8wqCH/mGl8yDMbG
        yLVnIrFP66CGck0ir7Pz5n8lA20+xDC6hUHKUZhQZcDm9tSE38LTrANUbL97FoBs
        UWTVmeW/wUVuwMv65koey3FpKALM+p9hNrid6Y5nYE4C5XnGxPdUL2PcyfEcIl/I
        eLPk96MoDvdOTGiYuVbxRbcuZJIKHoehvzg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Efw6nm4roieK for <linux-ide@vger.kernel.org>;
        Thu, 23 Mar 2023 15:37:57 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PjKx10vZQz1RtVm;
        Thu, 23 Mar 2023 15:37:56 -0700 (PDT)
Message-ID: <e3efecbe-408a-60f7-7845-788bdc235012@opensource.wdc.com>
Date:   Fri, 24 Mar 2023 07:37:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] ata: pata_parport-bpck6: Remove dependency on 64BIT
To:     Ondrej Zary <linux@zary.sk>
Cc:     linux-ide@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20230323033836.352672-1-damien.lemoal@opensource.wdc.com>
 <20230323033836.352672-2-damien.lemoal@opensource.wdc.com>
 <202303232201.02920.linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202303232201.02920.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/23 06:01, Ondrej Zary wrote:
> On Thursday 23 March 2023 04:38:35 Damien Le Moal wrote:
>> There is no reason to have compilation of the bpck6 protocol module
>> being dependent on 64BIT. Remove this dependency.
> 
> Great, I planned to do this but forgot. Thanks.

Can you send a reviewed-by ?

>  
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>  drivers/ata/pata_parport/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
>> index 0893a13e7979..2c953f5d1396 100644
>> --- a/drivers/ata/pata_parport/Kconfig
>> +++ b/drivers/ata/pata_parport/Kconfig
>> @@ -25,7 +25,7 @@ config PATA_PARPORT_BPCK
>>  
>>  config PATA_PARPORT_BPCK6
>>  	tristate "MicroSolutions backpack (Series 6) protocol"
>> -	depends on (PATA_PARPORT) && !64BIT
>> +	depends on PATA_PARPORT
>>  	help
>>  	  This option enables support for the Micro Solutions BACKPACK
>>  	  parallel port Series 6 IDE protocol.  (Most BACKPACK drives made
> 
> 

-- 
Damien Le Moal
Western Digital Research

