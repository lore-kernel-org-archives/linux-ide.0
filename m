Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B61C4332F
	for <linux-ide@archiver.kernel.org>; Thu, 13 Oct 2022 04:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiJMEUY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 13 Oct 2022 00:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJMEUX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2022 00:20:23 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5827C7B7B2
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2022 21:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665634822; x=1697170822;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NRzvtC/IR2w+ixNqRPvXY+WUkUpibfZSc3qz1wykIKI=;
  b=ReP8B89RmEMbAdsnfoTxPGEh2k/Jr0ruIURUfekIBoeEV0l0dHxIurhu
   o5FQWYuV77/v0EaQLNWjmSbky1lL6AzQCqtbeB84Ardt3Ao7NkfTiII1t
   cUywDwS8D1OgCeSbRoGyH3ktHp/DoejiX+gM1tqVC1DVWBN6sQV0sjknr
   pTUJSwz+Z0tq5ArmLW5N19DR3PWMPxYjv9nxOZsqTh5CNiTaCfgillvu4
   t3Bee4pltdS5n2eqfFHmv+YNkwTQGsHuCzl0DSIVx1Rwid/x1m4L3j9dp
   f7rmpoWTJD/I0VIdIYnDkdkLNKHSyTjvT3fVRlL25/VNl0rLQskNIbCjp
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661788800"; 
   d="scan'208";a="218853341"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2022 12:20:20 +0800
IronPort-SDR: 4lUbBNiRkARAfyL/WRwd7g8ptIL/bGoru5aA+gBEjBPgUurMy3lBbEBfcj6RdvMLgg8kr4F7U5
 Hp34C9/Uj0dGNIGfBeQCGEz0OFQOvVx4jk1k7mv7PU++UHSwPaUewBkMgbifsgFRSW8Gny1sd9
 TJ7Nfr/9u2h/LrDiST6FfoQWkmR2D1Pd0dRbeSJOikeWMA9uWrwpd1IkBB82l5Yb3REF5l65c0
 MZyyCtwBAT27Z9cIUEoF7ZnFT/HMMN2j/aOie9GTOcNuXjTKyLLO2o/Zd2ZKkuO81FxftpquBq
 Yl6EVjIwbPti3Trxm1JLRof/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 20:34:21 -0700
IronPort-SDR: gMBtkEAgtQXA5gDch7gax9uXSV7Vlk6/+0MU9A7uUKEfD0K7dYVYYI3hNfA63mHco5dZarRrJp
 PgoNj+o82oNB7Q6uo1Klz/VAQFyITSfq0l4sL0s5X5j+BIsiye38ZfpJG7wMoh2bibYEjdQrIx
 EpB/OQlXKf04poqzLaIvT4utJpiI/GUZAF4Cdlc1FvHjcrO4aQHmdMmRxXNmkUaIdt/5VAvv2j
 3K6FsSxfSSIS0cRfui3YuihyxTWezk4xydTSvbCT5F1punV90JDk24/T1DAQKtjk2oWTWoe8CP
 YQo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 21:20:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MnxBr1FRVz1Rwtm
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2022 21:20:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665634819; x=1668226820; bh=NRzvtC/IR2w+ixNqRPvXY+WUkUpibfZSc3q
        z1wykIKI=; b=ZhGmzg9qcAvTUgbA53pyDyBx4zoaIc4F1i9cOHEgO3srz+YW5UJ
        lUPZaJcY2Hq9bflCxNTscTLLj+v83f3323gBjWyXmH2GtnNCuin/FWr9ZY5j9xIy
        tYRcnFXNwm/yayGuKGU66janlExvbzld8RKldeL+wOUJUuN50xq3SVynwOCOQS0I
        VlDfC1722T0BB/uO+U+URCaIQ7qDttz6aPrseDycn7pR1M5K+p0CMBc6b1GvyC6I
        Nu58P73dPhPawmyrutgRhmDNO2q9fPyIkvmShd2EDUipdn4sqgDKkb003OVDXAcv
        DnsR8a3yhxx/xkXQze+925FUBFNLkJpiQSg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A2iLTbUq-WcC for <linux-ide@vger.kernel.org>;
        Wed, 12 Oct 2022 21:20:19 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MnxBp268Jz1RvLy;
        Wed, 12 Oct 2022 21:20:18 -0700 (PDT)
Message-ID: <fe62c669-01e0-52bd-fae2-69fcbc375c23@opensource.wdc.com>
Date:   Thu, 13 Oct 2022 13:20:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/1] ata: ahci-imx: Fix MODULE_ALIAS
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221012131105.725258-1-alexander.stein@ew.tq-group.com>
 <CAOMZO5DzFtuVxuAhmtsBx+EoxXgeg6nHDeJiLULsY8wRdpXbEw@mail.gmail.com>
 <5877338.lOV4Wx5bFT@steina-w>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <5877338.lOV4Wx5bFT@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/12/22 22:30, Alexander Stein wrote:
> Hello Fabio,
> 
> Am Mittwoch, 12. Oktober 2022, 15:23:04 CEST schrieb Fabio Estevam:
>> Hi Alexander,
>>
>> On Wed, Oct 12, 2022 at 10:11 AM Alexander Stein
>>
>> <alexander.stein@ew.tq-group.com> wrote:
>>> 'ahci:' is an invalid prefix, preventing the module from autoloading.
>>> Fix this by using the 'platform:' prefix and DRV_NAME.
>>
>> What about adding a Fixes tag?
>>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> Thanks. A Fixes tag seems reasonable, but I have to admit I don't know at 
> which point auto loading stopped working (if it did at all).

Given that the alias was wrong in the first place when added for a
platform driver, this I think should be a fix for:

9e54eae23bc9 ("ahci_imx: add ahci sata support on imx platforms")

I can add the Fixes tag when applying.

> 
> Best regards,
> Alexander
> 
> 
> 

-- 
Damien Le Moal
Western Digital Research

