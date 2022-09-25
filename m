Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EFCC04A95
	for <linux-ide@archiver.kernel.org>; Sun, 25 Sep 2022 22:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiIYW50 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 25 Sep 2022 18:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYW5X (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 25 Sep 2022 18:57:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9900722504
        for <linux-ide@vger.kernel.org>; Sun, 25 Sep 2022 15:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664146641; x=1695682641;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=hoagbs8laoeDOurQdBxXUfGTn14PxHGreYo1BEykcXQ=;
  b=V/hFmQc4faNRgWmi+zDZSH4DSFck/lBDafbRbhfI4VYEPSHGTiLE91Sg
   JDFNYqofLW7HMrq82fsqU11xrggF/kB8uDQKdEFtPLz91PSsAVQ1KIl+Q
   oBDoEPmvJuJMfbpCAnRYJvz6X1q+Uu2Uh5XKD3Widxabnb3AOCzUeMGex
   ieCBpyXIv1FpEb7dTAspk+uuJQBlUAhRQI4oLimwrODkdAMdXaWB8/i1y
   ncuaDotfY+EOVsM7iGPCK+uko78xcRBaAGyMOWoqWduJ/Jn0bZB1AnoI/
   Z9KjPolSypZQsaoe/DCFTi4UfTOwvtUTEiHc/Qxzez160QQhmmJzjIfCV
   A==;
X-IronPort-AV: E=Sophos;i="5.93,345,1654531200"; 
   d="scan'208";a="210603314"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2022 06:57:20 +0800
IronPort-SDR: nOyWcc1sO4nO1UsEtPPAe+gwemD8HAzcz7Sy/gVuTbq2TrZ864BehyUIe7Ou7GgNnuvozNUoTq
 YzCasUF+KxEEPy+Y1+kjPFANXm6u6aUK8CrXL4G4EEMtRzEGXFAGenTNUggGXY5vr8FdRPBsxg
 Pc37K5zFhNVjUOJqtZWOAW3sJ9+ekVYits5a+Squc7WCQJn1LT9DGIVhGltqj+RrHi7uieH9zE
 EF1KPGNJ+KhwuRu4BfiRirCb9U8+F6trIc/R+yN4kDSZ4LCnrVfmKwiXg5TPL7atarj1N1zI09
 GIh1Z27IOpffJ1fiuYdg8BY4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 15:17:20 -0700
IronPort-SDR: NzzeNku+nK/fBC1K+l5w3mqN6BNZhjliAr1LY0dKdwlCO40+D5+OV7npHlP86mTMeIBf30KkuJ
 7Uk7N53fHpmkMfrbnJWJGF4iJ5RNW1sc1z2T50lUKH7XAk/h54t8gZQHsLvyuSsBpVMy5+ESqf
 +JEib1ujI8Il8RiRVsnT3/idHuP4NdvSg0yl82KPYARfR+ANLboNkI0IcaF2MZkegYOiDSOcY5
 3NTdNTGjr6LjtfDrA1QOqpI+zD088fiqAd0CkAz+Dbjkh0gP7/JhXz24tgeZJrdi+iV4eii7kO
 HFE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 15:57:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MbLr068dNz1RvTp
        for <linux-ide@vger.kernel.org>; Sun, 25 Sep 2022 15:57:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664146640; x=1666738641; bh=hoagbs8laoeDOurQdBxXUfGTn14PxHGreYo
        1BEykcXQ=; b=sggI3+/hg/OoMlaRY+Uf9STp6gJKi/LiBpgIYNNhDgZQOlCPz4R
        HLa1EdyXt8zfDlSGlssUdbOA6aavlT6PtLlcKf4xNx0krFrfVnqJQsor8bMuUdVH
        K35ozyKbzf7wbDEY97JsmMfSS9fbaJNhfRE9GEBcpu9oYxshBi4pw2zci2CD3EIA
        XVKv2SNZ8PI/sZozVb+K1BD+g2BpBwDpV2Mvd4LNtZW0y6ocJ1MkcbT8fJ+rHBk6
        A7bU1+wfSqIhmMKnAtpgNXsU6mKqUjRC0MJg9qV20h91tL8TVMIQyrNNT2nfqRmz
        vNXYupR4hCrcSegEmWUi9HDFBPqVpad5lag==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4gLHlzUEABkq for <linux-ide@vger.kernel.org>;
        Sun, 25 Sep 2022 15:57:20 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MbLr01R1rz1RvLy;
        Sun, 25 Sep 2022 15:57:20 -0700 (PDT)
Message-ID: <efa832ac-2538-7593-f69d-238d18a196f0@opensource.wdc.com>
Date:   Mon, 26 Sep 2022 07:57:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
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
 <4c72e57c-2544-1163-320d-0ec6420deef5@opensource.wdc.com>
 <223632d5-6d6f-f957-0a27-0b5b5d5ad91a@staalenberk.nl>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <223632d5-6d6f-f957-0a27-0b5b5d5ad91a@staalenberk.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/23/22 21:07, J.J. Berkhout wrote:
> 
> 
> On 23-09-2022 00:08, Damien Le Moal wrote:
>> On 9/21/22 21:38, J.J. Berkhout wrote:
>>> Hello,
>>>
>>>
>>>
>>> On 21-09-2022 13:58, Niklas Cassel wrote:
>>>> Another way do disable lpm is to do:
>>>>
>>>> $ ls -al /sys/class/scsi_host/host*
>>>>
>>>> Find your device in the list. My device is:
>>>> /sys/class/scsi_host/host13/
>>>>
>>>> Print the current lpm policy for your device:
>>>> $ cat /sys/class/scsi_host/host13/link_power_management_policy
>>>> med_power_with_dipm
>>>>
>>>> Anything other than "max_performance" means that you have (a varying degree)
>>>> of low power modes enabled.
>>>>
>>>> $ sudo sh -c "echo max_performance > /sys/class/scsi_host/host13/link_power_management_policy"
>>>>
>>>> $ cat /sys/class/scsi_host/host13/link_power_management_policy
>>>> max_performance
>>>>
>>>> Try reading from the optical drive after ensuring that the policy is
>>>> "max_performance".
>>>>
>>>
>>> Yes, this worked and did the trick!  Reading without any errors.  I did
>>> not yet try to write, but will do so today.
>>> When booting with libata.force=nolpm  the link_power_management_policy
>>> was still med_power_with_dipm and I got the dmesg:
>>>
>>> [    0.291452] ata: failed to parse force parameter "nolpm" (unknown value)
>>
>> What kernel version are you running ? This should work with the latest
>> kernels. Your kernel likely pre-dates the addition of all the ata horkage
>> flag as boot parameter options, which I think was with 5.18 kernel.
> 
> Yep, I run Ubuntu 5.15.0-48-generic kernel.  I circumvented this by
> using sysfsutils with
> 	class/scsi_host/host0/link_power_management_policy = max_performance
> in the /etc/sysfs.conf file.  As long as I don't mess around with my
> hardware, the host number should stay the same.

OK. Then "nolpm" not being a valid parameter is normal then. I wanted to 
make sure there is no bug in the parameters handling :)

> 
> Kind regards,
> 
> Jaap Berkhout

-- 
Damien Le Moal
Western Digital Research

