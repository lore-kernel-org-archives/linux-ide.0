Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F4AC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 11:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C97A20733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 11:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iy325ueK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJLwi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:52:38 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49734 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJLwh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 06:52:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210115236euoutp010e54212b47c66a619ad7ece281c71a68~yCE_EStJc0371903719euoutp01E
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 11:52:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210115236euoutp010e54212b47c66a619ad7ece281c71a68~yCE_EStJc0371903719euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581335556;
        bh=5AoAmOzbPq79oPaEtbLrvHPr0Tw0DUo6BQcskrtd+yA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iy325ueKJnJ3uDs9+kqR5UqZC8cKLyFoWtCMtC/WfammGF0tlhauEFRw2OCWD27XQ
         cxIl0AgE4rP5LOlQL8mQsIcoronfERePoKKkEb4/DAxR+Yh/dHhTFMmurcCZP5n+ip
         68hWlt4ArkTCBDmis2ht9vawrzUN5Lhdezn+3mC0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210115236eucas1p1225640851fb33da8854fe3fd3c80708d~yCE9zEvEC1682716827eucas1p1H;
        Mon, 10 Feb 2020 11:52:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 96.5B.61286.404414E5; Mon, 10
        Feb 2020 11:52:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210115236eucas1p1f1145f093604421c4532e27956cc22c0~yCE9hFpP02811228112eucas1p1G;
        Mon, 10 Feb 2020 11:52:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210115236eusmtrp1b9d2e7d11a6333290ed36e645686b6e4~yCE9ghlLB1751617516eusmtrp1L;
        Mon, 10 Feb 2020 11:52:36 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-e1-5e4144048c0c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.9E.08375.404414E5; Mon, 10
        Feb 2020 11:52:36 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210115235eusmtip1843ade324ba9e7aebca8c235e5b1831a~yCE9BDb5L0419104191eusmtip1m;
        Mon, 10 Feb 2020 11:52:35 +0000 (GMT)
Subject: Re: [PATCH 03/46] libata-transport: Whitespace cleanup
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e0577c1e-7b38-1cc6-e684-211747d9ed84@samsung.com>
Date:   Mon, 10 Feb 2020 12:52:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-4-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOV0WF8c4g31d0har7/azWexZNInJ
        4tiOR0wOzB6Xz5Z6bD5d7fF5k1wAcxSXTUpqTmZZapG+XQJXRu+6f2wFLRIVj9evYG5g7BPu
        YuTkkBAwkVjz/TlbFyMXh5DACkaJhUd/sEA4Xxgldh08zQzhfGaU2LTlKwtMy7HediaIxHJG
        ifM7p7FDOG+Bqn6cYAKpEhawl1iw9ypYh4iAksTH9kPsIDazgLXE7MXrwWrYBKwkJravYgSx
        eQXsJC5c/QYWZxFQlWjfd4cZxBYViJD49OAwK0SNoMTJmU/AZnIKGEv8uXyHBWKmuMStJ/OZ
        IGx5ie1v54CdLSHQzC4xZeEiqLNdJN78uMgGYQtLvDq+hR3ClpE4PbmHBaJhHaPE344XUN3b
        GSWWT/4H1WEtcefcLyCbA2iFpsT6XfoQYUeJk+3tzCBhCQE+iRtvBSGO4JOYtG06VJhXoqNN
        CKJaTWLDsg1sMGu7dq5knsCoNAvJa7OQvDMLyTuzEPYuYGRZxSieWlqcm55abJiXWq5XnJhb
        XJqXrpecn7uJEZhGTv87/mkH49dLSYcYBTgYlXh4Hewd4oRYE8uKK3MPMUpwMCuJ8FpKO8YJ
        8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwJgWtJvzVv/G
        RTFTjrVsyTzkHmSdz7Q3kk39FVfIOzY35eaTbA3b3+zr7XkwIe3KqatGCze46PzTjX0wMWH3
        /AmbJ3/YfSVy4wolDqfbSyzmBN08V5Ajlb9bTWQVX0hW/VqO3QEP17m1OMQur8gL+hVsvcAu
        UXoS87UvTsfdRT+JNLhxpAYYzVZiKc5INNRiLipOBAB89AZSHwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7osLo5xBp+2s1usvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6Gb3r/rEVtEhUPF6/grmBsU+4i5GTQ0LAROJYbztTFyMXh5DA
        UkaJ7V8bWbsYOYASMhLH15dB1AhL/LnWxQZR85pRouNkIxNIQljAXmLB3qssILaIgJLEx/ZD
        7CA2s4C1xOzF68FqhATWM0psemcHYrMJWElMbF/FCGLzCthJXLj6DayGRUBVon3fHWYQW1Qg
        QuLwjllQNYISJ2c+AZvPKWAs8efyHRaI+eoSf+ZdYoawxSVuPZnPBGHLS2x/O4d5AqPQLCTt
        s5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbPt2M/NOxgvbQw+xCjA
        wajEw+tg7xAnxJpYVlyZe4hRgoNZSYTXUtoxTog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPz
        gfGcVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB0VzRqeTJ19YH
        f6TfftXJFnp84fF0a/vt89XmbDdlvOJ8Jkz0oZNa0/vaT+diXj07qqRc93XT8bb+M7arV0dn
        H/XuauvY3PrH08i0f17vkc+2f68Iei99s+SXxe6TOwLdn3yYpsC/80SHmOYMB7vbtdpFGp0z
        u3LlFIT6smu1y8Xmr89xV3zVq8RSnJFoqMVcVJwIAI/TYFmvAgAA
