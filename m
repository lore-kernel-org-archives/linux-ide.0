Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0714C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 22 Nov 2021 02:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhKVChE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 Nov 2021 21:37:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2025 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhKVChE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 Nov 2021 21:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637548438; x=1669084438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IoQwi1C4X0DcKL4xjs5tgpaugSqho0bzOCRAZrlRMPM=;
  b=giXJzal20yCfbSkmaFj7AZ2Tkcvag9Y88h4ryhxMzBMT8SLzVpN0YLYy
   LL68NOyLaZ4Kt/90NoyGcJQVnJ7kDYNxMVGTF1K48OOR+EJK+R+CAZpPD
   nA1TE6NgBEqm+RfhqMC6QNyv50UY+U8nVMDT1rTqlz/vCAavwrYpzlo10
   ToNpaP9l9JVaaaQN+baSdnO0DHwbSRO77Dtu89ifI5wSGzOB/Vb8sykP3
   5dbhOgIwv7YMySSPPXmrtCg1YobI6iX0Ipp4iHVLCIpQ9E+KyXkO73GAp
   +SjB7OUQKNd6cezxyZWYydQGJls4c6VGqzjMTCAjq42/ovnwoeJM1F6Ks
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,253,1631548800"; 
   d="scan'208";a="290200406"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2021 10:33:58 +0800
IronPort-SDR: UQy6W7hqBAHxMslpA1cFHbb/a3UqKR+xv6yd30cLXL48suOI9zMclvz3KbTJsQQ/iH2uUYW7By
 GUWWdUbMh3e9pnBvz8sCv9cKIMibVku8SdMjfUlmTLRltZfXde1AEa5+lv61wk40tumMlX/ljV
 Et7c5iKcamS9G5dSGFWmfZRKKCRGwX3q/7ZlJ0eFTkrx4cfPjvrx+n02/lhpzx8VDoaoPel4rF
 bnvGTXe3UkRG+Ds4szHtNWUleboWudO+Ssl2iXO+5kFIWCLt+NWWjpNz5x1TosTEjzU/WxclX+
 /p6sVcja0ODoTYzzuUcE/VbV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 18:08:54 -0800
IronPort-SDR: qLxB8pA6SF1nBvy/W00s+mEV5hORl2tB3xgbL+j7irs6c0wDCZD+V/PHrZk1SEb2m5dtjf5eH2
 OpkAkU18dddkraDrDzZtlL4ZgAoa9fvcc3VQTlx8jfxDzbqYxpWhzSnsOkr1O4+KpZtDxDQqLK
 ppaPqR5FunIp7hwvEqPCcz2hNrxYs+WBkRItZOQC5SnEk3QKt3DDzIlA5HNgBGRQ7QOT9u881t
 /5abmlZcGYoL7OwXzlWd48w2GrNMDcF2CsYF99DFdypWO4cAhWtWo3+W3BAWbifgsfTVsb2DbH
 z8w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2021 18:33:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HyBD60hMRz1RtVm
        for <linux-ide@vger.kernel.org>; Sun, 21 Nov 2021 18:33:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637548437; x=1640140438; bh=IoQwi1C4X0DcKL4xjs5tgpaugSqho0bzOCR
        AZrlRMPM=; b=KIgWbkDXAOdd7g7zb0p3emZe8xV91bUG1GLYkPaHxtXgicreUca
        k8MaPejGfDpaevAGwvKq/XM3xkh1FqICUEj+ZlY1ryfYfsWhUljyROJnD4q2R+Vi
        ej1GlEfE40+808Rx8k+X8D87DKzIgLsEwBRUHwsPb9CGsiRBZntmDSU+uhcY/AZh
        BKwZg6uGLDs/eVOYlDY3GQjczSvQfbRvPRpAMkHQqwFYMEA3i6QHbH9mhCUlmKX4
        GRxo34XCI4BExbJ/50h1Q930TvCck4jKNbuMVjNeKAa1/rSz049F9FD1E1Cf+iez
        89mA2hnBqapo++zh74LW+hhEKSf3ZnM1/Lg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DnYgnY2PNZLx for <linux-ide@vger.kernel.org>;
        Sun, 21 Nov 2021 18:33:57 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HyBD375M1z1RtVl;
        Sun, 21 Nov 2021 18:33:55 -0800 (PST)
Message-ID: <08bd2ce6-cee7-d77b-8594-9ff83a471a9b@opensource.wdc.com>
Date:   Mon, 22 Nov 2021 11:33:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH -next V2 1/2] sata_fsl: fix UAF in sata_fsl_port_stop when
 rmmod sata_fsl
Content-Language: en-US
To:     "libaokun (A)" <libaokun1@huawei.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>, axboe@kernel.dk,
        tj@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
References: <20211120033420.3762681-1-libaokun1@huawei.com>
 <20211120033420.3762681-2-libaokun1@huawei.com>
 <4216b1e4-5649-071a-84fc-2440aba9d5a0@gmail.com>
 <4d2712d3-00a1-6220-0a86-8580b2f89d03@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <4d2712d3-00a1-6220-0a86-8580b2f89d03@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/22 11:03, libaokun (A) wrote:
