Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24CFC433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 09:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiKHJd5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiKHJd4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 04:33:56 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D91E13F24
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 01:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667900035; x=1699436035;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=m17mjHsyxYxL43m1OZauNXcZIDrckeHuIeKC+Jorp34=;
  b=DsZFxvcpY8eUbmL+Pc6fOAMIlavc8QNB9oJxmtoMMaPlGtMfh/DfEZF3
   4wxtqFT91EFSMIEcPI6v4pj08/+hn/BnplQdxj+T4VuaLYMcD2YZAGROX
   /DOnNeXB65dq2HrodShYLvTGWIbNmayUgSxrUmS4waCgXL3Qdd/Vts9zU
   pX3cSWjosP8X7ZmWLsA19z8ZCyx6/qAtMa80lLaa5zJ7NSeadHd+xr5Ez
   MaT1rZvMAMbkefFQKgfb3/5HkPAZJXSWHQmP1OAgUNsnXCw6lyaU2H9RM
   HT4v4r6ZagWAGtBtgDXFeiF3UjP2fXrHCDWUemA4zVp3gW36D1tWbO+uD
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="215746582"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 17:33:55 +0800
IronPort-SDR: j4xKcPJhJwlrNcocQz6VqvKyP4ZxDhbf3LnuaOrrG069UFxSznu82mZOfFnzQiYt+50ZXDh0uM
 1eIu9kMc+79KKukOuQbfoPklGrUEJVEAHek3Bnl9lrbk9oB8GQYujTwOaC60fdaKEJOkzBLXAD
 Wg80PNvv9GCRBkVO7XTHAIcU7yZCizdypOrWc958sgVImQ8HChXuL2jevhCOLDvEQJJgaWwDNo
 I7VuyOjl61KPTdJ14eER9gy6OgtHmmu0a5bt0m6GsGm1WYL3Os/dwF8LCVx5xRDbQYolqQQ5WD
 wP0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 00:53:00 -0800
IronPort-SDR: LV7UWzlM2TiUr+GVNTu1aXdYQxOdBkCuciB48CDROYxnJImVvhEWUfPNgczJLwJroVr5OyPxs9
 XXFIEgPe//vrI2IiG3xgnQzFc6KKWBVfiyfquAcD0yc2LEXTnjmb8prTgE8/daai+rz3eQzwHS
 AC87sPTIgugE3H62YU5i7Nvxd/R0zWZc0sPyobqrw41RRQG0sUuDqcK+0IVtNcfkkMTbhfNeqe
 tFh1uiuD+9J0RszA/A1CRiKPyrqXt2QuyQRmVVR+0nTIAqu/2L35ur6QuoxFcTCxEPWVNXtf/1
 1Xw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 01:33:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N62wf3dbYz1RvTp
        for <linux-ide@vger.kernel.org>; Tue,  8 Nov 2022 01:33:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667900034; x=1670492035; bh=m17mjHsyxYxL43m1OZauNXcZIDrckeHuIeK
        C+Jorp34=; b=sH+JojSzlUkrp8oWJE8vFxwR4BS7jk3bpi1/CN6Au7uSqXl5oSI
        pFQtkCTuvoiPln311WVlOBKGjAHnFwNF0Y2edtoQSKAN9Y2Cz+lwIlSySdJqoj5P
        sJ06APqWmj1xGVDiyw+HIbzWDqKnBz0x7NHLRTkVloyTPV5W+49BjLU0v+3UWY+4
        hAJNInk79MBJvaFiJXQsbu104eGLgQn88KCAv7snQGHISCiFl1sz7iTSHk2Esnxx
        upTQYDrU6qanhUKgmIhmRHqHBe13Pq7M4urfieRToy9JFjWkjICOt8cKSWpeC5Zj
        H+stgrAkzbnjoJ92C4S/F26DZ4bMoB4IB+A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MScukb66z-ek for <linux-ide@vger.kernel.org>;
        Tue,  8 Nov 2022 01:33:54 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N62wd5Y53z1RvLy;
        Tue,  8 Nov 2022 01:33:53 -0800 (PST)
Message-ID: <19fc6795-9322-6228-abc5-45a70d2705ee@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 18:33:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 4/4] ata: libata-transport: fix error handling in
 ata_tdev_add()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
References: <20221108075209.2434888-1-yangyingliang@huawei.com>
 <20221108075209.2434888-5-yangyingliang@huawei.com>
 <ad7f4ad1-cded-8a09-6a7e-da6b91ee04b2@opensource.wdc.com>
 <e519e85c-1253-6c09-ddab-bc13a4634aba@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e519e85c-1253-6c09-ddab-bc13a4634aba@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/8/22 18:27, Yang Yingliang wrote:
