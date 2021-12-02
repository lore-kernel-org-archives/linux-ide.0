Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1635CC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  2 Dec 2021 04:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbhLBEYI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:24:08 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53179 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355495AbhLBEWl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Dec 2021 23:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638418756; x=1669954756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N8aM/Sb3HlK/fVLgx/vco0JFJ9ktzDZRzBTzIyPp2As=;
  b=RKl4zh6kgsLyTOCNC7KnW/mvK63+P7VLN5+USmBK/T1VvDnEW5P6CnB7
   hTN3XfpTKpUMdvyLm0JnVUI8QisrJjDn8SVFbhqgUWEFqDo+l925iJrNw
   Pl4mIF4yg2vA3Vp8wWfsDT9wNaJtrTAozqMHC1MBbZ7hIzm3buU6PVQuk
   LV63k+L40NOrP+yWQW8zvlhXrJIWFzurLYgdAmM23Jss6U8InhN3ddtGS
   bfe6wDj5BuMlBVsdVBAXlXH1Tt4DoKH3re2493FmFXoXtoW/C8lxq0EZ+
   lhB5bVJP4hslc+au23GbOrXVGzXiL2mAb/6Of96l50c9Yc2WsvhAH8KMp
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="187253083"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 12:19:07 +0800
IronPort-SDR: M7ugOsqV7nMCsCruAw9lr3fOLBHNpct9T+MsiPUiMrGQyWhm1QalT2xvoGrJRY1512/Euyg3/0
 PC2b8MG4JsdYmQL+osJV7bzkOopee0PlpuMlHRrNhHDnkGZ/oygsYtHYHGtzog4uoAQfOM33yW
 86RNtAxq/T9Jb3J/4I/+ZT+hayr5Ei+gq44eiUd3tiMVLQOvKWAmD1fDPOaIFGluA7bpcy+QlD
 /gjbK3yUz9W1gX7qz5q+SIeJ17KxjwqvSVIduC4RYmGRCelz+L59tIFUxaeeIt/tEygixJokXm
 QvM/SedvCaoicPSTnSruluol
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 19:53:52 -0800
IronPort-SDR: sAHyTfEu6XdEbxW7AmBuZxScCEqcJTOtD1ZKcmfZYuMVeTymXksJ9g1Cs+r5fm1tdJvjFE+ty7
 qHa9OIdFLA05IDt4iGi1JVBy/jPGmU8HSpzhg2X2CXoA4k4rv9LzmunlifU12QKC++6AK2U4+F
 x7D2CBKB6lp6JT1C+p87QsugtoZyE7TvPm+Hv7sx7uJCTocWyKkWs7M/jW8mQbCYPc1ctRCwz4
 7x0CssHekUxhd5+VIoKf3G7+LeX8plwthPE39K29jAlQCxkzw57KDjn77p3XNCTh0DImX5lWav
 L2A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:19:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4N4r1dBJz1RtVm
        for <linux-ide@vger.kernel.org>; Wed,  1 Dec 2021 20:19:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638418747; x=1641010748; bh=N8aM/Sb3HlK/fVLgx/vco0JFJ9ktzDZRzBT
        zIyPp2As=; b=O6KyyhgBHKfURETK18F1VWYvQ6LVnU/ltu+7Bthjx5le3b8TC1k
        qKFoPmK1A6VIkBwtavNYABvcAs8lK0m+ozO9aGmf+NaPcvR7IaXSf/NyuG848Q9T
        X5/SJuPDlWodmLbu1FiPUIWNX7QCSAq+eN9D+OeNW5jFfuqIBsJR90aztgSDbLXe
        WPbnPTgZWawknqpa0l2B880y84j6Nx4M1xcMO063Ecw5fki3e47ZCBUvvEYADzrd
        3DwGJXFMLfC7MQ3uk9RBKKaEh5iwHEKswqIhzK165fBg5yWWMtZIKYANmB7DQYVD
        fpdolJdwV2dFb7IdM/ADviMwY9e2mzGYCuQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PyN5lugurf9q for <linux-ide@vger.kernel.org>;
        Wed,  1 Dec 2021 20:19:07 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4N4q0J71z1RtVl;
        Wed,  1 Dec 2021 20:19:06 -0800 (PST)
Message-ID: <f74c3567-64ff-4bce-89f5-192a1ae9fc45@opensource.wdc.com>
Date:   Thu, 2 Dec 2021 13:19:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] ata: replace snprintf in show functions with sysfs_emit
Content-Language: en-US
To:     davidcomponentone@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <2fbce7707eff3bfebf38138899e900ee8c619931.1638155918.git.yang.guang5@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <2fbce7707eff3bfebf38138899e900ee8c619931.1638155918.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/30 9:04, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
>=20
> coccinelle report=EF=BC=9A
> ./drivers/ata/libata-sata.c:830:8-16:=20
> WARNING: use scnprintf or sprintf
>=20
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>  drivers/ata/libata-sata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 5b78e86e3459..b9c77885b872 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -827,7 +827,7 @@ static ssize_t ata_scsi_lpm_show(struct device *dev=
,
>  	if (ap->target_lpm_policy >=3D ARRAY_SIZE(ata_lpm_policy_names))
>  		return -EINVAL;
> =20
> -	return snprintf(buf, PAGE_SIZE, "%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			ata_lpm_policy_names[ap->target_lpm_policy]);
>  }
>  DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
>=20

Applied to for-5.16-fixes. Thanks !

--=20
Damien Le Moal
Western Digital Research
