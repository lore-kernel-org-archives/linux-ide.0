Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13BDC61DA4
	for <linux-ide@archiver.kernel.org>; Thu, 23 Feb 2023 11:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjBWL7d (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBWL7c (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Feb 2023 06:59:32 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F224C99
        for <linux-ide@vger.kernel.org>; Thu, 23 Feb 2023 03:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677153570; x=1708689570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5orrTDY/75WcHDtmRC9cRppWmMIsORWXO3DO/mXOnTE=;
  b=oAxQzr1I+l31gukAAA+5o/Thd09aRPOBl0D67FQjErOR+srqA57k5tVU
   rK8yXrNFri55oO+K/Ji1Nd8371faIPYYhxuNbzB0lVUZiLQnilolAEfsE
   sDecbx8HHZtoWVDdwytTrkSSuoTlfFNWjHHWvjCFRrW/+nEHDgmosLWD4
   NR6Y+sY9GiJ2epULDYMJhpa/B5QMcf2LuIdEzJSWL9+qL9IeF0dyTW7fa
   M0ftBfFWD+xjEl6DkrWATnBWv+n8l2JVVYUSbLIB1Gbodp/uCbFlIe0VY
   9UrTC0ZM1Ssd3gR6dyCAZ+vw5Zh74ler3h3Y6jgUVoQ3xPw/DjRnFaZtH
   A==;
X-IronPort-AV: E=Sophos;i="5.97,320,1669046400"; 
   d="scan'208";a="222278914"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2023 19:59:29 +0800
IronPort-SDR: 2ASzaR1d6CzYU6zZ1En/rkD7EpDTjbz9owtK53b/2rx2/ZkK6xS6Cg6t4rowh5ujcvSAWCT446
 EVYRU88JXOwl8XkCm/cnmni4mbQlHYHQIWxNcBWbHEFGvvYDmcMGRzxHmbqljAuj5CoUnR92dG
 u9yXbfUpzluML/tEqtiEyQBKS7rCVfSLYDgOVWNzY44HguWM4QuKr5rUTOkghmc9mTfxbs2h3y
 fsypr+8yTVWDeogPQjFSi8NMBjYHf2hi83+gHT4CVxmWM6+YxQ4FwauuxruLG7D0nk7T9tgPLh
 Nx4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2023 03:16:26 -0800
IronPort-SDR: IKeR/Fm+7AkS0Zaqfrp7E3OvFPdo9zuNw7GtkfDazSv4oFoGfhHceijnZXW+uHsHoYXWXre0E8
 jFY9cjk+8B0jFO8E+VPpwIMQeqbgEKLOYIP1S+ud9nAJ0HByTx/LN69c1vb+nUM9c1Z3BFdCSZ
 7RveQ6Wajn9qt9brzRdDseDdnYsVzU87RcsZAN3v+zaxRcMpRGoO7h+m8RNIIMoezEMLbmReIB
 lbdqJcmIKFwZycuAtndtZ/TnR6u5VKuLMlHh4pBGo+Vw8e7jH1gNZfzj8l3DJ/gz1cgWxNEGH9
 epo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2023 03:59:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PMs5F0JSBz1RwtC
        for <linux-ide@vger.kernel.org>; Thu, 23 Feb 2023 03:59:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677153568; x=1679745569; bh=5orrTDY/75WcHDtmRC9cRppWmMIsORWXO3D
        O/mXOnTE=; b=C2aJFWIi/sinfHSH0ScrfoOU/ewskm0btWe4WNwVutD+MxP4wY3
        UfmaPGNz5671lQgvGSubBtQmi1vYObELgZU3kP+OO8Fyrt189HO2GZh/y1IoP03a
        hTOZsb8t4+VHShEkwENX+14r01+7lcnB3K9wqw6lXfEIAUHnk6aYlaRBzlDs9MIo
        v2LHd4fUdW/j4Uzf13OwG8JiOfrgCq11/z9FkprP8ZSRRHRw2hRbuKqebI1KUZjh
        s3yPOmAaFhQYsyBRS+JQYMLGu/SoezvDGFDVyH3BM8tdUt4M77ZoaU4GaGdpJb7x
        p0pl9ANTdtxeNQisE9wvQgCeYbdXqmpfB+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F18GqPue33AN for <linux-ide@vger.kernel.org>;
        Thu, 23 Feb 2023 03:59:28 -0800 (PST)
Received: from [10.225.163.26] (unknown [10.225.163.26])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PMs5C1s50z1RvLy;
        Thu, 23 Feb 2023 03:59:27 -0800 (PST)
Message-ID: <5df4d4b2-459e-332b-d64d-cd5513f7f579@opensource.wdc.com>
Date:   Thu, 23 Feb 2023 20:59:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [ata] : SATA device speed down after multiple power reset.
Content-Language: en-US
To:     Deepak Ukey <deepak.ukey@samsung.com>, linux-ide@vger.kernel.org,
        htejun@gmail.com, tj@kernel.org
Cc:     sathya.m@samsung.com, d.palani@samsung.com, prakash.bv@samsung.com
References: <CGME20230223105026epcas5p3224b4703d579d04543c93cf7d10f418a@epcas5p3.samsung.com>
 <20230223105125.GD9164@localhost.sudhanshu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230223105125.GD9164@localhost.sudhanshu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/23/23 19:51, Deepak Ukey wrote:
> Hi All,
> 
> I have SATA SSD that I am using for robust device functionality testing.
> I have a setup where SATA SSD is attached to AHCI controller and power 
> to the device is given by power management unit.
> 
> For the particular test I am doing mutliple power on/off to the device,
> it is similar to hot unplugged and plug operation. 
> 
> After the 4th iteration of power off and on to device, device link speed
> is going down to next lower speed, i.e. if device link speed is 6Gbps then
> it will reduce to 3Gbps.
> 
> I tried to debug the issue and found that ata_eh_speed_down function is
> recording the error as ATA_EH_SPDN_SPEED_DOWN and limiting the speed to
> next lower speed. Afterward SSD starts working on the next lower speed.
> 
> So can you please tell me why this specific functionality is added. Also 
> is there any way to recover the speed to max speed so that SSD
> performance should be intact. 

Please send a dmesg output of your test to see what is happening.

The issue is likely that cutting the drive power is may be not handled the same
way as unpluging the drive and replugging it (try to see if you get the same
result or not). If that is the case, then the drive is simply
disappearing/appearing and that is handled as an error. Too many of these and
libata decides to lower the link speed to try to reduce the number of errors. So
your test is probably not entirely identical to plug/unplug. Losing power is an
error. Unplugging is not.

> 
> Thanks & Regards,
> Deepak Ukey
> 
> 

-- 
Damien Le Moal
Western Digital Research

