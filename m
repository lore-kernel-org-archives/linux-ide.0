Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D5C6FD1F
	for <linux-ide@archiver.kernel.org>; Wed, 22 Mar 2023 22:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCVWgJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Mar 2023 18:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCVWgJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2023 18:36:09 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20F5BA9
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679524567; x=1711060567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z33AnAkFE4jAkA5B22cWfL3zIfROoEjUwvM0cjRl6vU=;
  b=InJ0RRTdP31K1LoBKAYlDj1r5nZJaJiFSn5gBjX4l7nDirUpuFEEgaPB
   iy7m4hnGlv9XiH3rN42Q/tUW1uA2mr9tNpTqeY+s+BAeyKzw5OVesRqdD
   6kH4LelUP4XtstQsVXzibS9GZgodNWBb3pHTYNDnpQCUSD6s0+s7ehGt+
   y1EF6H4vQB4DzTU2r0u4skBGY/AGzHI1TgdiWifJhXRsSED3JRAUvOQ7A
   FKvpDkYGbh9u0cu0nhV6yZHpYNOSOLNjMlF/Z7lDxerdhHRKCCdxTsSSV
   5w9cPiJsVoLxH6ZI/VnKpVgUNVGVfHWdjAa098dxEqe3LqkkpZUOKWKPw
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,282,1673884800"; 
   d="scan'208";a="226270765"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 06:36:07 +0800
IronPort-SDR: yhq91X+6a8OMUXqtUf6D1MzfxKQhzBRfHn7asN+9oKZgpFXuMz9fPWgdE+K8UCN0y31aV27eEZ
 My1jGEaZ9EmROVQawTzgnxB5ni8kUpT47dSKzEHgo0B0Nc9BM04G+Huep3pldvyuWc0SA1ghhB
 wI2sWwQoHBAIWETjc1+3Se3VYRopCL13SevEZboSOwqk1mfvIl/FD7zLO4Tn16wFoFp4H5vgUT
 JMkO9JdwKDHSVCt0l4R88wjqD5tErQKFpZ4FP12YZzjgxUArl5FzSSw3IMdkKc7OpxIGT0Y1mJ
 R5I=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 14:46:43 -0700
IronPort-SDR: HGXtZPnj0ClpZckZdaOZUi4kOVtv0daNTKcER88CQjOvIu3r3l247XuCUl0m3/VUO3Y556KUgv
 x7ki8ZZPD8UoH+YmQBsfrSTFkbz7J7i4oxTVWr5o7rfM2YPueNZtwlnAbpzd2d0rNbyGhXQTW5
 HUh816sgfC7vwgMl6pjplTK1sV/NYt+vYjlM2ptayG4kycaBrHZWZM0vecgfYCEOIuM3pccu3p
 aABtW3pP/CgYs8O51FOeGFR3HZBGt2EFZL9t0XXv7SHKxwvLFElOxNztDlazExeCEcvFABrsAA
 nQ0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:36:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhjxM1xlDz1RtVn
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 15:36:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679524566; x=1682116567; bh=z33AnAkFE4jAkA5B22cWfL3zIfROoEjUwvM
        0cjRl6vU=; b=cYNzMeW+lSttMeDns2BoJy1PZKd+ZRtCtC/Kl/KTSdsiTpvNu6p
        PJ5u/QNTnu4kdRNTYF7r/W2gcBYEPVT8CVve/4lftZUXpeYg7UAnjONT0GXdguxo
        WzQZKJO2N9y7T9oeiwScu+IFHNoQ4HcqOJk7t2dardZl7Z24mPPKSgzvDoZpVi6l
        NyynR5TQMjWNigoZJvW/0+/ioakVt3qpqOX/ZSgDjpujILKOgmAhqEi9BUOO/ial
        9JQHJyFasMP26Ml07aQFlfxb5FCQ8QQsND+sOejbhrlU5JNT3pZQEaAujvNjww0y
        jW72vLDC6w3hyi9OIqv1tnRpbMYMezZ4ofw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id r1Lf_M8TrBQC for <linux-ide@vger.kernel.org>;
        Wed, 22 Mar 2023 15:36:06 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhjxL0LJCz1RtVm;
        Wed, 22 Mar 2023 15:36:05 -0700 (PDT)
Message-ID: <5856b70f-e5bc-d802-7450-7a11c570c10e@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 07:36:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] pata_parport: Clean up some inconsistent indenting
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230322055519.67900-1-jiapeng.chong@linux.alibaba.com>
 <202303221314.41470.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202303221314.41470.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/22/23 21:14, Ondrej Zary wrote:
> On Wednesday 22 March 2023 06:55:19 Jiapeng Chong wrote:
>> No functional modification involved.
>>
>> drivers/ata/pata_parport/comm.c:159 comm_write_block() warn: inconsistent indenting.
> 
> This patch does not fix any real problem. All the protocol drivers have coding style problems but they need other work first.

Does your pending series address the style issues at least in the areas of the
code you touched ? If yes, then good and a style cleanup can go on top.

-- 
Damien Le Moal
Western Digital Research

