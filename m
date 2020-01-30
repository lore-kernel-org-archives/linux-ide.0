Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7EFC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486A52082E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fgl6IPRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgA3MCm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:02:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49636 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgA3MCm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 07:02:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130120241euoutp018bb52d5c037f0d060a1f4b378c6e1e0c~uqHn24w1Q2860328603euoutp01n
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 12:02:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130120241euoutp018bb52d5c037f0d060a1f4b378c6e1e0c~uqHn24w1Q2860328603euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580385761;
        bh=ws7/H46xGSpbOydIzGtQJ4twUubZUi3kSY0z1ohGGeU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Fgl6IPRLD3afYZMBW8Ppg8hrVTIueXceHp4xnY1meZ+mfwDjdXF+z0aNB6sU+OqKe
         yKSpwMJQXLd+Ey+7YN3bvJ8y0wGfpAFAo/Cmqyh4SSF8oCubJOtJHNIqzHfSbiFfcs
         5n7WG/hfIH/wekY5UlTeW6NDgJ0p4hRgipjGv2Tk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130120240eucas1p1fb4aa79a00327babccff03cf724a3f8a~uqHnxrExo2500625006eucas1p1h;
        Thu, 30 Jan 2020 12:02:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A6.F3.61286.0E5C23E5; Thu, 30
        Jan 2020 12:02:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130120240eucas1p299a48c21abd0822f3a78efc94fe4b288~uqHneLKw02892128921eucas1p2O;
        Thu, 30 Jan 2020 12:02:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130120240eusmtrp1c5593ef1bd07cfcd399bb8f14d123e9a~uqHndkWPg2821928219eusmtrp1u;
        Thu, 30 Jan 2020 12:02:40 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-cd-5e32c5e0bea3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.28.07950.0E5C23E5; Thu, 30
        Jan 2020 12:02:40 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130120240eusmtip1c902f9cd9400d55e6dc80593d6b7c86d~uqHnKLzD52876628766eusmtip1f;
        Thu, 30 Jan 2020 12:02:40 +0000 (GMT)
Subject: Re: [PATCH 23/24] libata: drop BPRINTK()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <430f26f7-375b-53cd-75e0-0e581ef856b4@samsung.com>
Date:   Thu, 30 Jan 2020 13:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-35-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7oPjhrFGez+Z26x+m4/m8WCN3vZ
        LPYsmsRkcWzHIyYHFo/LZ0s91m+5yuKx+XS1x+dNcgEsUVw2Kak5mWWpRfp2CVwZW7c9Yi/o
        5qhY0rKcrYHxCFsXIyeHhICJxN4z01hBbCGBFYwSGxoruhi5gOwvjBLdTzuZIZzPjBKduzcz
        wXQ0v1nCBJFYziix6E0bO0T7W0aJ44vEQWxhAUOJtk9nwBpEBJQkPrYfAqthFoiTaLpyF8xm
        E7CSmNi+ihHE5hWwk1j19Q1YPYuAqsS7J1/A4qICERKfHhxmhagRlDg58wkLiM0pYCzxfecn
        VoiZ4hK3nsxngrDlJba/ncMMcWg/u0TvVncI20Xi77KHjBC2sMSr41vYIWwZidOTe1hAnpEQ
        WMco8bfjBTOEs51RYvnkf9BAspa4c+4XkM0BtEFTYv0ufYiwo8TEhxPYQcISAnwSN94KQtzA
        JzFp23RmiDCvREebEES1msSGZRvYYNZ27VzJPIFRaRaSz2Yh+WYWkm9mIexdwMiyilE8tbQ4
        Nz212DAvtVyvODG3uDQvXS85P3cTIzCpnP53/NMOxq+Xkg4xCnAwKvHwamwwihNiTSwrrsw9
        xCjBwawkwivqahgnxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwT
        B6dUA+OcTTtN102tmV3C/UXjZGvu5A06y2fcUXgwV/9XRMwih8i0PdEJx4pbwzqu3d4/OTby
        u9mfyxrsRuLanit613HX9X67Wb39i+w/u5nBJp93Hj343s38lqoL07QvK6x055osaExMdFKV
        +74jVLTjvP/M7fmS9WVTpI/12Wtsa6pTtzuodmXWjllKLMUZiYZazEXFiQA2LyJ0JgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7oPjhrFGSxqkLdYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MrdsesRd0c1QsaVnO1sB4hK2LkZNDQsBE
        ovnNEqYuRi4OIYGljBLbP89j6WLkAErISBxfXwZRIyzx51oXWL2QwGtGiX19rCC2sIChRNun
        M0wgtoiAksTH9kPsIDazQJzEv77dUDPXAc3cvQysmU3ASmJi+ypGEJtXwE5i1dc3YM0sAqoS
        7558AYuLCkRIHN4xC6pGUOLkzCcsIDangLHE952fWCEWqEv8mXeJGcIWl7j1ZD4ThC0vsf3t
        HOYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG0bZjP7fs
        YOx6F3yIUYCDUYmHV2ODUZwQa2JZcWXuIUYJDmYlEV5RV8M4Id6UxMqq1KL8+KLSnNTiQ4ym
        QM9NZJYSTc4HxnheSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG
        Lm5us0rbOyqvpsk+bVVP+vjiyatXoWHBl/IPHdJ5ZvkuL7LfZ/7FV0psbmLTPJX8PsxJXpvI
        /sFuhvyZ7XUXWmb0X5RLEEmctHv54/afMn8ds+7MDXDi/T4/5MSyAx+aZfQ8EyZPvK4ixXp9
        qQ9f7KWzjVvfKLZ9rg5aGiIVyXpklomCSOUsJZbijERDLeai4kQAaPp2iLkCAAA=
X-CMS-MailID: 20200130120240eucas1p299a48c21abd0822f3a78efc94fe4b288
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104810epcas2p164ab666a276177a13a806be75ea7e7cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104810epcas2p164ab666a276177a13a806be75ea7e7cd
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104810epcas2p164ab666a276177a13a806be75ea7e7cd@epcas2p1.samsung.com>
        <20181213104716.31930-35-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> No users, drop it.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This patch is obviously correct and is independent of all other
patches in the series so it should be moved at the beginning of
the patchset (or simply applied now).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  include/linux/libata.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 4b5b174994b5..2f992b6ad626 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -66,8 +66,6 @@
>  #define VPRINTK(fmt, args...)
>  #endif	/* ATA_VERBOSE_DEBUG */
>  
> -#define BPRINTK(fmt, args...) if (ap->flags & ATA_FLAG_DEBUGMSG) printk(KERN_ERR "%s: " fmt, __func__, ## args)
> -
>  #define ata_print_version_once(dev, version)			\
>  ({								\
>  	static bool __print_once;				\