X-CMS-MailID: 20200210115236eucas1p1f1145f093604421c4532e27956cc22c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165610eucas1p22186d07c0f52abe7e79a9601332da5cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165610eucas1p22186d07c0f52abe7e79a9601332da5cd
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165610eucas1p22186d07c0f52abe7e79a9601332da5cd@eucas1p2.samsung.com>
        <20200204165547.115220-4-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-transport.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
> index 12a505bb9c5b..4ccfeb85ec66 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -163,7 +163,7 @@ static struct {
>  	{ AC_ERR_INVALID,		"InvalidArg" },
>  	{ AC_ERR_OTHER,			"Unknown" },
>  	{ AC_ERR_NODEV_HINT,		"NoDeviceHint" },
> -	{ AC_ERR_NCQ,		 	"NCQError" }
> +	{ AC_ERR_NCQ,			"NCQError" }
>  };
>  ata_bitfield_name_match(err, ata_err_names)
>  
> @@ -327,7 +327,7 @@ int ata_tport_add(struct device *parent,
>   */
>  static int noop(int x) { return x; }
>  
> -#define ata_link_show_linkspeed(field, format)			        \
> +#define ata_link_show_linkspeed(field, format)				\
>  static ssize_t								\
>  show_ata_link_##field(struct device *dev,				\
>  		      struct device_attribute *attr, char *buf)		\
> @@ -416,7 +416,7 @@ int ata_tlink_add(struct ata_link *link)
>  	dev->release = ata_tlink_release;
>  	if (ata_is_host_link(link))
>  		dev_set_name(dev, "link%d", ap->print_id);
> -        else
> +	else
>  		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
>  
>  	transport_setup_device(dev);
> @@ -484,7 +484,7 @@ show_ata_dev_##field(struct device *dev,				\
>  
>  #define ata_dev_simple_attr(field, format_string, type)	\
>  	ata_dev_show_simple(field, format_string, (type))	\
> -static DEVICE_ATTR(field, S_IRUGO, 			\
> +	static DEVICE_ATTR(field, S_IRUGO,			\
>  		   show_ata_dev_##field, NULL)
>  
>  ata_dev_simple_attr(spdn_cnt, "%d\n", int);
> @@ -502,7 +502,7 @@ static int ata_show_ering(struct ata_ering_entry *ent, void *void_arg)
>  
>  	seconds = div_u64_rem(ent->timestamp, HZ, &rem);
>  	arg->written += sprintf(arg->buf + arg->written,
> -			        "[%5llu.%09lu]", seconds,
> +				"[%5llu.%09lu]", seconds,
>  				rem * NSEC_PER_SEC / HZ);
>  	arg->written += get_ata_err_names(ent->err_mask,
>  					  arg->buf + arg->written);
> @@ -667,7 +667,7 @@ static int ata_tdev_add(struct ata_device *ata_dev)
>  	dev->release = ata_tdev_release;
>  	if (ata_is_host_link(link))
>  		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
> -        else
> +	else
>  		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
>  
>  	transport_setup_device(dev);
> @@ -689,7 +689,7 @@ static int ata_tdev_add(struct ata_device *ata_dev)
>   */
>  
>  #define SETUP_TEMPLATE(attrb, field, perm, test)			\
> -	i->private_##attrb[count] = dev_attr_##field;		       	\
> +	i->private_##attrb[count] = dev_attr_##field;			\
>  	i->private_##attrb[count].attr.mode = perm;			\
>  	i->attrb[count] = &i->private_##attrb[count];			\
>  	if (test)							\
> 
