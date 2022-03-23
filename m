Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B31EC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 23:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbiCWXml (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346271AbiCWXmk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 19:42:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BCFC6C
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648078870; x=1679614870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8/R71gpx2o7ii8zc01vktHRbNosdhVe6/h2AVYN21aM=;
  b=mtQRpUQ4NzwmMoNj5GCM1xCKlkjZy+JyWik/qYaI6g8CjOshM+huQpJ7
   2/wdI+oOoyHKk3BaAKqRzMx52WQrHPpCKIliaQNWWuICf180JN+OF8q7m
   IaUgPzm07LngnVOtTBsoRQHvnjSmjRg3ZuZQ53Q6XMdktokmWfwo4MUz3
   blxVDyM6+8W/B+nNWU40pVl3wZqM97gs2NdKQ9lNblM9jWQ1As1x0k0Zp
   TjIie7yGwigbg8jB/V7Bs7Xba4dzrQwm33qCHv0kxp3qXzRuLfhO1ZLEW
   udYwQL1rDkitJFp7Yle+rAKSRnpdWpM/f8Ko1XkMfG+cEUy9g7zXxojqp
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="308062256"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 07:41:09 +0800
IronPort-SDR: Bef49OpzB8lCZdxRcF4c9/ljgt6wroNXeBv9LSpLp95KXcj1x1/zguYWil3gnhyaSsZy7hp4pZ
 /ogKLG2Zv6bbJOGYPo5bMFIM3eoxret1XhB28RPTeh+eeoXj9UylPBsWlhr7Ec3sHnBG7aN3cZ
 LKLGqunJKfN+yvve1j6tm96DFmnRj/V67G4+T2JzjYJbd0Pf3ElVKY/+oTP0vIRtAVz512p2WQ
 iP0jdA8FPIKifBjXsOE3FSKctHiKnpKNn3VN8G0Zyt980mZycQor3ZDOVjPc/vrKNP/9RJWpjz
 ClTFkQlWhXlW4+pDgUsHob2X
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:13:03 -0700
IronPort-SDR: WlWt76kjppDJdkA3ntfPEntD4ARTMhDKNSY/NSVGhI3nwujd9E7L3in5fkYNqaG1UMl1mVPUY6
 iXfOEJwR9/WjXW7ZWGYjyEqpzyUdF71PAzMelz+Oq8ZLf2/d8iGZ4IL0J03P6JXCuMAInd1Vx0
 89uCemhzObRYxXCPjrNruOoPWrA7PnfTpm1yYrWdsVU4pU/tbMbHu9zgP1egGPmeRenZi8CYvD
 odcd1C8gnWEHRHzZwIDwjooA7iYtkUGNjscr3UNHQO5/HUjBApslk6qdjEaGGU2hwpW6HcLgKQ
 5MI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:41:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP4cP59XYz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:41:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648078869; x=1650670870; bh=8/R71gpx2o7ii8zc01vktHRbNosdhVe6/h2
        AVYN21aM=; b=FDJcXur9VS7bUgW/Z7N4rT6BtBWehy7uBqkxVZoBVEI3LYB2RV9
        WBGTxHp+nOSKEmyMHRJIF1Rx5br0U+/K3AxBJNQQgqG8xgkIweIUDYqZNkqcsX3s
        sHprsBStVR3mH/uiOkPOsomzUtPw07f2O7i/l/jLVukbqHiARDiEX+/uMX2cMVTs
        8qeoOEXDZmvHrMR306pENaOF/y/cUE2HSNIfopzWHf54UYNGAgiGMBtDBM3ZdiVm
        14tRuOyW36asreHkVBURAt86etcC9jHrpA3J02PI6BFEkhyRk27pKd6XqURX6gIB
        Eh5GSakoIGs6mme9/ryxpcX3I0gRS7IzGGg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LzLMRp5njAQg for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 16:41:09 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP4cN6XkVz1Rvlx;
        Wed, 23 Mar 2022 16:41:08 -0700 (PDT)
Message-ID: <47043d5d-a1aa-8568-3688-b5c425ea14a5@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 08:41:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] ata changes for 5.18-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wgCt46XN2xuQO3Zj2UoeP472EpyWbrjsDPVZvDHW+rA2g@mail.gmail.com>
 <BL1PR12MB51576EE0517167FDC471AE8EE2189@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAHk-=wgQhOw4LOejeLKtEMWS3+xVZ-+zh=EqhdDn=E0d3C1e6w@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHk-=wgQhOw4LOejeLKtEMWS3+xVZ-+zh=EqhdDn=E0d3C1e6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 08:13, Linus Torvalds wrote:
> On Wed, Mar 23, 2022 at 4:04 PM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
>>
>> So maybe a logical thing is to keep this change and send a follow up that also changes
>> the default to 3?  If you're supportive of that I'll send something to Damien to do that.
> 
> It would probably be good to have some way to see what other distros do.
> 
> I only have F35 here, so a very limited selection of distro defaults..

I use Fedora too. I will check the other major distributions default.

-- 
Damien Le Moal
Western Digital Research
