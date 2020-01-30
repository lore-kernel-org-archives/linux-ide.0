Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E959C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EE72083E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PBwkucyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgA3Kme (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:42:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48055 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgA3Kmd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:42:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130104231euoutp019b13c751ac5b7ba25e16f05adc5901d3~upBow8CHz2602626026euoutp01H
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:42:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130104231euoutp019b13c751ac5b7ba25e16f05adc5901d3~upBow8CHz2602626026euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580380951;
        bh=2NixwPiGawA8a2hN98ptH9pvFVA7xCYlWB1/xvHt6K4=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=PBwkucyqsoeNHp2UUq64PW11Hn+A3KqTsnNIEnNd36NWMBAKQGmHog+CoDas6FdNi
         2XMAiVrtDaX+jShyknYwMr4MJ1YvnTqHHeRokax/UghvzK1drAvd97nbVmHSjb4K0f
         73RRI6muKQipsBmPjsBRr2IIDM5oOk2b6IR3c48k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130104231eucas1p261d81743e9e8ec9c5b4eca00427c611c~upBoqLgDP0619506195eucas1p2O;
        Thu, 30 Jan 2020 10:42:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.88.60698.713B23E5; Thu, 30
        Jan 2020 10:42:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130104231eucas1p1b34e8d84a7ea4fc767a599123bfd6101~upBoTnOc-2487024870eucas1p1j;
        Thu, 30 Jan 2020 10:42:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130104231eusmtrp1444bb8ad5e8cf6b600ac1dec465cabec~upBoTETbE0718707187eusmtrp1A;
        Thu, 30 Jan 2020 10:42:31 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-a7-5e32b317c42c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8A.EC.07950.713B23E5; Thu, 30
        Jan 2020 10:42:31 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130104230eusmtip12fa2f16b08cf43e7739573cf0fd31ba1~upBoASSRV0842508425eusmtip1V;
        Thu, 30 Jan 2020 10:42:30 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 01/24] libata: move ata_{port,link,dev}_dbg to dynamic
 debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>, Tejun Heo <tj@kernel.org>
Message-ID: <78a7d597-7d44-6b64-ed60-e7da74df692c@samsung.com>
Date:   Thu, 30 Jan 2020 11:42:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-2-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djP87rim43iDOZfkLdYfbefzWLBm71s
        FnsWTWKyOLbjEZPFr+VHGR1YPS6fLfXYtKqTzWP9lqssHptPV3t83iQXwBrFZZOSmpNZllqk
        b5fAlXF11Rb2greSFf8eb2FtYOwW7WLk5JAQMJHY+OcBSxcjF4eQwApGif03ZzJBOF8YJZr6
        rjFDOJ8ZJa6/Xs8M07JtfRtUy3JGiVnX1kM5bxklDj+6yw5SxSZgJTGxfRUjiC0sECbx6com
        JhBbREBJ4mP7IbAaZoFKiTOdk8FsXgE7ic8z5oFtYBFQleg90cMCYosKREh8enCYFaJGUOLk
        zCdgcU4BI4mNTy8yQcwRl7j1ZD6ULS+x/e0csLMlBBaxS/TMusgKcbaLRNOiXhYIW1ji1fEt
        7BC2jMTpyT0sEA3rGCX+dryA6t7OKLF88j82iCpriTvnfgHZHEArNCXW79KHCDtKfJj1Eyws
        IcAnceOtIMQRfBKTtk1nhgjzSnS0CUFUq0lsWLaBDWZt186VzBMYlWYheW0WkndmIXlnFsLe
        BYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQLTzel/x7/uYNz3J+kQowAHoxIPr8YG
        ozgh1sSy4srcQ4wSHMxKIryiroZxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJ
        zU5NLUgtgskycXBKNTCWXTHa3jLx4sz15gYyqb/iT9WlTlt5xv8LM8fzwp7fGVtL5MtnMsba
        8H+tMMvpyTd6NGeC5c6YWPYz6+/dvPGKXzdwyd1Je4IPnDtulPI1+9psC63ruxvidb79sn/v
        I9RYEdKbcjf86ZbNvW/Xs71yOH2ju1uhW0l0008mid9P3D5vPBT48utvJZbijERDLeai4kQA
        pOOF9TMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7rim43iDI43slqsvtvPZrHgzV42
        iz2LJjFZHNvxiMni1/KjjA6sHpfPlnpsWtXJ5rF+y1UWj82nqz0+b5ILYI3SsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7i6agt7wVvJin+Pt7A2
        MHaLdjFyckgImEhsW9/GAmILCSxllHjbKNXFyAEUl5E4vr4MokRY4s+1LrYuRi6gkteMEvMu
        PmEGSbAJWElMbF/FCGILC4RJfLqyiQnEFhFQkvjYfogdxGYWqJS4+7+XGaJ5LaPE1IZ/YAle
        ATuJzzPmgQ1iEVCV6D3RA3aEqECExOEdsxghagQlTs58AhbnFDCS2Pj0IhPEUHWJP/MuMUPY
        4hK3nsyHistLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ
        +bmbGIGxte3Yzy07GLveBR9iFOBgVOLh1dhgFCfEmlhWXJl7iFGCg1lJhFfU1TBOiDclsbIq
        tSg/vqg0J7X4EKMp0HMTmaVEk/OBcZ9XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1
        tSC1CKaPiYNTqoHR9rPQY8YT8qcDWTd/XhnS8uCxnkracdH6mdc6n+9v05bukFikdbb+3xZ5
        lS/vnx72DpeK+23SVC8z6aHxnJ+yN5Rz9HruSvxLfjs96+ODOUmpXsJzlNTP/F6yQ/+iTq2+
        drLGi8WxlsG30xfevnBi6WZH8WevV4up7eQx1/h/935Mak5JfuA5JZbijERDLeai4kQA38Xc
        5cMCAAA=
