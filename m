Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A363C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 10 Feb 2022 09:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiBJJtd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:49:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239129AbiBJJtb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2022 04:49:31 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBCCE97
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644486571; x=1676022571;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Gpv9Hx/pHGE94fBoyodbpZFrnV1A2PbD1l97ATn3CIg=;
  b=DXjm1K9LZYQWY7OG+i+VoEgWvuVNZ3554dV274wrFBkDt4yXPjOKyOMa
   R61oamfpJgsGOh+zFqV5qe6WUmh5BX1m7VHq4oeYxGIJQe4W0S1F8ym9B
   kGR6qgsp8aug4Zg3EXnvrI4Mp27RMmIMXRtA40Wajm8ZaVzgPzhfLFlho
   VE0B7K3QmXz78HTYRYYv9X2Wm77qf+mdTniCS2Y+ymF4jsFF1/8pj8wxj
   8pQRGcoD3IStc1Gm4Pc0Ly50u45yMt+MX8B+ZrGHvlaTszBNY4URvoL6a
   glLks7+AEofnkykj9sIB5HEYAu/1ee5Rbb9vjY547kjGmiZi82rNyp1o0
   A==;
X-IronPort-AV: E=Sophos;i="5.88,358,1635177600"; 
   d="scan'208";a="193569794"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 17:49:30 +0800
IronPort-SDR: A5S4A6EguxNwURkQp7NsxAXX5XmrfG3ckeOPTmRDk/cAtgGaJgyYsFiIhOflv9n/BZWXaOmXZC
 EfAxcQ/KvBfm4i2ybuxIZP1EjviXpCqYCfzJV0zIVv6QWSyYSVTMauThXRgAwxG+RFDDCSDS29
 6qBOGQPMbnF3ZMsQoixokYxFDt9NYvIy0Ob9jvWqmIoKxsHAlcINawU0e1uogEanKtG9wyeyZD
 2tb+GGELbGTurts8ggDcXUBAGwNOeAO3NIy2OcDoDOpyBgOnjn+UOANMSrQtvGL68DvvTzU1Qr
 +MP095DgrmWtmYbkqFydnJIn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 01:22:27 -0800
IronPort-SDR: 2SG78YsgQcjB0R+JAf9jp2noW9J47KFqGY/lCH+uQlvxUWZuypwctkBmAhpKUTJof6O2lGHJ1u
 uNHD5v2bQA1oAe2VQpt8oDl2RtdTOnhtoLRg7faj62BZQ0TjZFdffHz4wJfsiKiUV2eESN5X3D
 3BGe86t5+jc6CzNK8MN7lxzcDsc7UzhSiNnGJc4EwwTzhzrWmfggJZbXiuWd5x0TA1iptCKaCX
 U8vHToo4QGv33dRpWZ4/Pci8JUlKNntwulfdImyciN/YdJdTA2NmfBtJRZ1QMJ8ZqbxkEcJuS7
 NGw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 01:49:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvX5j4VTRz1SVnx
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2022 01:49:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644486569; x=1647078570; bh=Gpv9Hx/pHGE94fBoyodbpZFrnV1A2PbD1l9
        7ATn3CIg=; b=hQCW+dKeKW4Ric5f8hnfvOH6Nu8BjXVKGmBnjwD/MnRCYliGsbD
        2ro1yZHdzmgge6QKlXTm41pu66Ze1JPmdRKuELf2p4sqmp/wajoh7wwBBLe9TwNF
        8PgZTTvgUuAq+zH8aMZVCQfN8Cp6X91Bg8SMy0h85PtQlaB67soXpYfucKEMRZsB
        3NyrIpD23L0n7VO+MyrsjZI1wNaQe0teRPkNui7zRGJOg86HT6Xy3QBEoYWSuTGR
        anNyOGGR4/TSWa0qPbCb4Dcmj9/hP+yWordXulKBklLlXLHAEbB8F97xCKZPH/Bt
        aEGKYc57EeL2XHoMfP6XxsX5aj4OK3L1UCw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kRUqjkaNcV0U for <linux-ide@vger.kernel.org>;
        Thu, 10 Feb 2022 01:49:29 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvX5h5YMBz1Rwrw;
        Thu, 10 Feb 2022 01:49:28 -0800 (PST)
Message-ID: <ade8704c-5e5a-8590-d382-046d947c66dd@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 18:49:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] pata_hpt3x2n: check channel enable bits
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <062c3834-da7e-273e-177b-d7aea4b1ba81@omp.ru>
 <9a9c5fb7-904a-5066-fd30-6288d7cfdff5@opensource.wdc.com>
 <920357d9-16fc-c271-ac58-1f4e0d5f9a7a@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <920357d9-16fc-c271-ac58-1f4e0d5f9a7a@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/10/22 18:20, Sergey Shtylyov wrote:
> On 2/10/22 6:06 AM, Damien Le Moal wrote:
> 
>>> The driver's prereset() method still doesn't check the channel enable bits.
>>> The bug was there for the entire time the driver has existed. :-/
>>>
>>> Alan Cox fixed the HPT37x driver in commit b5bf24b94c65 ("[PATCH] hpt37x:
>>> Check the enablebits") but forgot to check the HPT3x2N driver which has
>>> the same bug. :-/
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> Applied to for-5.18. Thanks !
> 
>    What about the (analogous) pata_hpoet366 paych?

I think it fell through the cracks: I can't find it...
Can you resend ?

> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