> Hi,
>=20
> On 2022/11/8 16:03, Damien Le Moal wrote:
>> On 11/8/22 16:52, Yang Yingliang wrote:
>>> In ata_tdev_add(), the return value of transport_add_device() is not
>>> checked. As a result, another error after that function call leads to
>>> a kernel crash (null-ptr-deref) because transport_remove_device() is
>>> called to remove a device that was not added.
>> This was the error pattern for the previous 2 cases, but not for this
>> one. For this case, transport_configure_device() would be called for a
> Did you mean transport_remove_device() ?
>> device that was not added, no ? so where does the backtrace below come
>> from ? It does not correspond to the code this patch is changing.
> Yes, it's correspond, ata_tdev_delete() is inlined, so it doesn't show
> in the call traces.

I meant to say that the commit message explanation does not match at all
the cod echange. Totally unrelated explanation and functions mentioned.
Please fix that first and simply put the kdump trace you see if there is
an issue when calling transport_configure_device() after
transport_add_device() failed.

>=20
> I make ata_tdev_delete() noinline and reproduced it again,
> ata_tdev_delete()
> is showed in the call trace:
>=20
> [=C2=A0 140.120952][T13603] Call trace:
> [=C2=A0 140.124359][T13603]=C2=A0 device_del+0x48/0x3a0
> [=C2=A0 140.128713][T13603] attribute_container_class_device_del+0x28/0=
x40
> [=C2=A0 140.135226][T13603]=C2=A0 transport_remove_classdev+0x60/0x7c
> [=C2=A0 140.140783][T13603] attribute_container_device_trigger+0x118/0x=
120
> [=C2=A0 140.147289][T13603]=C2=A0 transport_remove_device+0x20/0x30
> [=C2=A0 140.152665][T13603]=C2=A0 ata_tdev_delete+0x24/0x50 [libata]
> [=C2=A0 140.158152][T13603]=C2=A0 ata_tlink_delete+0x40/0xa0 [libata]
> [=C2=A0 140.163724][T13603]=C2=A0 ata_tport_delete+0x2c/0x60 [libata]
> [=C2=A0 140.169294][T13603]=C2=A0 ata_port_detach+0x148/0x1b0 [libata]
> [=C2=A0 140.174951][T13603]=C2=A0 ata_pci_remove_one+0x50/0x80 [libata]
> [=C2=A0 140.180689][T13603]=C2=A0 ahci_remove_one+0x4c/0x8c [ahci]
>=20
> Thanks,
> Yang
>>
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 00000000000000d0
>>> CPU: 61 PID: 13969 Comm: rmmod Kdump: loaded Tainted: G=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.1.0-rc3+ #1=
3
>>> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>>> pc : device_del+0x48/0x39c
>>> lr : device_del+0x44/0x39c
>>> Call trace:
>>> =C2=A0 device_del+0x48/0x39c
>>> =C2=A0 attribute_container_class_device_del+0x28/0x40
>>> =C2=A0 transport_remove_classdev+0x60/0x7c
>>> =C2=A0 attribute_container_device_trigger+0x118/0x120
>>> =C2=A0 transport_remove_device+0x20/0x30
>>> =C2=A0 ata_tlink_delete+0x4c/0xb0 [libata]
>>> =C2=A0 ata_tport_delete+0x2c/0x60 [libata]
>>> =C2=A0 ata_port_detach+0x148/0x1b0 [libata]
>>> =C2=A0 ata_pci_remove_one+0x50/0x80 [libata]
>>> =C2=A0 ahci_remove_one+0x4c/0x8c [ahci]
>>>
>>> Fix this by checking and handling return value of transport_add_devic=
e()
>>> in ata_tdev_add().
>>>
>>> Fixes: d9027470b886 ("[libata] Add ATA transport class")
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>> =C2=A0 drivers/ata/libata-transport.c | 8 +++++++-
>>> =C2=A0 1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-transport.c
>>> b/drivers/ata/libata-transport.c
>>> index aac9336e8153..e4fb9d1b9b39 100644
>>> --- a/drivers/ata/libata-transport.c
>>> +++ b/drivers/ata/libata-transport.c
>>> @@ -713,7 +713,13 @@ static int ata_tdev_add(struct ata_device *ata_d=
ev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 transport_add_device(dev);
>>> +=C2=A0=C2=A0=C2=A0 error =3D transport_add_device(dev);
>>> +=C2=A0=C2=A0=C2=A0 if (error) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_del(dev);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ata_tdev_free(ata_dev);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return error;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transport_configure_device(dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }

--=20
Damien Le Moal
Western Digital Research