X-CMS-MailID: 20200130104231eucas1p1b34e8d84a7ea4fc767a599123bfd6101
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104740epcas3p430cad94d8c4c4f58f1d6595ea1eff438
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104740epcas3p430cad94d8c4c4f58f1d6595ea1eff438
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104740epcas3p430cad94d8c4c4f58f1d6595ea1eff438@epcas3p4.samsung.com>
        <20181213104716.31930-2-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


[ added Tejun to Cc: ]

On 12/13/18 11:46 AM, Hannes Reinecke wrote:
> Use dev_dbg() for ata_{port,link,dev}_dbg to allow for selective
> debugging during runtime.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  include/linux/libata.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 38c95d66ab12..7b2f039d3d21 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1436,7 +1436,7 @@ void ata_dev_printk(const struct ata_device *dev, const char *level,
>  #define ata_port_info(ap, fmt, ...)				\
>  	ata_port_printk(ap, KERN_INFO, fmt, ##__VA_ARGS__)
>  #define ata_port_dbg(ap, fmt, ...)				\
> -	ata_port_printk(ap, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	dev_dbg(&ap->tdev, fmt, ##__VA_ARGS__)
>  
>  #define ata_link_err(link, fmt, ...)				\
>  	ata_link_printk(link, KERN_ERR, fmt, ##__VA_ARGS__)
> @@ -1447,7 +1447,7 @@ void ata_dev_printk(const struct ata_device *dev, const char *level,
>  #define ata_link_info(link, fmt, ...)				\
>  	ata_link_printk(link, KERN_INFO, fmt, ##__VA_ARGS__)
>  #define ata_link_dbg(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	dev_dbg(&link->tdev, fmt, ##__VA_ARGS__)
>  
>  #define ata_dev_err(dev, fmt, ...)				\
>  	ata_dev_printk(dev, KERN_ERR, fmt, ##__VA_ARGS__)
> @@ -1458,7 +1458,7 @@ void ata_dev_printk(const struct ata_device *dev, const char *level,
>  #define ata_dev_info(dev, fmt, ...)				\
>  	ata_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
>  #define ata_dev_dbg(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	dev_dbg(&dev->tdev, fmt, ##__VA_ARGS__)

While you are at it please remove ata_{port,link,dev}_printk()
altogether.

[ Since code in libata-transport.c sets valid device names using
  dev_set_name() we can simply use generic dev_*() helpers. ]

Please also note that ata_{link,dev}_printk() differs slightly in PMP
handling for links and devices names from code in libata-transport.c:

void ata_link_printk(const struct ata_link *link, const char *level,
		     const char *fmt, ...)
...
	if (sata_pmp_attached(link->ap) || link->ap->slave_link)
		printk("%sata%u.%02u: %pV",
		       level, link->ap->print_id, link->pmp, &vaf);
	else
		printk("%sata%u: %pV",
		       level, link->ap->print_id, &vaf);
...

int ata_tlink_add(struct ata_link *link)
...
	if (ata_is_host_link(link))
		dev_set_name(dev, "link%d", ap->print_id);
        else
		dev_set_name(dev, "link%d.%d", ap->print_id, link->pmp);
...


void ata_dev_printk(const struct ata_device *dev, const char *level,
		    const char *fmt, ...)
...
	printk("%sata%u.%02u: %pV",
	       level, dev->link->ap->print_id, dev->link->pmp + dev->devno,
	       &vaf);
...

static int ata_tdev_add(struct ata_device *ata_dev)
...
	if (ata_is_host_link(link))
		dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
        else
		dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
...

I assume that the code in libata-transport.c is the preferred one but
I would like Jens or Tejun to confirm this.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
