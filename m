Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9448FC04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A6F20838
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gnYNwoVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGOW2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:22:28 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57781 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBGOW1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:22:27 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142226euoutp01e3d94507f1bc3731c926079700b144fb~xJL71C3QP1730617306euoutp01r
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:22:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142226euoutp01e3d94507f1bc3731c926079700b144fb~xJL71C3QP1730617306euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085346;
        bh=d/qJoF6h916Bi0/NAHFCErcxc3bbUAl5eTfcn/hK5Wc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gnYNwoVlr0br4GPU4/DO1KEbiDMJ1MHeA12PvoRvFPbU11h5et/8YhFoy5pLZ/bkZ
         AL3Ja9LurWWMY2OqIeV2S7uN0DqeIdDe4HpJbccbWFPDsqqdO8GsVlmXeWXziS9bes
         EeVjhbwNB0+WltW3AOdHEGGByOFUJMvmVIRuYuOY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142226eucas1p1e1b9f8ac253eb327681aa3935dea541f~xJL7qMGEW2372923729eucas1p1H;
        Fri,  7 Feb 2020 14:22:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 68.18.60698.2A27D3E5; Fri,  7
        Feb 2020 14:22:26 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142226eucas1p2ff5b2973e7acce8e8e5ddd594c18babf~xJL7S_QM43054130541eucas1p2P;
        Fri,  7 Feb 2020 14:22:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142226eusmtrp184d28d0ee8b87acf3536ca8d03c0899a~xJL7M3-JA0157001570eusmtrp19;
        Fri,  7 Feb 2020 14:22:26 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-1a-5e3d72a27975
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.35.07950.1A27D3E5; Fri,  7
        Feb 2020 14:22:26 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142225eusmtip247b15c67784e84cbba848763e895487c~xJL60Gm8r2409824098eusmtip2R;
        Fri,  7 Feb 2020 14:22:25 +0000 (GMT)
Subject: Re: [PATCH 12/28] ata: start separating SATA specific code from
 libata-core.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <42bcafbc-d586-da98-b093-305c25ecefda@samsung.com>
Date:   Fri, 7 Feb 2020 15:22:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200129172614.GH12616@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87qLimzjDE6eVrBYfbefzeLZrb1M
        FqcnLGKyOLbjEZPF5V1z2Czmtk5nd2Dz2DnrLrvH5hVaHpfPlnocOtzB6PF5k1wAaxSXTUpq
        TmZZapG+XQJXxvPeT8wFqzgr+qe9ZmpgPMDexcjBISFgInF1ZWEXIyeHkMAKRon/qyK6GLmA
        7C+MEtM2vWOEcD4zSvzrn8cCUgXS8OHYWSaIxHJGiX177kJVvWWU2DZjIliVsECExI/FJ1lB
        bBEBTYlby9uZQYqYBTYwSnyetIURJMEmYCUxsX0VmM0rYCex5cg1sAYWARWJ858es4PYokCD
        Pj04zApRIyhxcuYTsAWcAsYSn58cBbOZBcQlbj2ZzwRhy0tsfzsHbJmEwDJ2iYWnp0Pd7SJx
        vPcCO4QtLPHq+BYoW0bi9OQeFoiGdYwSfzteQHVvZ5RYPvkfG0SVtcSdc7/YQEHGDPTP+l36
        EGFHiff9rYyQkOSTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SQ2LNvABrO2a+dK5gmMSrOQvDYL
        yTuzkLwzC2HvAkaWVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIFp5/S/4193MO77k3SI
        UYCDUYmHN8HRJk6INbGsuDL3EKMEB7OSCG+fqm2cEG9KYmVValF+fFFpTmrxIUZpDhYlcV7j
        RS9jhQTSE0tSs1NTC1KLYLJMHJxSDYy6Lq+dvomednJsLErYyMcbOouFs++htUOhes7TeU6W
        Ew5InP1kanpZb/LHh8vLTV8J/VtSLTI3r8FFnM3k0HEZw/jUnX6TVq3WtQrdyH46ePoyKYM5
        t9mnLVa1+/LPL1HfP/eIe7fUNN0k+zs96s+t+p35N6X9YIlrOroy98e2xQF9DqUTGJRYijMS
        DbWYi4oTAbwmooY3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7qLimzjDObsYrRYfbefzeLZrb1M
        FqcnLGKyOLbjEZPF5V1z2Czmtk5nd2Dz2DnrLrvH5hVaHpfPlnocOtzB6PF5k1wAa5SeTVF+
        aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvPeT8wFqzgr
        +qe9ZmpgPMDexcjJISFgIvHh2FmmLkYuDiGBpYwSX98dYe1i5ABKyEgcX18GUSMs8edaFxtE
        zWtGidnrTjOCJIQFIiR+LD7JCmKLCGhK3FrezgxiMwtsYJS4/kUQouE9o8TJo6fAEmwCVhIT
        21eBNfMK2ElsOXINrJlFQEXi/KfHYBeJAg09vGMWVI2gxMmZT1hAbE4BY4nPT46yQCxQl/gz
        7xLUMnGJW0/mM0HY8hLb385hnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5x
        aV66XnJ+7iZGYJxtO/Zzyw7GrnfBhxgFOBiVeHgTHG3ihFgTy4orcw8xSnAwK4nw9qnaxgnx
        piRWVqUW5ccXleakFh9iNAV6biKzlGhyPjAF5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhP
        LEnNTk0tSC2C6WPi4JRqYLSdNiUvf5uJ9gnTosUlVREWDpN6ErfpTC731uG/vs/2kFl01Zud
        LUFfqj9vNF9/2MfpVGbNqtR72U68B2uaqs/O2cUcu13QbFvLfWYuFYGTvPv76lzKNX6USiz9
        3xO72MQ4sn7hlJIiG/FDtQv6Qpvls6zWygWecThpNX3BIfVgn1N5i+6vUWIpzkg01GIuKk4E
        ANJJZ6XJAgAA
X-CMS-MailID: 20200207142226eucas1p2ff5b2973e7acce8e8e5ddd594c18babf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133414eucas1p2baefeb1a492375b18bdf6cdfbd0db796
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133414eucas1p2baefeb1a492375b18bdf6cdfbd0db796
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133414eucas1p2baefeb1a492375b18bdf6cdfbd0db796@eucas1p2.samsung.com>
        <20200128133343.29905-13-b.zolnierkie@samsung.com>
        <20200129172614.GH12616@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 1/29/20 6:26 PM, Christoph Hellwig wrote:
> On Tue, Jan 28, 2020 at 02:33:27PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> Start separating SATA specific code from libata-core.c:
>>
>> * move following functions to libata-core-sata.c:
> 
> Why not call this libata-sata.c?  If it is SATA specific it can't be
> that core :)

Indeed. :)

>> + *  libata-core-sata.c - SATA specific part of ATA helper library
> 
> No need for file names in top of file headers.
> 
>> +/*
>> + * Core layer (SATA specific part) - drivers/ata/libata-core-sata.c
>> + */
>> +#ifdef CONFIG_SATA_HOST
>> +extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>> +			     bool spm_wakeup);
>> +extern int ata_slave_link_init(struct ata_port *ap);
>> +extern void ata_tf_to_fis(const struct ata_taskfile *tf,
>> +			  u8 pmp, int is_cmd, u8 *fis);
>> +extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
>>  extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
>> +#endif
> 
> No need for the ifdef.

All above issues are fixed in v2.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
