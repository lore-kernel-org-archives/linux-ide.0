Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BACC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC052085B
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XDP3IG8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBJPXJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:23:09 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44161 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBJPXI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:23:08 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210152305euoutp026a58082458c8c02e59e24f5464b06988~yE8vn3rAM0999709997euoutp02T
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:23:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210152305euoutp026a58082458c8c02e59e24f5464b06988~yE8vn3rAM0999709997euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581348185;
        bh=/pfEXP346Ew01jrv7BmXGEC6dPn414PwaNNs2htCOOA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XDP3IG8urdiCGr9d7QT2xvTsXb14fWjxtA7zQfKW/W/Z2DCymfZwL1ceBGGt/s9vy
         z2SnkR6aXIJTz8L0pxJkvoQZ4omujD1dWzG0jUnoEBgpcM+3nJnWqLYm8lZuwnc4Y2
         yC4WDeeWT1Zhi69JfLlPKaJKCkbUvXfhoo1gHjWY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210152305eucas1p2f23442bcae50490261e0e47cfd961682~yE8vhhYRY2650726507eucas1p2e;
        Mon, 10 Feb 2020 15:23:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.71.60698.955714E5; Mon, 10
        Feb 2020 15:23:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210152305eucas1p2c09848ba8b8dc42248a178e745d0285e~yE8vHR-sD2650726507eucas1p2d;
        Mon, 10 Feb 2020 15:23:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210152305eusmtrp178fbf6448d87580d5ecf01c719248e25~yE8vCXEvY1014910149eusmtrp1f;
        Mon, 10 Feb 2020 15:23:05 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-5d-5e4175596ab8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 83.0B.07950.855714E5; Mon, 10
        Feb 2020 15:23:05 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210152304eusmtip1b7a9fae79f9eadfe03750c4ef7756530~yE8u03Q5F2436824368eusmtip1k;
        Mon, 10 Feb 2020 15:23:04 +0000 (GMT)
Subject: Re: [PATCH 24/46] libata: tracepoints for bus-master DMA
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Message-ID: <50d1b948-1e1d-7d34-ed44-34028a6be7e4@samsung.com>
Date:   Mon, 10 Feb 2020 16:23:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8bf629d0-8e56-8b2c-f170-8d701972a4db@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned3IUsc4g33n5CxW3+1ns9izaBKT
        xbEdj5gcmD0uny312Hy62uPzJrkA5igum5TUnMyy1CJ9uwSujKW3ZAq22VTMP72IqYHxuV4X
        IyeHhICJxO6n99m7GLk4hARWMErc2nGUFcL5wigx798dqMxnRokZC3qZYFoOX2yBqlrOKHHq
        xyN2kISQwFtGif67RSC2sICjxKqFJ5lBbDYBK4mJ7asYQWwRASWJj+2HwOqZBawlZi9eDzaU
        V8BO4tuloywgNouAqsSpj1PA4qICERKfHhxmhagRlDg58wlYDaeAvcT3L2dYIOaIS9x6Mp8J
        wpaX2P52DjPIcRICzewSuzqms0Jc7SLxtv0nC4QtLPHq+BZ2CFtG4vTkHhaIhnWMEn87XkB1
        b2eUWD75HxtElbXEnXO/gGwOoBWaEut36UOEHSUmvb7IDhKWEOCTuPFWEOIIPolJ26YzQ4R5
        JTrahCCq1SQ2LNvABrO2a+dK5gmMSrOQvDYLyTuzkLwzC2HvAkaWVYziqaXFuempxcZ5qeV6
        xYm5xaV56XrJ+bmbGIEp5PS/4193MO77k3SIUYCDUYmH90KwY5wQa2JZcWXuIUYJDmYlEV5L
        aaAQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjGaCnGXy
        qz893Bh7KNtexF5jeVto58xfjw5NyAt+r1m3R2jLj5qFfsGTl9jrclYrzdFR3xF/12DhrIcC
        /eoKrSt8v/vPNTyR3SnfM1M2+Y1wmt6Rgu+bpsTl3GES0K1m+Go6Odp6rePctxrz0nrl5n5Z
        cKzKTIitO3pH1R9pUT0u2b3nTlZMVGIpzkg01GIuKk4EAFYUMZwdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7qRpY5xBsftLFbf7Wez2LNoEpPF
        sR2PmByYPS6fLfXYfLra4/MmuQDmKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81gr
        I1MlfTublNSczLLUIn27BL2MpbdkCrbZVMw/vYipgfG5XhcjJ4eEgInE4YstrF2MXBxCAksZ
        JXZ+X8LWxcgBlJCROL6+DKJGWOLPtS42iJrXjBJPHj5gBEkICzhKrFp4khnEZhOwkpjYvgos
        LiKgJPGx/RA7iM0sYC0xe/F6Jojmp4wS6/6uZwVJ8ArYSXy7dJQFxGYRUJU49XEKE4gtKhAh
        cXjHLEaIGkGJkzOfgNVwCthLfP9yhgViqLrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg0C0n7
        LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgxGw79nPLDsaud8GHGAU4
        GJV4eC8EO8YJsSaWFVfmHmKU4GBWEuG1lAYK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4w
        mvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTBufsklfHzfLx+2
        hcd77yw2C53bf7fZjnNat6vQj4urE0L/d73ibPwQoHW57VDv1zWWDy6nvPrRskX26Szj4jy2
        v5eqmeMPPJj1gb9744TQ5eknz6xUnlPt/e0Lb4Posaxzi2xj5NrWWIZJLbb4nbZyscLm4iT+
        FymrT2tv+mLN1Bwbs0JPRk1eiaU4I9FQi7moOBEAi9LWNK4CAAA=
