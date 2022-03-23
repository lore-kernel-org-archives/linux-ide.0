Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ABEC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 08:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbiCWIS6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiCWIS4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 04:18:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106F74DDE
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648023447; x=1679559447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1VOHkxOX7jnacBrrQM6BUhnOIPPKTvdn6a06lacvAe4=;
  b=UGhctNEdgTbpHMN+Rr2KhYo+fq5Woc2ErkBxjQF9CvFojpPuvvNodzVi
   DR/mlbVkezDAGQrh8BJveiRKUSxUK9XYVkmfI2Sfc5J0UZ5I6gYaWcUG4
   tCL7VAoPT4mNT/GXuw6ar06AdVNQWQTXF9nA+Boe/w2BmN4ZLNBFtk3sG
   F4rys/FkKZfaH5tTMuyCcjqzJPFVw5RZ/PMHOvTayzCpgliMzPZfk2NTm
   YXDi2etzHi6WtGIc07cMQ0vSGIvfV/r1EV92kinTXoo/CMe596NYCNbTY
   dTyFzJ6YFnGme1Qge8q+DtnZNpcVM5JtBPRfWBPN20Hps5ko6Mkh363M2
   g==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196969749"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 16:17:27 +0800
IronPort-SDR: TpB7iBeMGIx5hru18wKREVt2g8GEY872bGV3R0j9dQCGoZF3sXNAO5Asyk1vWE+SjRmjRAyu7t
 PnDKP08V1LhOZQOVFrmZUCIYCQM+9jGQ4OjySTyT6pnbHr7XTKcsXN3snlT7YEzwQDxsqDWvWp
 hEcEif2iOnYcZF1qv4YNKTPr73euU9ZXpiZ0RXnZLu591bgROFccvuxR14/05uvSHrt6hiTyAp
 R6o/AO3cmFS1dbck8r0dmrZ3rhIsXMa771vjnDqeb8sXTrQnrhRLnJHZ9bw1NG3flF10qRnl3e
 mvWUsfZN6eUsXzDyf75x8IhC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:48:24 -0700
IronPort-SDR: Azw/Vk5BMgYBnoM/MaF24yZxq5QAtBtra/S/cD0rUrhkHHRCe4OiLZ/0c0GsoFV456sorYuTgo
 P3WBkpRCWhU1RlXu2gMZrRwSMIld81cX2f4/Qd2ecZItHYhHjahVnoXw+tdkbK2iB/XPheSf9e
 +EsnCN75Rkq0nF0p1SWVn08tcA1wQlraNt7qy65HbhyHuJAxGIOrSl2NyUqL0+hnd6Zkv4/ENu
 DLlv1X8p8MYv5XfTk7RZwSo4YzXNQwWt04LYvKn4ce4MMvTwRqG+WXPNiuR6h66OzsudydKGP9
 N3k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:17:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNh6Z1h0pz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:17:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648023445; x=1650615446; bh=1VOHkxOX7jnacBrrQM6BUhnOIPPKTvdn6a0
        6lacvAe4=; b=rZakW39Sk8ueSpaoRDiIZ4wSq28XtTF3DaX5KwlddauI4+Zzwbh
        ZOaJnUmebdbPN7qrpD7+wQY0oWCAJq/L7f13KueMpYgoXUj0007lR6hYtNdBcioB
        YHrkxX98c0O31gfuaUVQJoFtPKrSMKi4fCb24y+V3N5BcmkwuBpA5O+WsWtQX/mx
        k/wkrrWOrivwejdT9YfFfFo/2L1onCLqBt6iaBw6Bs23U5fzxn3XuqOIifjtacBd
        m4/ZfMTPqwplQRiUWp7khi7kT1ctyY4X29aBw9wBK0qr2qQqcuZXBkR0CUamfupZ
        VXjMrri7Hc3b1UjKJx8smQFCPG6O8qp5JBQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8g-Hv2SAoDMo for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 01:17:25 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNh6Y0Q5gz1Rvlx;
        Wed, 23 Mar 2022 01:17:24 -0700 (PDT)
Message-ID: <a030b9b2-d94f-ed62-60bf-cc629da3e944@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 17:17:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
Content-Language: en-US
To:     Diego Viola <diego.viola@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
References: <20220323054001.17344-1-diego.viola@gmail.com>
 <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
 <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com>
 <641a417b-acac-6b0f-c330-b94b6ed97b99@opensource.wdc.com>
 <CA+ToGPEAhWDwFLNHqXvtuumvdLQb=kzme7fdrgBfb4zojVvDNQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+ToGPEAhWDwFLNHqXvtuumvdLQb=kzme7fdrgBfb4zojVvDNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/23/22 16:24, Diego Viola wrote:
> On Wed, Mar 23, 2022 at 2:53 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 3/23/22 14:52, Diego Viola wrote:
>>> On Wed, Mar 23, 2022 at 2:45 AM Damien Le Moal
>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>
>>>> On 3/23/22 14:40, Diego Viola wrote:
>>>>> Use the contraction "it's" instead of the possessive form "its".
>>>>
>>>> Well, while at it, let's use proper formal written English, so:
>>>> s/it's/it is
>>>> s/isn't/is not
>>>
>>> Fine with me, do you want me to send you another patch with those changes?
>>
>> Yes please.
> 
> I sent a v2 patch changing those things you pointed out, however, the
> whole comment[0] looks informal "But wait.. there's more" and I don't
> think replacing "it's" with "it is" achieves a lot in this case.

:)

Indeed. Do you want it in or can I drop it ?

> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c#n1399
> 
> Diego


-- 
Damien Le Moal
Western Digital Research
