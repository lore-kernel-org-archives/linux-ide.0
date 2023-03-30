Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E87C6FD1D
	for <linux-ide@archiver.kernel.org>; Thu, 30 Mar 2023 13:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjC3NNh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Mar 2023 09:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjC3NNg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2023 09:13:36 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C38A5B
        for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2023 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680182015; x=1711718015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mBFuxQXfprg4Pna0HAHyQQptHJPYecSKsHqBxtvhgCE=;
  b=l2kEnd+6vM+ssIrJvG3bI7BYMurQO7WnOnA2GAe7EReChcIss1C2jZGJ
   7OxJVN4ssAl32x+eqrFhB7TezYszHf875CJlkw9yry2YLOEGEVqaZlF00
   vB3ooZvQ5gsuL3OBxJAugWqGpbPeTy0mp7R3fRT+lvdmfCvNXzjYyoQLu
   lwOQm3BxM4mvFlu7jlFGY6C6erQYiTMz364QNYEAfIWwaqV/bzQxtAKeH
   eAtnDM59NE3yU5jeiJgOnB1nl2ti5b8EZ+xmm3Ea4r7e5KoxzrVVvH2Hy
   pNhyBxh9i9NoZpNjQrXXzOcghD+bWdMij6Sa+LGUCDdWkMAfLGECYRurJ
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="231863525"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 21:13:35 +0800
IronPort-SDR: LORgRx79u0K8MD3aif1rmeOAwCmU9fPgFqnjzVN8UWJBZ3UW2Dmrvn591FF4FIkJWp9ItIj4ln
 9HM1bIVyhk141Gf4jgzrUNDT8UzfvnOvcYkXveVm2vPOxby/uWz/f5UvHjnrXLsUvVmYEF0CBT
 kOPSfksknTHApJeYsX13UkLqDQJ5Kj3tpxz6J//zfJ7aJUAR+C8oMBx5GRJcOzkrauRsn17Lsc
 CJqlC+Y5mADOsPnejNYlMYbdXt1tSU+od7zwvv8TaSYO7yRVmN4qBuZ4ItKYI1zFmahZ3ji0wc
 B+U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 05:29:44 -0700
IronPort-SDR: QY1FTBTai9eipV6SjedEExbJ++GabHxLY3VvEjIWgwhGZ9Wu3KzSM21Cm5ZAfLlgGMT2IGdKfq
 u9zl2g9a4KzxCn3Iro7sXWf9idWInb4ylZh/RtZpPuaGm8zZM62Wye25S+jAfPBxV6x8cJXuKT
 JkVIGrGD0X38x3HwQxiFZWjkyTPZPZG8NhY42ljuWunhSNpvGpVi+bKO6WpNjoYb0CqUTvuhdD
 Xqvhpi4nIgxhy+pVj5qvCsb65nNtx20/5+CVek0wJvu/D6ixTzuCKVI1iV73JyZaTLbMv7t8w7
 1+o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 06:13:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnP4b2c0Lz1RtVn
        for <linux-ide@vger.kernel.org>; Thu, 30 Mar 2023 06:13:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680182014; x=1682774015; bh=mBFuxQXfprg4Pna0HAHyQQptHJPYecSKsHq
        BxtvhgCE=; b=YSTzq6zCCOEI/geqUKURP6AFn/HfF2zTlhMt7THs3OgEzT3QaKi
        R9jHKb66yIo4Ijt02WsxEPiCInpcepAyC2vc6UhylGkIiD4orWqIMUOBQQp65i9P
        7CoioOvBaIHqC4/c1/1uc+ZoYmNBoIslp/92Pc34JTBw7k+AqCSWBFRvtDhX+glZ
        KQaarea+pAxZTfuJn1Uslb37wI9YvnxTYwk4ayGirKKeDZF22lyDl86RWhglYUah
        dnT06dleh23RIvLhk8P+TPJOvqMspf9RVkQ8YzYSMTjnOUtxAy/+m67YZS6XcZqf
        I8xHcNVbjWsnSn9fTY+09goKLHXNLZCfr4w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RFEz0WrM5fAJ for <linux-ide@vger.kernel.org>;
        Thu, 30 Mar 2023 06:13:34 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnP4Y4ln6z1RtVm;
        Thu, 30 Mar 2023 06:13:33 -0700 (PDT)
