Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DA8C54EE9
	for <linux-ide@archiver.kernel.org>; Thu, 22 Sep 2022 22:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiIVWI0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiIVWIT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2022 18:08:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8770112FFC
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2022 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663884497; x=1695420497;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=QEcgZ5SUy/1GC/+86jlbUqrP4quCNr/yHF4ngvoql2M=;
  b=DhXy5VK5IQLfKGoXbfUXQVhrviMxHeZCUDoUBuedhnkf8iwBHNhf8JBw
   s9Nr2dE3eV4RpD5LCScy8pZBr7ejxlBvJ2ZZ9xDPyKx9MV4bTzRXDAVP/
   gMdUGQRpl/JMlg67OLj4/eNbM0qWb2zokzf1rP1M3Vybn2+Bblv3z3koR
   6ZI8kV5US/y2O+nIg14DTZsdWsRdKQ0I0keaja6NxKDNf+vJxcqgEjNRn
   2v8qOfHQKAEp0epUQpSf4rTP/nIjuVv8JHL2Mwr+yZysknIYE15a138ol
   nHLm2Ih+ZslAFijfegCPkNa3agDPOt5tlx6rPNF0yH/R92VQII24+6bVy
   A==;
X-IronPort-AV: E=Sophos;i="5.93,337,1654531200"; 
   d="scan'208";a="212489531"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2022 06:08:16 +0800
IronPort-SDR: yLky0GpLrXtisVNlggPf8tsPee50YZUGC+pdFWtXqytbgSMg6gwHvWlv2IqryocgWEDR5GJn7r
 85+NKPZq2MnZwtX0YBptGFcFD26B6LdDfWRZaOlhZXAEIZfh6gjJ8PGJyx0TBx/hMOtr0T0YV4
 5E6mNe7kkbvFWy54jGKCCmgald43KS0P9MGCNbVXf08ZM7DDsoXIa7PzOi/pOIRcd2DfFRy6nL
 s0El9+14GZCJSdkgoFf+qkT3qHvrvqmdXzUEN117tS0syA1WNJW5QjdimgzGgDVPJyO6YWdXhV
 OLjR2bA+rsMrMx97m2XPPlt7
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2022 14:28:19 -0700
IronPort-SDR: NmCm0TEt3RyqUJHlLkf6Gjs/pIy/9/5ZkYJwhKtsCxvs/B/WNCEnBHGAaxdwzRpmqQvLlk9r0u
 xyZb2mX2vJzMi2FlxWrU7HUB2E/9JcafTJ0zbO2jpShdUofIhc8ZRBgrRJMxCPvRiDr1Ayu53+
 iWukrxlqiukRwuXtRd6OKnwlOfO3vLtJt63j1H/h7+28p21Bmpa7naeY9xJNBH1xiQwwTVvbtC
 BNHFyRLMCyce42HUnRPC4EmNUOHhRRQnpyCOsHtUQ8kOWaMPN5HvFB+kDFkZ+3y2inGpQNCPij
 SWM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2022 15:08:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MYTtm26qpz1RvTr
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2022 15:08:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663884495; x=1666476496; bh=QEcgZ5SUy/1GC/+86jlbUqrP4quCNr/yHF4
        ngvoql2M=; b=euxw7XikGBkjy5SH2wZjYhtgv+RRIU6s8ZcBSy8itvTOhDZqIKd
        9ml8s/5bJFOZajrFcaXFP5Zw/Fo1/lhEEamZgIMSeNCvK+MvylKaE32K413Vm+MD
        oL1bjuRbhMNKcfIaMggDW/U1qGPGdkeu479LZknDu/EDwPNuXTk1ATUgzO9jRhbg
        zp6CYqEF3VsAMKH/tqLFuR1c/PCwL2S6HBrhuo+jLkp/TxvxPaV4kLGXLrH+Oen7
        bFuyC/D6c05LpX7jK0gTk/1neWH1GBe6FXKEV/vNvO3ea+xp4ThkVUNM7ZzRORma
        07yEzYQHAVUZUpY4CGjyB1RYTmIEEBW/FCQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XZmGpMPVg1Tp for <linux-ide@vger.kernel.org>;
        Thu, 22 Sep 2022 15:08:15 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MYTtl1239z1RvLy;
        Thu, 22 Sep 2022 15:08:14 -0700 (PDT)
Message-ID: <4c72e57c-2544-1163-320d-0ec6420deef5@opensource.wdc.com>
Date:   Fri, 23 Sep 2022 07:08:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Multiple errors with DVD drive
Content-Language: en-US
To:     "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>,
        linux-ide@vger.kernel.org
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
 <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
 <Yyr8aV5CEOuChpre@x1-carbon>
 <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/21/22 21:38, J.J. Berkhout wrote:
> Hello,
> 
> 
> 
> On 21-09-2022 13:58, Niklas Cassel wrote:
>> Another way do disable lpm is to do:
>>
>> $ ls -al /sys/class/scsi_host/host*
>>
>> Find your device in the list. My device is:
>> /sys/class/scsi_host/host13/
>>
>> Print the current lpm policy for your device:
>> $ cat /sys/class/scsi_host/host13/link_power_management_policy
>> med_power_with_dipm
>>
>> Anything other than "max_performance" means that you have (a varying degree)
>> of low power modes enabled.
>>
>> $ sudo sh -c "echo max_performance > /sys/class/scsi_host/host13/link_power_management_policy"
>>
>> $ cat /sys/class/scsi_host/host13/link_power_management_policy 
>> max_performance
>>
>> Try reading from the optical drive after ensuring that the policy is
>> "max_performance".
>>
> 
> Yes, this worked and did the trick!  Reading without any errors.  I did
> not yet try to write, but will do so today.
> When booting with libata.force=nolpm  the link_power_management_policy
> was still med_power_with_dipm and I got the dmesg:
> 
> [    0.291452] ata: failed to parse force parameter "nolpm" (unknown value)

What kernel version are you running ? This should work with the latest
kernels. Your kernel likely pre-dates the addition of all the ata horkage
flag as boot parameter options, which I think was with 5.18 kernel.

> 
> so the ineffectiveness of this boot parameter seems to be explained.
> Might there be some other syntax for this parameter?
> 
> Nevertheless, my problem now has a work-around and I am very happy.
>  Thanks, Niklas.
> 
> Kind regards,
> 
> Jaap Berkhout

-- 
Damien Le Moal
Western Digital Research

