Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A8C4708D
	for <linux-ide@archiver.kernel.org>; Wed,  7 Dec 2022 21:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLGVyF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Dec 2022 16:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLGVyE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2022 16:54:04 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C318E35
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 13:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670450043; x=1701986043;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P/JwQSlYj/GLmxyXXQvMzK9QCR/lScrdoFxhm6a8QX8=;
  b=K/EgGjKvqMsbk0u3WMAcThyhxHDjyAIiuNZfT7HBjfdG1QRSoAtN0A31
   LJFJ0NxU3yqLAcs7raxf/JWV9BNeoQ5PzEeRxSptP6vurfZKNj0kKn8h8
   KPO1YKDnSt1ctA4FfWuOHoTDWWN2/vqCUt/AmyvBreYP14eJFL6Amjb6K
   GKJqFwCDVblB+UB5WU6ekUYF6AXMBrlxiLxyOU8zOn+vBxtvJMKE4UydD
   2AomQ7QRlJ+Zn5S6kAk2qiLubLzNUkb425tTJEphxi/2XN1jR2bsxRnXt
   o1E/ElGJ25IYJftY0MwrVTP1dSgVpbhlFltVyUfWU7iruuB75f2C/iu0I
   w==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218129924"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2022 05:54:03 +0800
IronPort-SDR: Aos9B5W7gqvjBkO4+bbLLwZxdi7n58tDmxtCBoClH2lkH03Bt1dz9E1UU8qyakQZx4f9IhPNkr
 vV5okh1Q0AmLA/Cir1hzLZKHKDEeFyg19dbZARG92ktogcG1z1HGb6ObdVtKybBfsuh00CQ1nA
 PaLl5FmdMzPxoAFuobPi/irwnkgC2TrGK7mK+kzYNHpInaSou1PM0g7pt70Tyz6V2mi/8LD8kP
 bOMJtLrQNRyJ771gZEOmp8pwcSK5HRNhDI1WTuBU/0pwSnwZDebjc2oEFdT6fVgpTHJbqlgsYJ
 Vks=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 13:12:33 -0800
IronPort-SDR: 4PXdhag5o/ZiGn6ki0TVYeGTNSAX8gUjqgoxhbFjxty2X08W9JrPIx2JtGJ28taLq27gz3y3Qg
 NFdW7yhh/o+13CwsgBK8BGoiasTyxGvHuuPi/uXGSrTKc4CSQvTcXfoKB5KU6oCXh330sx7j05
 aH0s30kETrrsorGnTTNC+RhdnQFPCfRxo/3VWGazvl2vPPd5QIautr3rLkBn6DF6/mEuyOZSS0
 BgmJJ5WDTBcx49+5vC4nPEJh0tgX8yiMw3Y9nyOcMaw9nO8zxiB9lygsbQ72bn2u0OMebULmeT
 li0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 13:54:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NS9zG6mmPz1RvTp
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 13:54:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670450042; x=1673042043; bh=P/JwQSlYj/GLmxyXXQvMzK9QCR/lScrdoFx
        hm6a8QX8=; b=RYM5oiEEHLgSrHSUQNL0naDqkP8eifg6eWLSv5xNcm1Rdrsr9iz
        14lTXi3Dars6yECxEzXDTgWGbu3RGOqXJhUDZgWwEUgCbSdr6IjY82yhN+JoVgY1
        L55Asfr6FcmGYcYIS7UR1sU3EsghRVv8G+GiIKb3uqzt6Et0Qczkn4m44e0RGv1/
        vhtLobPoY3l/wvGOxks/nmAw/CgmaK5I99TO77DM7DR/63Kw+w+EX2gWuAOr1xaq
        nkxzb3v70vX9lPMzS+2UAlHJ0TzGDSC5dCKDzZXFKvOUa24dcsAgV4Eg+y7pfMyy
        gf02RVLrQp1wNVQHKTHPVz0lkf5lbYeWpuQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5XjIKI5mpbmL for <linux-ide@vger.kernel.org>;
        Wed,  7 Dec 2022 13:54:02 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NS9zF613rz1RvLy;
        Wed,  7 Dec 2022 13:54:01 -0800 (PST)
Message-ID: <ddb8cb6d-96b9-9eaf-632b-f535c7536d87@opensource.wdc.com>
Date:   Thu, 8 Dec 2022 06:54:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Bug report for ahci-mvebu driver
Content-Language: en-US
To:     marius@psihoexpert.ro
Cc:     linux-ide@vger.kernel.org
References: <c403c1dd-6478-09a3-f8b4-98026eb16c99@opensource.wdc.com>
 <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
 <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/8/22 03:27, marius@psihoexpert.ro wrote:
> December 6, 2022 8:08 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.com> wrote:
> 
>> By the way, what is the maximum speed of you pmp box ? Is it really 1.5
>> Gbps (sata gen 1) ?
> 
> No. It's 3 Gbps.

Hmmm... OK. Given that when it works (with the revert), the speed
reduction is to 1.5 Gbps. So it seems that the revert changes the error
return into checking the lowest speed because we do not already have a
previous speed... See below.

> 
>> Without reverting the above patch, could you please try the following patch ?
> 
> I did more tests, with and without the patch, with and without the commit reverted.
> All logs start when eSATA cable is connected. I didn't include boot logs.
> 

[...]

> [  153.028797][   T30] resume, after do loop
> [  153.088796][   T30] debounce, SCR=0x113
> [  153.148796][   T30] debounce, SCR=0x113
> [  153.208796][   T30] debounce, SCR=0x113
> [  153.268796][   T30] debounce, SCR=0x113
> [  153.328796][   T30] debounce, SCR=0x113
> [  153.388795][   T30] debounce, SCR=0x113
> [  153.448796][   T30] debounce, SCR=0x113
> [  153.508796][   T30] debounce, SCR=0x113
> [  153.568796][   T30] debounce, SCR=0x113
> [  153.572654][   T30] resume, return at end of function
> [  153.576511][   T30] hardreset, Offline=>Online
> [  153.586069][   T30] hardreset, sata_pmp_supported, before check_ready
> [  153.758800][   T30] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [  153.772539][   T30] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports, feat 0xf/0x1f
> 
> So, is this a quirk of the mvebu controller or the Areca DAS? BTW, Areca uses some mvebu SOC too.
> I'm going to try the Areca DAS with a few other controllers. I want to see what happens.

Can you try with no patches and no revert adding the following options to
your kernel command line ?

libata.force=2:3Gbps

and

libata.force=2:1.5Gbps

One at a time. Do not try them together :)
This will force the initial link speed to be set for ata2 port.

> 
> Marius Dinu
> 
> 

-- 
Damien Le Moal
Western Digital Research