Message-ID: <51e2fa23-8bdc-e15a-a8a4-0b702a549931@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 22:13:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [ata] : SATA device speed down after multiple power reset.
Content-Language: en-US
To:     Deepak Ukey <deepak.ukey@samsung.com>, linux-ide@vger.kernel.org,
        htejun@gmail.com, tj@kernel.org
Cc:     sathya.m@samsung.com, d.palani@samsung.com, prakash.bv@samsung.com
References: <5df4d4b2-459e-332b-d64d-cd5513f7f579@opensource.wdc.com>
 <CGME20230330111111epcas5p413bdef318b1d3f74263e86f4bd0aefa6@epcas5p4.samsung.com>
 <1680174727-12152-1-git-send-email-deepak.ukey@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1680174727-12152-1-git-send-email-deepak.ukey@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/30/23 20:12, Deepak Ukey wrote:
>> On 2/23/23 19:51, Deepak Ukey wrote:
>>> Hi All,
>>>
>>> I have SATA SSD that I am using for robust device functionality testing.
>>> I have a setup where SATA SSD is attached to AHCI controller and power 
>>> to the device is given by power management unit.
>>>
>>> For the particular test I am doing mutliple power on/off to the device,
>>> it is similar to hot unplugged and plug operation. 
>>>
>>> After the 4th iteration of power off and on to device, device link speed
>>> is going down to next lower speed, i.e. if device link speed is 6Gbps then
>>> it will reduce to 3Gbps.
>>>
>>> I tried to debug the issue and found that ata_eh_speed_down function is
>>> recording the error as ATA_EH_SPDN_SPEED_DOWN and limiting the speed to
>>> next lower speed. Afterward SSD starts working on the next lower speed.
>>>
>>> So can you please tell me why this specific functionality is added. Also 
>>> is there any way to recover the speed to max speed so that SSD
>>> performance should be intact. 
>>
>> Please send a dmesg output of your test to see what is happening.
> 
> Thanks for the response. As you mentioned, we are cutting the power and
> device is disappearing/appearing. Please find the below logs for the reference.
> 
> ---------------------
> [  226.463486] ata_eh_link_autopsy: IN
> [  226.463492] ata_eh_link_autopsy: taking speed down action
> [  226.463496] speed_down_verdict_cb: Returning zero
> [  226.463497] speed_down_verdict_cb: Returning zero
> [  226.463497] speed_down_verdict_cb: Returning zero
> [  226.463498] speed_down_verdict_cb: Returning zero
> [  226.463500] speed_down_verdict_cb: Returning zero
> [  226.463501] speed_down_verdict_cb: Returning zero
> [  226.463501] speed_down_verdict_cb: Returning zero
> [  226.463502] speed_down_verdict_cb: Returning zero
> [  226.463504] ata_eh_speed_down_verdict: ATA_EH_SPDN_SPEED_DOWN_1
> [  226.463504] ata_eh_speed_down: Verdict:2
> [  226.463506] ata_eh_speed_down: Calling limit Speed 8........
> [  226.463507] sata_down_spd_limit: speed limit:0
> [  226.463509] sata_down_spd_limit: Out speed limit:3
> [  226.463511] ata4: limiting SATA link speed to 3.0 Gbps
> [  226.463512] ata_eh_autopsy:IN
> [  226.463514] ata_eh_reset: IN
> [  230.669238] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
> [  230.669505] ata4.00: supports DRM functions and may not be fully accessible
> [  230.671982] ata4.00: supports DRM functions and may not be fully accessible
> [  230.674234] ata4.00: configured for UDMA/133
> ---------------------------
> 
> But is there any way that we can recover the speed back to normal if device is
> functioning properly after power cut for considerable amount of time.

Please try to unplug and re plug the drive, to see if plug-and-play works
correctly. Really unplug the drive (not just the power cut).

From the above messages (not standard), it seems that the system did not see the
drives going away, and so when power is restored, the state is as before and eh
assumes that there was an error and so decides to lower the drive speed.

If you want to save power, use the proper ata power management features and put
the drive to deep sleep (PM3 mode with SLEEP command) or Standby_z power state
(STANDBY IMMEDIATE command). See man hdparm.


-- 
Damien Le Moal
Western Digital Research