X-CMS-MailID: 20200210152305eucas1p2c09848ba8b8dc42248a178e745d0285e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165616eucas1p13cb874125f45a8d6fef797de7cf1f5b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165616eucas1p13cb874125f45a8d6fef797de7cf1f5b1
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165616eucas1p13cb874125f45a8d6fef797de7cf1f5b1@eucas1p1.samsung.com>
        <20200204165547.115220-25-hare@suse.de>
        <8bf629d0-8e56-8b2c-f170-8d701972a4db@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/10/20 4:21 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 2/4/20 5:55 PM, Hannes Reinecke wrote:
>> Add tracepoints for bus-master DMA and taskfile related functions.
>> That allows us to drop the relevant DPRINTK() calls.
> 
> The patch drops VPRINTK() calls, not DPRINTK() ones.
Also there is a lot of complaints from checkpatch.pl script
regarding CodingStyle:

ERROR: space prohibited after that open parenthesis '('
#251: FILE: include/trace/events/libata.h:301:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited before that close parenthesis ')'
#251: FILE: include/trace/events/libata.h:301:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited after that open parenthesis '('
#252: FILE: include/trace/events/libata.h:302:
+               __field( unsigned char, cmd     )

ERROR: space prohibited before that close parenthesis ')'
#252: FILE: include/trace/events/libata.h:302:
+               __field( unsigned char, cmd     )

ERROR: space prohibited after that open parenthesis '('
#253: FILE: include/trace/events/libata.h:303:
+               __field( unsigned char, dev     )

ERROR: space prohibited before that close parenthesis ')'
#253: FILE: include/trace/events/libata.h:303:
+               __field( unsigned char, dev     )

ERROR: space prohibited after that open parenthesis '('
#254: FILE: include/trace/events/libata.h:304:
+               __field( unsigned char, lbal    )

ERROR: space prohibited before that close parenthesis ')'
#254: FILE: include/trace/events/libata.h:304:
+               __field( unsigned char, lbal    )

ERROR: space prohibited after that open parenthesis '('
#255: FILE: include/trace/events/libata.h:305:
+               __field( unsigned char, lbam    )

ERROR: space prohibited before that close parenthesis ')'
#255: FILE: include/trace/events/libata.h:305:
+               __field( unsigned char, lbam    )

ERROR: space prohibited after that open parenthesis '('
#256: FILE: include/trace/events/libata.h:306:
+               __field( unsigned char, lbah    )

ERROR: space prohibited before that close parenthesis ')'
#256: FILE: include/trace/events/libata.h:306:
+               __field( unsigned char, lbah    )

ERROR: space prohibited after that open parenthesis '('
#257: FILE: include/trace/events/libata.h:307:
+               __field( unsigned char, nsect   )

ERROR: space prohibited before that close parenthesis ')'
#257: FILE: include/trace/events/libata.h:307:
+               __field( unsigned char, nsect   )

ERROR: space prohibited after that open parenthesis '('
#258: FILE: include/trace/events/libata.h:308:
+               __field( unsigned char, feature )

