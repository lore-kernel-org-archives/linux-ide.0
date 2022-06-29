Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D40C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 29 Jun 2022 01:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiF2Bvc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jun 2022 21:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2Bvb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2022 21:51:31 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD172E090
        for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2022 18:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656467489; x=1688003489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mC9KTh44NseJcYgO5qIlz6Lcu7ZWIZ9u3GTtZ3n6bbc=;
  b=WG/kivXDWQtAQ/fU/gAz9HvK6EgGDmna9ZiIQDuQC69cj2H3iFPzxSAF
   O6jMjnbFDLBuG7Z1/j3vjYtUexdr+F4/02F28XNgZAxnhY5Dhz5Vr4Gw7
   Nk03HVHTcWNi70F/AaWjRZGGvd2ydNYVA+/6/dMFtapuPbA8P4Wz/WesT
   jE+TQ4vGOKxboL+9koQx0LDSg+POmI9pkrE/Jn+q34yltXh7kAbd6wTUc
   xGEFyZyeayCjhhctQPqTDD7ORv1N5Ez1ecKcxcJ+IB5thN6lb54CdOGBv
   FxwEsD7xV5P7xns7+xKZvVtlWT/mlwZX1/fBcEKDTaM2a/7MvAgD7g7UL
   g==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="204343897"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 09:51:28 +0800
IronPort-SDR: 3U8k7VgCgXqhIUV9rfHNLn2YfM0xgC+v1W7+7o68cHTE9crx4xzYj0hmrnAibf/BRul5XN74vE
 Y9bs6WYvrn7yFwulNh91/qfPNm2Q54mrbefiXdcwdbieeL2HCApVv0ybqsZ0jJzib7H4xlPmI7
 wJZjmRbB98U7h+o83htygoqnAkQvqR7NG6CssZhDFY+rVBhRq4Cf1xBolBRKUvS564cZE7hr+h
 AbgQmfoc4At8iRjyP+Vmx2KnXVE1JV2rh8Ifvatyhn6wrAI6AkF247HaHROpYs1xsBA/QJjqjf
 z+ClTO9qDl5rv4F2kstqcbes
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:09:08 -0700
IronPort-SDR: INYyQPfrN0UoQbGsm0ii+L+7swiAOrJG8s75gggIFkcgGposiefbvhjBKx7aXgHo94Ci04Khpw
 9OmBa5XxFiezX8Zson/5Pto959aZj7Q7Y0oQ0afsREmH98FV9rw9nSA9sKdfhbMUkrrC+YGBDh
 fQufpzfCmsguwZSwClMPStGZMY55Hwkt32dJ3l3lRnxIQ4fVdyIsbH2X5n4SKeSpiWbmriTPMA
 +gmJxT+DZxwjfit809gFPFSK3qqBrVJFzQ67rwFnmF4corx7zwOsWE291n/Mt0pYrBLT1XC+fe
 smI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 18:51:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXkw04289z1Rwnx
        for <linux-ide@vger.kernel.org>; Tue, 28 Jun 2022 18:51:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656467488; x=1659059489; bh=mC9KTh44NseJcYgO5qIlz6Lcu7ZWIZ9u3GT
        tZ3n6bbc=; b=AUrCvbIXWpkkNk9It5e8ZPr34Idl9naLr9OkavLHhqzgFvI31eD
        mFniX4anpLeZoM1npj5ia9zZLKjNtiHUPSN6nXORqE9osBmJ7LATMXgElj3YrK/I
        j1HdNqkwGMtf79jfNETEU6xBUF2TpswJdw96ESUqz3zlax6e/bA1eN1hp8CcwPVy
        UD4lyURHDHaLnAsYA0xuJztRW97BAESlCWL1rhVE5oaVJLza3os0/6oQ5Ezer12H
        i2m16xQPcdXhiY/vK9gHcR17ExqIXwfJYFuMExubY46y7lqLlcMknB022g27xxQq
        1GLONQGOTk3MpSUcAdqAUb23KVFPMYxrOmw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1rJ3dh5kf1eH for <linux-ide@vger.kernel.org>;
        Tue, 28 Jun 2022 18:51:28 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXkvz3cY7z1RtVk;
        Tue, 28 Jun 2022 18:51:27 -0700 (PDT)
Message-ID: <69ed5587-52fd-4171-b97f-091df8b377c6@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 10:51:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: pata_cs5535: Fix W=1 warnings
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1656335540-50293-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/27/22 22:12, John Garry wrote:
> x86_64 allmodconfig build with W=3D1 gives these warnings:
>=20
> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_piomode=E2=80=
=99:
> drivers/ata/pata_cs5535.c:93:11: error: variable =E2=80=98dummy=E2=80=99=
 set but not used [-Werror=3Dunused-but-set-variable]
>   u32 reg, dummy;
>            ^~~~~
> drivers/ata/pata_cs5535.c: In function =E2=80=98cs5535_set_dmamode=E2=80=
=99:
> drivers/ata/pata_cs5535.c:132:11: error: variable =E2=80=98dummy=E2=80=99=
 set but not used [-Werror=3Dunused-but-set-variable]
>   u32 reg, dummy;
>            ^~~~~
> cc1: all warnings being treated as errors
>=20
> Mark variables 'dummy' as "maybe unused" to satisfy when rdmsr() is
> stubbed, which is the same as what we already do in pata_cs5536.c .
>=20
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied to for-5.20. Thanks !

>=20
> diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
> index 6725931f3c35..c2c3238ff84b 100644
> --- a/drivers/ata/pata_cs5535.c
> +++ b/drivers/ata/pata_cs5535.c
> @@ -90,7 +90,7 @@ static void cs5535_set_piomode(struct ata_port *ap, s=
truct ata_device *adev)
>  	static const u16 pio_cmd_timings[5] =3D {
>  		0xF7F4, 0x53F3, 0x13F1, 0x5131, 0x1131
>  	};
> -	u32 reg, dummy;
> +	u32 reg, __maybe_unused dummy;
>  	struct ata_device *pair =3D ata_dev_pair(adev);
> =20
>  	int mode =3D adev->pio_mode - XFER_PIO_0;
> @@ -129,7 +129,7 @@ static void cs5535_set_dmamode(struct ata_port *ap,=
 struct ata_device *adev)
>  	static const u32 mwdma_timings[3] =3D {
>  		0x7F0FFFF3, 0x7F035352, 0x7F024241
>  	};
> -	u32 reg, dummy;
> +	u32 reg, __maybe_unused dummy;
>  	int mode =3D adev->dma_mode;
> =20
>  	rdmsr(ATAC_CH0D0_DMA + 2 * adev->devno, reg, dummy);


--=20
Damien Le Moal
Western Digital Research