> =E5=9C=A8 2021/11/20 20:01, Sergei Shtylyov =E5=86=99=E9=81=93:
>> Hello!
>>
>> On 20.11.2021 6:34, Baokun Li wrote:
>>
>>> When the `rmmod sata_fsl.ko` command is executed in the PPC64 GNU/Lin=
ux,
>>> a bug is reported:
>>> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =C2=A0 BUG: Unable to handle kernel data access on read at 0x80000800=
805b502c
>>> =C2=A0 Oops: Kernel access of bad area, sig: 11 [#1]
>>> =C2=A0 NIP [c0000000000388a4] .ioread32+0x4/0x20
>>> =C2=A0 LR [80000000000c6034] .sata_fsl_port_stop+0x44/0xe0 [sata_fsl]
>>> =C2=A0 Call Trace:
>>> =C2=A0=C2=A0 .free_irq+0x1c/0x4e0 (unreliable)
>>> =C2=A0=C2=A0 .ata_host_stop+0x74/0xd0 [libata]
>>> =C2=A0=C2=A0 .release_nodes+0x330/0x3f0
>>> =C2=A0=C2=A0 .device_release_driver_internal+0x178/0x2c0
>>> =C2=A0=C2=A0 .driver_detach+0x64/0xd0
>>> =C2=A0=C2=A0 .bus_remove_driver+0x70/0xf0
>>> =C2=A0=C2=A0 .driver_unregister+0x38/0x80
>>> =C2=A0=C2=A0 .platform_driver_unregister+0x14/0x30
>>> =C2=A0=C2=A0 .fsl_sata_driver_exit+0x18/0xa20 [sata_fsl]
>>> =C2=A0=C2=A0 .__se_sys_delete_module+0x1ec/0x2d0
>>> =C2=A0=C2=A0 .system_call_exception+0xfc/0x1f0
>>> =C2=A0=C2=A0 system_call_common+0xf8/0x200
>>> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> The triggering of the BUG is shown in the following stack:
>>>
>>> driver_detach
>>> =C2=A0=C2=A0 device_release_driver_internal
>>> =C2=A0=C2=A0=C2=A0=C2=A0 __device_release_driver
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drv->remove(dev) --> platform_dr=
v_remove/platform_remove
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drv->remove(dev) -->=
 sata_fsl_remove
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iounmap(=
host_priv->hcr_base);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 <---- unmap
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(ho=
st_priv);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 <---- free
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devres_release_all
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release_nodes
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dr->node=
.release(dev, dr->data) --> ata_host_stop
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ap->ops->port_stop(ap) --> sata_fsl_port_stop
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioread32(hcr_base + HCONTROL)=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <---- UAF
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 host->ops->host_stop(host)
>>>
>>> The iounmap(host_priv->hcr_base) and kfree(host_priv) commands should
>>
>> =C2=A0 s/commands/functions/?
>=20
> OK! I'm going to modify this in V3.
>=20
>=20
>>
>>> not be executed in drv->remove. These commands should be executed in
>>> host_stop after port_stop. Therefore, we move these commands to the
>>> new function sata_fsl_host_stop and bind the new function to host_sto=
p
>>> by referring to achi.
>>
>> =C2=A0 You mean AHCI? I don't see where you reference ahci (or achi)..=
.
>=20
> Yes, it's AHCI, I'm sorry for a spelling error here..
>=20
> ahci_platform_ops in drivers/ata/libahci_platform.c
>=20
>=20
>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>
>> =C2=A0 Doesn't this need to go into the stable trees?
>=20
>=20
> I felt it was needed because the bug was triggered in a very simple way=
,
>=20
> although PPC linux is rare these days.
>=20
> And I will add
>=20
> Fixes: faf0b2e5afe7 ("drivers/ata: add support to Freescale 3.0Gbps SAT=
A Controller").

Also add:

Cc: stable@vger.kernel.org


>=20
>>
>>> ---
>>> =C2=A0 drivers/ata/sata_fsl.c | 17 ++++++++++++++---
>>> =C2=A0 1 file changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>>> index e5838b23c9e0..30759fd1c3a2 100644
>>> --- a/drivers/ata/sata_fsl.c
>>> +++ b/drivers/ata/sata_fsl.c
>>> @@ -1430,12 +1430,25 @@ static struct ata_port_operations sata_fsl_op=
s =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pmp_detach =3D sata_fsl_pmp_detach,
>>> =C2=A0 };
>>> =C2=A0 +static void sata_fsl_host_stop(struct ata_host *host)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct sata_fsl_host_priv *host_priv =3D host->pr=
ivate_data;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 iounmap(host_priv->hcr_base);
>>> +=C2=A0=C2=A0=C2=A0 kfree(host_priv);
>>> +}
>>> +
>>> +static struct ata_port_operations sata_fsl_platform_ops =3D {
>>> +=C2=A0=C2=A0=C2=A0 .inherits=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 &sata_fsl_ops,
>>> +=C2=A0=C2=A0=C2=A0 .host_stop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D sata=
_fsl_host_stop,
>>
>> =C2=A0 Why not just add it to the initializer for sata_fsl_ops?
>=20
>=20
> This is the AHCI of the reference.
>=20
> Most ATA drivers add host_stop to to the=C2=A0 initializer for=C2=A0 xx=
x_platform_ops,
>=20
> such as ahci_platform_ops, ahci_brcm_platform_ops, and ahci_imx_ops.
>=20
> It feels like this separates the port operation from the host operation=
,
>=20
> making the hierarchy of the code clearer.
>=20
>=20
>>
>> [...]
>>
>> MBR, Sergei
>> .
>=20
>=20
> Thank you very much for your advice.
>=20
> If there's nothing else to modify, I'll send a patch V3.
>=20
> --=20
> With Best Regards,
> Baokun Li
> .
>=20


--=20
Damien Le Moal
Western Digital Research
