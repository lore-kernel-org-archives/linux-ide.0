Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA69AC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 13 Apr 2022 03:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiDMDop (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Apr 2022 23:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDMDop (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Apr 2022 23:44:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEEF275D9
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2022 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649821342; x=1681357342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4cMtm8gzKr8femcwqZ9TWB6EmgLUbPVxA3RSWnKB4tk=;
  b=I0gSNF/CbDMyZwjzHnFVrOZEorb0H5exukafW3oRS6rl/SaFfXx+Q+lt
   +P4+W4MKLjwBYYx/AISok1G5vGuLURMtxwOk9nSFRdEegX3lzicc38JLG
   HSTqfZqyH1/LY2xacB4aF2sj3bxipaEazYMtJwhFv8RAt7R88HUJJLfTJ
   /uwotoYlzl5cQf830e5ljErw9gQIH/MBpGMDIkiWzN2Vgo53iYmVZv+5L
   fCtSI3dUiix34qJ82walsUMuMnplembtfCWgg4I3yswxNAUXISpgDysa1
   LHalid9KjzPM5xW5wSDWdMhSAOlCOuRCDNBr3SWZ7j38eKcyWTDKfnCLk
   g==;
X-IronPort-AV: E=Sophos;i="5.90,255,1643644800"; 
   d="scan'208";a="197788235"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2022 11:42:22 +0800
IronPort-SDR: 7/bcL5KOK0sW8p5WSmOTjSbGWexf3+CYlnBLtmQ4CMWhZ+j621FDclJDUozSjvk1/KwMeLVO5t
 oLZBxU9FAS6+iDspPVMWlFMOb/hE9A3SYnI6jneIG17wIQW6oNWn4yDxHA/5rNc0dWoTI1l5yH
 m1ub5ok/vbCoLsKUbkt6EXfWtnUmP6qS9IQ8c6co9CtE4emspqNEkZ3B20EoebNB0S3ictentx
 0EbkeywKXW++geNLv1SI0Gd5M5sTLI8HSzwsiKMamTQzVGGONOpxXqP3RqCyADJbR4kUKOnfdn
 7/sTSTuladaoGvr9U1SHvnzZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 20:12:50 -0700
IronPort-SDR: Y56gx/VHkgaHVcnBkAe03RgAIznPkXhWReCXubS0PHga4T6HXDj6W2cyWSOZWVsFaxY+D9Vb2f
 fPppugSOGXi4Hru8obkkT4bUmFsNt8bANGjCIay/a1pCdcLUBgM8xY4MGK8MS6tTt5P+JOgcbE
 lJ0FaBE/p337W5FiyZMP9nKdTKK5XrvDhk57SLeLuzsyfBvyJTL2oDU/4MFR2hZsc9QfGhL/yS
 PtvGuClWWsxascY1H16RdEax5oGtVFh+JddNu1YQ+3PbKoqYCHEWETUyH7e5ca14wXdG3jXwbO
 aZM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2022 20:42:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KdT1V73cyz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue, 12 Apr 2022 20:42:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649821342; x=1652413343; bh=4cMtm8gzKr8femcwqZ9TWB6EmgLUbPVxA3R
        SWnKB4tk=; b=Oyuc6f80kFGcjEq/dmN9Z1pG5yi/rIzOOco3WRgCZn38uJc2jBr
        Am5fPeMXkYrbZfBsnutmsnVcE3DBo2ZlusPsPAzeZNLyY25AWnmar0HH1U2Y9GTu
        SGaQEWhFL7RL6LuqXvgiDNiLLq+E4jDEizwldkpL+8QaulVAITziu4zlOlpBsJWa
        zeMbU4ZJCA4fUtoLRG3ruPCj1nn3qiGFEpoE+q1L5P1f6AWxeEJn0EykJazh7Aws
        kweeqL/z4ZF20EEQPHuakiZ4J1yEfdRjmqg22vdiNsVs55D4o0bOBNEdfyzjIAY0
        /g3ILjM79uHT1zB8s5ecbWvijwU9c6ww4+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sL0FEUyJCcwL for <linux-ide@vger.kernel.org>;
        Tue, 12 Apr 2022 20:42:22 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KdT1T6ckfz1Rvlx;
        Tue, 12 Apr 2022 20:42:21 -0700 (PDT)
Message-ID: <3045fde1-2d5b-e731-ef18-6cf3f0987259@opensource.wdc.com>
Date:   Wed, 13 Apr 2022 12:42:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [BUG] ata: pata_marvell: Warning when probing the module
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
 <05433153-0424-ab66-1573-993d0490c5bc@opensource.wdc.com>
 <CAMhUBj=JsiHnnQzrqPKzA=Z2+589Ju_HE0cFKyon58Fk0waeAQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMhUBj=JsiHnnQzrqPKzA=Z2+589Ju_HE0cFKyon58Fk0waeAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/12/22 15:34, Zheyu Ma wrote:
> On Mon, Apr 11, 2022 at 7:53 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 4/10/22 15:30, Zheyu Ma wrote:
>>> Hello,
>>>
>>> I found a bug in the pata_marvell module.
>>> When probing the driver, it seems to trigger the error path and
>>> executes the function marvell_cable_detect(), but the
>>> 'ap->ioaddr.bmdma_addr' is not initialized, which causes a warning.
>>
>> I do not have this hardware so I cannot debug this. Please debug it and
>> send a patch. bmdma_addr is normally set in ata_pci_bmdma_init(), but some
>> drivers set it manually in their probe functions. No idea about the
>> marvell driver, I have not checked it.
> 
> To be honest I don't have a good solution to this problem, because
> other drivers don't have similar behavior. The marvell driver doesn't
> even initialize 'bmdma_addr' before calling 'cable_detect'.

Then this is the bug that needs to be fixed, no ?

> So a simple idea I have is to check if 'bmdma_addr' is 0 before
> reading it and if so return the error code ATA_CBL_NONE.

And if indeed, even after it is initialized it is still 0, then yes, this
change seems sensible.

> 
> Zheyu Ma


-- 
Damien Le Moal
Western Digital Research
