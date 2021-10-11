Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F28C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 09:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C2360EB6
	for <linux-ide@archiver.kernel.org>; Mon, 11 Oct 2021 09:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhJKJUn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Oct 2021 05:20:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61512 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbhJKJUm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2021 05:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633943923; x=1665479923;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=FbFHYwrXbdhNrn3GLaC+ET7wHy/T6+E+T7IsTSv1KIw=;
  b=dNkuHYF4KeeZ/b9c0XMQIFOhNH9jVAvVgcHt1tVHMLjzorO9mXMOL5yi
   ehHIiqFCIpEyAzbE1ZTQoMUvfMr5zc4KDwowQuApkvrkSX0Jah8AvQ88o
   xRTiZQxZc0o7biE1+doocwDjSa5Xj25MTDxPVAGL1cEn/0lrus3nr3EkF
   vdgcQKR7diiLSCipU79dU3J3YTW5ogwaj3GiJqmx2fR6/TBhHQA5YpRdx
   dxV8Fd/v5fxb+dbz8XNiSsi1O0gs7cya0ZCYdkuYmkVdbD6P1czrZ/NPe
   3ASwVaBN6+LKE/3ciFeHZv3zQK21/nljQIbXqDi/iv2pWtVglf3V/sT/m
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="286318264"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 17:18:42 +0800
IronPort-SDR: XhqfXSMTp0+nK7eFrV4tA3U2w7qtxhZ4iLLjCnNam9XCiqhgZeC3/1jQrOx6/cOQSJrylusNFP
 7WVmaHALa6CPsPWu6jPxteti8TJrl1Duzk77JHBYxO8JmGXNPqfKtFpOGGtXcZN9umQpLI00Pi
 s8YvuoZYPJ7mi/ymSsUYQOT78odA13/pGrHGAlKjySC5tVM2wpUkZX3dXwhly7FXwxc/xwejrw
 QlsOMteS0DL35BycWQ0Kl81K+QPuKBkQw08Jzkj454RXpyWJ7ZHvarg1Po2vzjsVOPj0v/wJIJ
 5F98iF7c3kO/w5zzYUcI+e6K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 01:54:31 -0700
IronPort-SDR: g7m0GWBh9vzzHYhKolBA0Hmd3nEaysEtDpBuP1us3hwedXkvsUDJ4tYS8L6wGkRY7sDYlb8QiR
 daQWQY/TSplo84N8Mwjeiug9h+DO/BKJBO2AmoshIu+dkZKQpSk4Rntq8oGWXs6NHnhJ+GRKaY
 UiRuqs+ktrTWh3gB6jLTdlOMpZnLC4xu8cc5aHJ0+jZSM9Ft+pK15HbUzkaDj5g5Ja1/01dFLp
 vUiZIQ+4dXlghqVEtk1rMpZmscGhft0/H7sl9PZJdSBiWJ6OdH7VmX9WGQiTlHeuDgpAsPqmDF
 zJE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 02:18:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HSYBV2r9Cz1RvTm
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2021 02:18:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1633943922; x=1636535923; bh=FbFHYwrXbdhNrn3GLaC+ET7wHy/T6+E+T7I
        sTSv1KIw=; b=Opgl1XI8vHd3ESuKijlUQ3dU5TJLHsDt+fUMHE3917ibSx+ic+3
        QHTQNn4k8nCHI6KWfyminJwbFKDisn84TF7d6qT4Ow8l194cB9uSRSQLJPS3k/IQ
        Waa1jxoEmGCUGN/Xp2IYR1PvAUsyYPuBHZFSqnIPTsR/3R9ZqPB030zyMyojB5c8
        ZoFLDS87aMv3eKAldOJ8WL0W38zMhLJRXEfof7mVH0KriXa1VLwIKRYq21g/FjZ4
        Jqwrme1H1bvb6QYJbPHvpSVcG+Rr9crF3QUKhEJhAAqCY8gv2dB2AwVy5qfYqBAc
        Hgd1ihj3gYRaY0qARk6vU8UJFssJ5tLvVVw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wzmofvhvrQh5 for <linux-ide@vger.kernel.org>;
        Mon, 11 Oct 2021 02:18:42 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HSYBT4k0vz1RvTg;
        Mon, 11 Oct 2021 02:18:41 -0700 (PDT)
Message-ID: <6edc3f6d-8dd8-e0d9-0f20-509f08691205@opensource.wdc.com>
Date:   Mon, 11 Oct 2021 18:18:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] Add AHCI support for (noname) PCIe sata cards based on
 ASM1062+JBM575 cards, usually 10 SATA ports or more. DeviceID: 0624 (rev 01)
Content-Language: en-US
To:     =?UTF-8?B?SXN0dsOhbiBQb25ncsOhY3o=?= <pongracz.istvan@gmail.com>,
        linux-ide@vger.kernel.org
References: <20211011085936.4307-1-pongracz.istvan@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211011085936.4307-1-pongracz.istvan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/10/11 17:59, Istv=C3=A1n Pongr=C3=A1cz wrote:

Your commit title is too lon. Shorten it to:

Add AHCI support for ASM1062+JBM575 cards

And then add a commit message with the details (PCIe card, usually 10 por=
ts,
etc. Whatever information is relevant to describe the hardware.

Also please sign your patch (Add a Signed-off-by: xxx tag). You can do th=
is
automatically by doing a "git commit -s" when creating your patch.

> ---
>  drivers/ata/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 186cbf90c8ea..f8199f021ed4 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -592,6 +592,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D=
 {
>  	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASMedia Technology=
 Inc. Device 0624 (rev 01) based PCIe port multiplier cards (ex. 10 ports=
 card with 1 x ASM1062 + 2 x JMB575 */

Line too long. Please shorten the comment to /* ASM1062+JMB575 */

> =20
>  	/*
>  	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
>=20


--=20
Damien Le Moal
Western Digital Research
