Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775EEC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 27 Sep 2021 09:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5543361002
	for <linux-ide@archiver.kernel.org>; Mon, 27 Sep 2021 09:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhI0JMo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:12:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:48553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233519AbhI0JMn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 27 Sep 2021 05:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632733828;
        bh=k7hXDoUiyRq2DmNFOKp758qOM2G4/w4GTnO/n1gl9A4=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=UCghBOHSVKdbJTxGSxskWwVS3DOk++TwGZvZvy6CtQTYVR7Pfrdt67BPmU8OOnR1d
         cnyNshCoInmQIDevd1Hol9ZfwgdyCQv1+K+nUiRxL1xSbfz9B/jY/AkH6OtA4UG4Jx
         X3d90hJg0NQTEoIWvOy4JhZ53NazjwLHAgCmtJdk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from smtpclient.apple ([217.85.124.89]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYc0-1nGWLa146o-00m6y8; Mon, 27
 Sep 2021 11:10:28 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] libata: fix checking of DMA state
From:   =?utf-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
In-Reply-To: <3850840f-ea01-a297-9347-55e8b5bac221@molgen.mpg.de>
Date:   Mon, 27 Sep 2021 11:10:26 +0200
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD97D84F-DCE5-40BE-A547-95E1DC533E0C@gmx.de>
References: <DM6PR04MB7081AB7034F116CDFBA43890E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210819081340.4362-1-Reimar.Doeffinger@gmx.de>
 <3850840f-ea01-a297-9347-55e8b5bac221@molgen.mpg.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Provags-ID: V03:K1:R7jDQhbbCxBtHoyvRowS75wMATFy4JBC4ifpl4ZnL+eo+PWHhgT
 /R2UdV1vLpedEqQREt8jUB4JgAA0v8dYibe5y9CAa7RO3yuN227BTGf5bIrJChKG+YWEhQy
 z1MFu8SpJleh0d6HFYvKgmOgdDk6yDOQc+w5gp+ivVwJiYEeY7R300oCIZ4kz8yYwz68Cfa
 aN7+VLHmEg4jtAKvpp6eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bm82dtnkF9g=:1lP2KvO5sjIT6M/wObWbFd
 QI2YdHbG4w13+eK3AmrB4CASgGGAwmyodni/g04+5IjGH4k0Q6WRgeQZJuG/fMIharJ6ggwjG
 pOgcAzf7tuRt/OrhEpq+2s1LFDZpXFUIJkNpuKTXBwi72WCVvsTwI0Ze8dFk2YQaRBh3vbzhd
 TbflnXY5Sz2vpmAHc3nBADvHBwihul4iOzug0k6O0uV4ktTEKUrfqGwRSq/w7kHU1dyIG2PWs
 EV/yi5rWzbrzXukhCBOgwNqgknr9FP1Mx1kgI/RyndpNBQYJfrNuteCQT0DYV5/k8lmto9CzD
 +hcxgnwWqC57nSCodjsfwbZpbm1CvpjSz9jD0HjY/xpbkV8J96NzlpJTCN79QwPB0OImGkbn3
 /VMxyEx/Y6SPgz/YDdIjkb1XY+OE1Rkh4CSowUPz5QkfQLDGUOdmar4aSfvd+lp64n3NbgZl4
 A3gUM4QZiHd8Y/LkDCLQmjlHvGetQJv8YbcfYDeu9Lwx7zDG3jMCTr2Ivzuv/YhVICzKoE1gi
 2F1IKRzr2SYcUuM+jF4SI4O3fUwhiJdEB6bn24HWweDukLEHZtUiOYdnvpgCJM0YNmS0acXIM
 zjQoEs8dSEnOgSLRosou7ACDh0DmewpI4uHZ1M7Y17npeMmQM0V2TDDKocD6H+N1uGzL1SbDk
 MpP/yDS2pRnjjX3VB7S5jboAWlZqPgzteBiBkakgkD52OFWQpSbdsm88DhaLgZJJFSqGWf0zn
 Lb6WpUwXOEmTANl4Pn0xOJir9eQgyF0jbyMmNdtMcLM08esRCkSZUxoZWZ6ZEuuEYfqzEcpFY
 AkJMvKwAtsfjbZFFkLOIMvf9UFaR6M7sCMILnZtI4ESiJnrFo9rwfFaLTfuGF+MuEXGCwJm2d
 0xh220qnDGLX18Cu254Mt84JwICudnFNn6GERjwE1bvwMxKeLTVo7+SdoCvv/6mtFW7pd2F97
 XFFoWunI04JiYKRMsbh3U4rrjbKM/xAYXKdO5335IK/eIgkjhsCT0eWXqyp549JUOE8MmchON
 +cwpgTB6ZcfKf3Zlee4vYNZTr9UZL4rfes5KKPstvVLGdHveaK8VW+Jb3TEO8HNFT0U2FZHko
 co1r5VSzgV43yA=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


> On 27 Sep 2021, at 10:56, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>=20
> Dear Reimar,
>=20
>=20
> Thank you for the patch.
>=20
>=20
> Am 19.08.21 um 10:13 schrieb Reimar D=C3=B6ffinger:
>=20
> Maybe start with a problem statement:
>=20
> With some SSDs Linux logs the error below:
>=20
>    failed to set xfermode (err_mask=3D0x40)
>=20
>> Checking if DMA is enabled should be done via the
>> ata_dma_enabled helper function, since the init state
>> 0xff indicates disabled.
>> Only the libata-core logic is tested on actual devices,
>> the other changes are based on code review only.
>=20
> Your Signed-off-by line is missing, and you might want to add the =
Linux kernel bug tracker entry:
>=20
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D195895

Thanks, I missed that the Signed-off-by got lost, and thanks for =
testing.
I actually wanted to ask (e.g. Damien?), would you like me to split out =
the fully
tested and confirmed working and necessary libata-core change
from the other changes?
I am quite confident that all the code modified was wrong before,
however it could be that some of the code actually relies
on that bug to cancel out further bugs, so fixing could well break more
than it fixes...

Best regards,
Reimar=
