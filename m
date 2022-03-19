Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8146C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 19 Mar 2022 20:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiCSUoh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 19 Mar 2022 16:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiCSUog (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 19 Mar 2022 16:44:36 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4801AF523
        for <linux-ide@vger.kernel.org>; Sat, 19 Mar 2022 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647722581;
        bh=l87zBUv4BioEjrQqdg4pisghRozJciHrCndoQGphUNw=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=kLk9KkdHLNpaoEAs/73pIo76wTqiSrvCV5LQ9kBAiqf19md58JfblT7EC5ceQ2INI
         tWeM7VQM4fEgQXbV88GVUJFzh/3y3L7ycywmcuByDV02+OcI5GbBw/2XIJoOr9YcSd
         M4efvKBKNXXg9xCYnquA+0DuO4rMQ4FWja469Jrk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from smtpclient.apple ([98.128.181.196]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1nRIBx1QmG-004XAM; Sat, 19
 Mar 2022 21:43:01 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2 2/2] ata: libata-core: Disable READ LOG DMA EXT for
 Samsung 840 EVOs
From:   =?utf-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
In-Reply-To: <771F724E-8E00-4CFA-A39E-91EEFADE132E@gmx.de>
Date:   Sat, 19 Mar 2022 21:42:59 +0100
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D5F418D-D612-49A9-80DF-E61313FE006B@gmx.de>
References: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
 <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
 <771F724E-8E00-4CFA-A39E-91EEFADE132E@gmx.de>
To:     =?utf-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Provags-ID: V03:K1:Yx4SDweyftnbuwp0TwJBEHCA9zM9gRIYErJ2sYl6XbmgGJuqouT
 iz9AG3fOVzst6y3wQNIzfZNLcZ+yfvpdAeaaD7tt7kwyLpylMGUTAu++noR5iu7ZCe7p0yG
 nVwFECED6VWCiTSfm7dEwt6/Fnd4u9EMVfDZ/cp3na5KSIfr14Bp8rs8xZ4G/6varPCsZ5d
 DKPZUvATQ6qTzTWcAmHGw==
X-UI-Out-Filterresults: junk:10;V03:K0:8aC0NaAzgHc=:d+IKZseS6dRhE+x5PkJeZMko
 sLBq+GEibkUjsClc+RZd3+cya9lJ4nDG9g1TlNMX5UePUzwasjsCIA0Jnm5fWyfvfXoxvNj7u
 V7Oo+aYhlw7jfi+4XZwaL5j65RJBYFx3HMsUWxrXTQArPJf0K6JFoE5L40jmOMNx8WKHrHbBU
 ax8zGSaJOycmJTTHL7HudHDhAr8PYXy1Y/bBX2Y0kH+bcrRUVXBR7OBD8NJBzvSc+bJX1fGyN
 5iM+DwS8tOJQYJFD+n6s3sOUmeV+zbhz6gvM7eWXNPHZYQhqGKTK1MgKrVzYrLLt7Q9rDXl6V
 7b7s76m3hFbxQrsQgojsXsLo2gbBeGIHSMiQ2znaT1m1GABoY8/i2K+S0JgJm4+A5rtbu/WOS
 CVYseY0Cz+vgtx6NMnX3gF+m7zgJaTGzsjlRLqPgQ5kOpAwmeGl9drCE+ivdxPdJLM01n/pAJ
 t82Sdxnd5zCFfKX6wqxSFSeyHibvC4F1aN0u9sZuBofoIT0cENM3Zia5tQ5/Yctvnamw9qSDI
 Ib84ZKB8FlOYhSm32ZrlFvvRX2wyW+e2zv24Em1smSM2oFs8g7xHowuzzGo129uutLXd3P0MM
 mlGe7BCX9gmaJsF8glvQIrvOlIgXnR+0UQ4XtbCCpz6vYtguC3jLQbdMOSETYyHJ9iQ9skr49
 O4mDVVvoRShk7gwrZmPJGlbF71bwxZXdHQ4SrwPhPYBCDtsexxKD1U7c6BGs3/rI/uGDKW/wZ
 RJK2ejOhe7ABK2FbDAa511kKj9p3ASKMfo2xrZxvIRHlgB1BUTpcGpY/VcjfLjJpHlQKrj+ND
 Ae5+x6IXITynS1vAHGTGRbDNvDHxYD6z395U/85FiQNg3E1ZaC+rq7Mgx4EMqlvRkeG1JeSS3
 Xz4nyL/LoGf0gSTUrA9VghM9j2DSqrxFWkLPySn4B0PyaRqgEs7ZQF4h+ZeUisPgxMxH0nAJz
 KpOuO1+hWvmrMm1Zs7KAY6ITpiYwSap56qFjX8f//HHvCyYA5R8sC+a1FYfccnX0sLrG5bLFK
 4nhqvB5RPCNJS8PKME4JUk0gtATQLmI+AObhLxiGiBD2lN+v92pHQE2R9fksZSR3pzSiNw+HS
 AkQP51SIRQTlsQd6ivrlcaBqLKiDT/0XaxE66wPFiuZgT932YNgKe4w==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



> On 19 Mar 2022, at 21:31, Reimar D=C3=B6ffinger =
<Reimar.Doeffinger@gmx.de> wrote:
>=20
>=20
>=20
>> On 19 Mar 2022, at 21:11, Christian Lamparter <chunkeey@gmail.com> =
wrote:
>>=20
>> Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with
>> the a message: "READ LOG DMA EXT failed, trying PIO" during boot.
>=20
> I don't see any info on which kernel this happened with anywhere.
> Because there was a bug that tried to use READ LOG DMA EXT even though =
DMA was not enabled.
> That was fixed by a patch from me for 5.16 (and backports).
> The behaviour you describe matches the possible symptoms of that bug.
> So it would be good to know we're not blaming the drive for an already =
fixed bug in the kernel...

Ok, seems not the case, fix is in 5.4.160 and the first report was from =
5.4.179 it seems.