ERROR: space prohibited before that close parenthesis ')'
#258: FILE: include/trace/events/libata.h:308:
+               __field( unsigned char, feature )

ERROR: space prohibited after that open parenthesis '('
#259: FILE: include/trace/events/libata.h:309:
+               __field( unsigned char, hob_lbal )

ERROR: space prohibited before that close parenthesis ')'
#259: FILE: include/trace/events/libata.h:309:
+               __field( unsigned char, hob_lbal )

ERROR: space prohibited after that open parenthesis '('
#260: FILE: include/trace/events/libata.h:310:
+               __field( unsigned char, hob_lbam )

ERROR: space prohibited before that close parenthesis ')'
#260: FILE: include/trace/events/libata.h:310:
+               __field( unsigned char, hob_lbam )

ERROR: space prohibited after that open parenthesis '('
#261: FILE: include/trace/events/libata.h:311:
+               __field( unsigned char, hob_lbah )

ERROR: space prohibited before that close parenthesis ')'
#261: FILE: include/trace/events/libata.h:311:
+               __field( unsigned char, hob_lbah )

ERROR: space prohibited after that open parenthesis '('
#262: FILE: include/trace/events/libata.h:312:
+               __field( unsigned char, hob_nsect )

ERROR: space prohibited before that close parenthesis ')'
#262: FILE: include/trace/events/libata.h:312:
+               __field( unsigned char, hob_nsect )

ERROR: space prohibited after that open parenthesis '('
#263: FILE: include/trace/events/libata.h:313:
+               __field( unsigned char, hob_feature )

ERROR: space prohibited before that close parenthesis ')'
#263: FILE: include/trace/events/libata.h:313:
+               __field( unsigned char, hob_feature )

ERROR: space prohibited after that open parenthesis '('
#264: FILE: include/trace/events/libata.h:314:
+               __field( unsigned char, proto )

ERROR: space prohibited before that close parenthesis ')'
#264: FILE: include/trace/events/libata.h:314:
+               __field( unsigned char, proto )

ERROR: space prohibited after that open parenthesis '('
#265: FILE: include/trace/events/libata.h:315:
+               __field( unsigned long, flags )

ERROR: space prohibited before that close parenthesis ')'
#265: FILE: include/trace/events/libata.h:315:
+               __field( unsigned long, flags )

WARNING: Avoid unnecessary line continuations
#285: FILE: include/trace/events/libata.h:335:
+       TP_printk("ata_port=%u proto=%s cmd=%s%s " \

WARNING: line over 80 characters
#290: FILE: include/trace/events/libata.h:340:
+                 __parse_subcmd(__entry->cmd, __entry->feature, __entry->hob_nsect),

WARNING: line over 80 characters
#300: FILE: include/trace/events/libata.h:350:
+       TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),

ERROR: space prohibited after that open parenthesis '('
#305: FILE: include/trace/events/libata.h:355:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited before that close parenthesis ')'
#305: FILE: include/trace/events/libata.h:355:
+               __field( unsigned int,  ata_port )

ERROR: space prohibited after that open parenthesis '('
#306: FILE: include/trace/events/libata.h:356:
+               __field( unsigned int,  tag     )

ERROR: space prohibited before that close parenthesis ')'
#306: FILE: include/trace/events/libata.h:356:
+               __field( unsigned int,  tag     )

ERROR: space prohibited after that open parenthesis '('
#307: FILE: include/trace/events/libata.h:357:
+               __field( unsigned char, cmd     )

ERROR: space prohibited before that close parenthesis ')'
#307: FILE: include/trace/events/libata.h:357:
+               __field( unsigned char, cmd     )

ERROR: space prohibited after that open parenthesis '('
#308: FILE: include/trace/events/libata.h:358:
+               __field( unsigned char, proto )

ERROR: space prohibited before that close parenthesis ')'
#308: FILE: include/trace/events/libata.h:358:
+               __field( unsigned char, proto )

WARNING: line over 80 characters
#326: FILE: include/trace/events/libata.h:376:
+            TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),

WARNING: line over 80 characters
#330: FILE: include/trace/events/libata.h:380:
+            TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),

WARNING: line over 80 characters
#334: FILE: include/trace/events/libata.h:384:
+            TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),

WARNING: line over 80 characters
#338: FILE: include/trace/events/libata.h:388:
+            TP_PROTO(struct ata_port *ap, const struct ata_taskfile *tf, unsigned int tag),

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
