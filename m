Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AC3C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 27 Sep 2021 09:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C496113A
	for <linux-ide@archiver.kernel.org>; Mon, 27 Sep 2021 09:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhI0JRg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:17:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39253 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhI0JRf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Sep 2021 05:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632734158; x=1664270158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PDtSVjUQHCP8fA/5tb7YzGRMMzf1Gvo+mQoFWAP5Y4E=;
  b=lFBjKXCiVP09fQs9T7/XXmxE4v7Ats3XC3gnSnEv8ahkZz5f05FYdmm+
   AA20Ik1F6BHEGNFw3fVNpxEf1OigeAq7nZtFQOgDOBaVsE1KpNfQXIwMi
   auZkIbUnm7MJYFXcgVjVMcv9cD3x1ZoDNhOI77CkwwgmXtcYbwtx6xQXF
   608woST23UbImA/Fld+9hYXq5uy6DxYbdGchD40MYcpikbxTlCoeqp3gT
   kILbU95Ryi5QzzJ2j/CRz1Me8y0AzRYxV4RbbE5NXrgrT+/Jy+8YQ0b8l
   dgo/OpCjSyGJx6NVdScwQdzgUGqPfehw0Ky1464XtVe+W/u6gNYhWoN+0
   w==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624291200"; 
   d="scan'208";a="284851750"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 17:15:57 +0800
IronPort-SDR: Yk0IEu8ieS4Px9V6Hq92NMuLE+TTdxj91bEBJo9b0iZkkSE8QZIhIljqqQzCYqM/qLLbNA3wmk
 1ochtj8t+/J0+qk1HLcS9kVsxdKBNAG+TbkLoOiOdkyqJxNzjTBa0wAqkDoC255NBFQQ+aNpl6
 RmDAqdhqJ3VhLGN/5ZxxvkIBB8JGcpUJ79CM0Fdyiu616NcupC7jjLEkFurYfUpv/PRTQG0j8I
 a1yd4nI+gqVb7IcdyvPsKb1Rs7juJ/BOihhOJ+rrhP5pZFJE4FpqoDZFvm3KT/ZZyK82Yw7qVv
 CLT7Y5VnELY1uMemtKkuCS1W
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 01:52:04 -0700
IronPort-SDR: 2dH5Nh4cXjl4XBDbqIvkGoqF12o5AiBxth1fgMAMoj3uV7nvCPvkBI00T0H1TT7vDjIw1/DHWn
 iX7G7U6C5TlINemYz+FoImZDEV7Cf1h5us3IfkAobKpB9/Y+8DioS6mBo2TaWLVLqB2BmHYdrz
 omghjIO/VA1/kco2V7dcrrWJYt+jATzppTelil0NiSJDRN8z24viXNfq/1MJ16V1maXAIrrGGU
 jDN3P6gkq+cFXJbyFHu+WKsk3qlY7ZRCa32zvJyKtmE0rRBinKvaXoTNqYBWsTLENk06e8Dhlu
 2vo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 02:15:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HHxnn0MBDz1RvlM
        for <linux-ide@vger.kernel.org>; Mon, 27 Sep 2021 02:15:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632734156; x=1635326157; bh=PDtSVjUQHCP8fA/5tb7YzGRMMzf1Gvo+mQo
        FWAP5Y4E=; b=rIJQM0oZ8ysDyQEoZ+wjWfK7ton8SJ9ZmdktLs3EhrNw/njrn5R
        tyURXkJY/7wSXNeNu9fyBWTKLc3aok2ih0O3I5qHXsZIWtrzSjn8r/BAb3lGihm8
        SHunU6KlhS3jBbXiWuTSdx14ivon2e7OG0nqnZNVnygdQofZ6xCvqZ9T0ZcL5hUm
        VPzjx8r7ceyiYUQ5CAzKYpvn9/55sh/QsdWW+Cm03gBgnSdcO0HBk+tUpXGk5Ktr
        kkcq6ePQSP6fPrFPJR5qt2qQJjajg3LyUSNr55ED2g7SrWWcUoB8c89QdAAc+L+v
        TU+od4DeQTkYyUwAyt1SVPm8X6o19dijQCw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y5kDYWFLCG7p for <linux-ide@vger.kernel.org>;
        Mon, 27 Sep 2021 02:15:56 -0700 (PDT)
Received: from [10.89.85.1] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HHxnl46wGz1RvTg;
        Mon, 27 Sep 2021 02:15:55 -0700 (PDT)
Message-ID: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
Date:   Mon, 27 Sep 2021 18:15:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH] libata: fix checking of DMA state
Content-Language: en-US
To:     =?UTF-8?Q?Reimar_D=c3=b6ffinger?= <Reimar.Doeffinger@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
References: <DM6PR04MB7081AB7034F116CDFBA43890E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210819081340.4362-1-Reimar.Doeffinger@gmx.de>
 <3850840f-ea01-a297-9347-55e8b5bac221@molgen.mpg.de>
 <FD97D84F-DCE5-40BE-A547-95E1DC533E0C@gmx.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <FD97D84F-DCE5-40BE-A547-95E1DC533E0C@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/09/27 18:10, Reimar D=C3=B6ffinger wrote:
>=20
>> On 27 Sep 2021, at 10:56, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>
>> Dear Reimar,
>>
>>
>> Thank you for the patch.
>>
>>
>> Am 19.08.21 um 10:13 schrieb Reimar D=C3=B6ffinger:
>>
>> Maybe start with a problem statement:
>>
>> With some SSDs Linux logs the error below:
>>
>>    failed to set xfermode (err_mask=3D0x40)
>>
>>> Checking if DMA is enabled should be done via the
>>> ata_dma_enabled helper function, since the init state
>>> 0xff indicates disabled.
>>> Only the libata-core logic is tested on actual devices,
>>> the other changes are based on code review only.
>>
>> Your Signed-off-by line is missing, and you might want to add the Linu=
x kernel bug tracker entry:
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D195895
>=20
> Thanks, I missed that the Signed-off-by got lost, and thanks for testin=
g.
> I actually wanted to ask (e.g. Damien?), would you like me to split out=
 the fully
> tested and confirmed working and necessary libata-core change
> from the other changes?

It is generally good practice to have one patch per driver, preceded if n=
eeded
by core changes. So yes, please split things if it can be done cleanly.

> I am quite confident that all the code modified was wrong before,
> however it could be that some of the code actually relies
> on that bug to cancel out further bugs, so fixing could well break more
> than it fixes...

I had a look when you sent the patch and did not see anything scary. Plea=
se
resend and I will check again.


--=20
Damien Le Moal
Western Digital Research
