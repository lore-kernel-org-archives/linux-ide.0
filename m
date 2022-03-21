Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCEEC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 21 Mar 2022 12:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347567AbiCUMuZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346258AbiCUMuZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Mar 2022 08:50:25 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A556443D0
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647866940; x=1679402940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2lAUxg9xZL7YbqLExH1JLC60GtUEJdaPknXpM/pVlus=;
  b=r8rbFletWqiVf3aClyhOfH9Q6LZKvYKdFY1H3Fg0G9hNIJDjF0GR8wLY
   d03cb24f5G3wHw+YcsFPv2Cl49MB1L5CAYQnpKSUeWVF5EpbocHs7r9LY
   d7M3oJGYCaVuaTsX3EMAeh8d0197EApQqUf5T0hfzeW7/70tLo/y/0Xs7
   XiMRd1Acq4CEIb4MjCj8zrxlDD+dxNQ5FMBSNMZ6+airYsDcod0DNlfvB
   mOJIC2nBEgzBpwM/pJ0Es4Tu3CIQEK1BFuXHsDZk9GzY7x9lN3mdgpqHB
   zOHn1dcU0XKaJqsZktT+Jd4k6VTW1nNROnPBVFkmmAYeQhf+d29/aa9VS
   A==;
X-IronPort-AV: E=Sophos;i="5.90,198,1643644800"; 
   d="scan'208";a="300015013"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2022 20:48:59 +0800
IronPort-SDR: RDqchNEEO0Bha9pkCKCs0hy2KvvqNGldCKt4sVGqMjfdXaprcbDsVw5Q0E7xsklbOQcqWQIgDh
 FwqscEEgctFywaO+B7Uw0f06XpgEu2gBHrPcnVh8w6sj8Ue+U/tyadLWA+y8m+GOAkOQ2cTtCc
 2xxj7xR9IBGz76NNgYn32BcB4DwXtfP6fZruY1PwyYha3sPPJgDqTSP04kBfAPboluxPpUL7dK
 +EUIGfVibs+yOsMaZURdmbMqJ3a3d4dAghFtvDSfLIcQQAjQvoGPD/XycvjV/T1fRDYcqSaJ6Q
 lT0GiO7MSw/QlKtcMjHXp7mR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:20:00 -0700
IronPort-SDR: e9O4iEl3XGzX4G50qCeEvv3Ei29UxHY3jaid2C6DlHqJiLsSz8dvwn4k2HbReNmE2yMflxmIDd
 0Ztjn7WQnFrIbW/so3muEZVlZnJV3LV+PKTWEeMJQB3mlXnyybfvjhE8jX9DQT95XhOXDTsnSe
 kKp6+T7OatId9h6zeg1HOj552e3F+5crmzSwo4Iueo3G+Kuq4JUUpp/FEe/GBTLvtxTHIVYKaO
 GBqOZik06BVYRlyB0ZyGe5FTKpCUvg+vLBvtKSAV/AdYdtMrH387vNyH1hpsFvzxa16gNnEONx
 LaM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 05:49:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KMZDq3Pldz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 05:48:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647866939; x=1650458940; bh=2lAUxg9xZL7YbqLExH1JLC60GtUEJdaPknX
        pM/pVlus=; b=kplb7Pcr4Zyx7408bpD9PKLa0tF9ITaejeDs3NqJg3AMPAdpJuA
        2g7bM93ZEAC3sOMq0hbD/t8pmhLgqI72xlwULwywFqAidGCCTER1QF+Wp5nZYZKW
        ABxhjFlkhoSVg2v26G3maijbYhP7e+61pxX0MVUHkaMb0ov1ixDmVTC4PPW0qhnO
        cg68KJD6c2IwHmWlzp97s6vgIo8b3M8lLVtrPP+pTJ4mVZ4N93WlU2+KAe8dBgcb
        E9jmH3VsOZltV5lg/fKQnqb6+dovf4Z0H3RcektUzUbsdBjVk/qcxAHdpQCTiLgM
        XwKfjR5OEbIQsZLEEPzC2C1IfmsYubbTb8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7gpU4x4CutV8 for <linux-ide@vger.kernel.org>;
        Mon, 21 Mar 2022 05:48:59 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KMZDp15qpz1Rvlx;
        Mon, 21 Mar 2022 05:48:57 -0700 (PDT)
Message-ID: <fc2cc4e2-c45c-84c1-3f14-cd884e07815b@opensource.wdc.com>
Date:   Mon, 21 Mar 2022 21:48:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/2] ata: libata-core: Disable READ LOG DMA EXT for
 Samsung 840 EVOs
Content-Language: en-US
To:     =?UTF-8?Q?Reimar_D=c3=b6ffinger?= <Reimar.Doeffinger@gmx.de>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
 <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
 <771F724E-8E00-4CFA-A39E-91EEFADE132E@gmx.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <771F724E-8E00-4CFA-A39E-91EEFADE132E@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/03/20 5:31, Reimar D=C3=B6ffinger wrote:
>=20
>=20
>> On 19 Mar 2022, at 21:11, Christian Lamparter <chunkeey@gmail.com> wro=
te:
>>=20
>> Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with the=
 a
>> message: "READ LOG DMA EXT failed, trying PIO" during boot.
>=20
> I don't see any info on which kernel this happened with anywhere. Becau=
se
> there was a bug that tried to use READ LOG DMA EXT even though DMA was =
not
> enabled. That was fixed by a patch from me for 5.16 (and backports). Th=
e
> behaviour you describe matches the possible symptoms of that bug. So it=
 would
> be good to know we're not blaming the drive for an already fixed bug in=
 the
> kernel... (I am still seeing some issues that READ LOG EXT - the non-DM=
A
> version - times out with interrupt lost for some device/controller
> combinations, but at least that "only" adds an extra 15 seconds to the =
boot.
> It's still a bit silly because in combination with e.g. IDE controllers=
 READ
> LOG provides absolutely no useful functionality as far as I can tell).

Yes, the added 15s is a longer timeout to wait for READ LOG EXT reply on =
resume.
Some drives are slow to respond and that was causing drives to disapear o=
n
resume. I agree that for old IDE/PATA drive, we could disable READ LOG [D=
MA[ EXT
entirely as all the information for the drive can be found in the IDENTIF=
Y data.
So no point. All the pata drivers could set the nolog horkage. There are =
still
many more recent drives that have weird behavior with read log though. Th=
is is a
pain to sort out and can be done only if a bug report is filed.

I am preparing a series to improve the libata.force boot parameter to all=
ow
setting any horkage/link flag to disable things for drives that do not be=
have
nicely. That will allow users to tune systems without having to wait for =
the
kernel to be patched.

>=20
> Best regards, Reimar


--=20
Damien Le Moal
Western Digital Research
