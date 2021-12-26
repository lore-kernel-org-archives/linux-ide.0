Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A90BC4332F
	for <linux-ide@archiver.kernel.org>; Sun, 26 Dec 2021 11:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhLZL4l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 26 Dec 2021 06:56:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32016 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhLZL4k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 26 Dec 2021 06:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640519801; x=1672055801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lILF1bne+jVtQI0XrL8K9ca3K4hGVvPBr8NBF3r/3yI=;
  b=ln/BCXlVXVGCdKVi/uMy30yzVKf6Zg6oB2ge9QYuiwyEEcMRZ3OxeOwm
   gHrH7PJShtwpRaLEcMz8XdD75MvxD/FPmrSBOTvCARru4UIIsAxDQfwB9
   aEUx0+f0/L3DIIk4e8NJ387y3+CvWZ4D+lFl32qvj2uo6O81hsu81djsz
   /GussqxrQQcxun7edSsJ3QufXdgVMXpgDSP/VGC08mRT73Iv9yUYRJ0Fq
   mxEGdFU2ZGqxL5+0h8dIqtXialWTZ4D2IvDftJOLGkha7dNtfdG5i9krG
   YbaEqtD8Cr8ln9om3M+aD/1YDtcO2RkMT66kljhNr9dVE5gSaguX2WHV7
   A==;
X-IronPort-AV: E=Sophos;i="5.88,237,1635177600"; 
   d="scan'208";a="190139240"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Dec 2021 19:56:39 +0800
IronPort-SDR: b8O+ODk+Bp7CT7egGQzRSaj0aoqK67Rq5szcXWL0kif6xB/7N1jEat9zGX/cyK0enqnUyc/ge2
 u5n2X705GaWFJZxfUpLOPQCnusC8K9/et24dJmklo06V/TQQwq6y2QLL4q/MqvU7NAluZmIwsg
 bHPjHYojnAk/yUq1XMJxhAKAqwkcMmzIc+NZMeFahY0UV5T4ADvjmQpUv/8hobYb7KOVSMpZlp
 gwHFcb1Lo6dbP4qxEQ6zl0XirIULxQ4mWMmFFcElR+GO+YABDUpIMNb5lAXueKWc7lSs3FtneI
 EDIIfGjWNPfHtzBa8+Mrv8H/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 03:29:20 -0800
IronPort-SDR: xyTMVQzOPEzr0VuhFZd+48m+z6XQPkIoNwiPSJx1owXzuCKd4IIrAW69Xd8r23kERcS7srr/20
 cROMO5BmnTR77mWAidcSOmT1fxHvFd6nqvrIozlEQ8Hrs2iRiMUSp0XdIGyiDxvwD/nmh0Acb2
 WjrRCSCsxC4vT9MvaTa6Melse8nlIUIcSjCPgUtfGowLoWUcFMQ7jHpBZIs6g0P1A1Bvs6za1U
 gfMnehD4bkj1flGIBNZVf7l8/wmNfe2ygsbREHnl68U85HimDu9rmbJrs0h8ZMpuJPX1w9csyJ
 OWM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 03:56:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JMK5f4Sxtz1Rwns
        for <linux-ide@vger.kernel.org>; Sun, 26 Dec 2021 03:56:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640519798; x=1643111799; bh=lILF1bne+jVtQI0XrL8K9ca3K4hGVvPBr8N
        BF3r/3yI=; b=uRxEF0j6bRN+0YdGM445wNABOUM59J4hnZgdH/Oaed0E/uMp38X
        MdJ4W/5Jp3y2lYmOTVPZMyLwmBosAfmzcYEbMshVR+PBwnJqnQeGqUh7OcQxqmeE
        +Hz2B3dJpNoHlvf1WkvQsQWWftoG7gezA8We8X0Ap6GN6dPT8S8llMEGCTJG90yZ
        tWEMoPQFHrY3m0Xcr1dayLzFu5yInT0gK0SQjnT68ZIPcvo8YvI+lVvZ91Ug326G
        kT8Zph2Co9wOSCTX4g/w4RZvLHqIQR1qEI97cWg1f88QNzkVW+DJtnvjOjy6XwOG
        X6L9Dm+Grr7GR/sbg4fUlxXpAbgPpfh35Mw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o4WNXQM-N_1H for <linux-ide@vger.kernel.org>;
        Sun, 26 Dec 2021 03:56:38 -0800 (PST)
Received: from [10.225.163.37] (unknown [10.225.163.37])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JMK5c6Mtfz1RtVG;
        Sun, 26 Dec 2021 03:56:36 -0800 (PST)
Message-ID: <3cab75b6-f8f8-318b-4aca-b7bac484b60b@opensource.wdc.com>
Date:   Sun, 26 Dec 2021 20:56:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 02/10] ata: pata_platform: Drop use of unlikely() in
 pata_platform_probe
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <a0a158e2-d77c-e3a4-5858-020674b22d92@omp.ru>
 <CA+V-a8voiYxB+s2rW9s7OhSsasvVzLO6KscO354+kaQFPO6Zsg@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+V-a8voiYxB+s2rW9s7OhSsasvVzLO6KscO354+kaQFPO6Zsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/25/21 03:02, Lad, Prabhakar wrote:
> Hi Sergey,
> 
> Thank you for the review.
> 
> On Fri, Dec 24, 2021 at 5:54 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>>
>> On 12/24/21 4:12 PM, Lad Prabhakar wrote:
>>
>>> pata_platform_probe() isn't a hotpath, which makes it's questionable to
>>> use unlikely(). Therefore let's simply drop it.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>> v2-->v3
>>> * New patch
>>> ---
>>>  drivers/ata/pata_platform.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
>>> index cb3134bf88eb..29902001e223 100644
>>> --- a/drivers/ata/pata_platform.c
>>> +++ b/drivers/ata/pata_platform.c
>>> @@ -199,14 +199,14 @@ static int pata_platform_probe(struct platform_device *pdev)
>>>        * Get the I/O base first
>>>        */
>>>       io_res = platform_get_mem_or_io(pdev, 0);
>>> -     if (unlikely(!io_res))
>>> +     if (!io_res)
>>>               return -EINVAL;
>>>
>>>       /*
>>>        * Then the CTL base
>>>        */
>>>       ctl_res = platform_get_mem_or_io(pdev, 1);
>>> -     if (unlikely(!ctl_res))
>>> +     if (!ctl_res)
>>>               return -EINVAL;
>>
>>    I think you should combine this with patch #1.
>>
> I'd like to keep the changes separate from patch #1, as it's unrelated.

But your patch 1 adds the unlikely... So simply do not add it in patch
one and this patch is not necessary anymore.

> 
> Cheers,
> Prabhakar


-- 
Damien Le Moal
Western Digital Research
