Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90537C04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6497820838
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JXJBVyYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgBGOZM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:25:12 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58652 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBGOZL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:25:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142510euoutp0153f6a656f10e52ac0551434de8df6486~xJOUnGPUi1811618116euoutp01E
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:25:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142510euoutp0153f6a656f10e52ac0551434de8df6486~xJOUnGPUi1811618116euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085510;
        bh=DaFknx4/cYYFH+LxyCWQVnxWPePf2L51kjlxvpv+Gb0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JXJBVyYJEa2SnF+RT1aWMEm3fbsLRzCn1K282DEG+ByoyeVkc4nRjTyEnWBtLiTKd
         D+Tv5/rZJX5IaI+Kc/48jsLXe1oh2lH6NzZBeE43hXZcfOW84d75k6/ReytKbJ5Kmo
         PAt/5tTyQlKElxqCBuKfojT4xlDMLy+LX9VTdluE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142510eucas1p23ae25ec3bb61688bd66a1e8365c55f0d~xJOURypkv2593225932eucas1p2K;
        Fri,  7 Feb 2020 14:25:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.78.60698.6437D3E5; Fri,  7
        Feb 2020 14:25:10 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142510eucas1p28123d96616e4ccbf039ddc07c4806eef~xJOT6ZI_H2593225932eucas1p2J;
        Fri,  7 Feb 2020 14:25:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142510eusmtrp28eb528e64c6f8f739261c252c4a1c4ad~xJOT5ys6P0964109641eusmtrp2f;
        Fri,  7 Feb 2020 14:25:10 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-02-5e3d7346c517
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E0.39.08375.5437D3E5; Fri,  7
        Feb 2020 14:25:09 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142509eusmtip19b1fc5065a572d1fbf26d4d0bde8f316~xJOTN8sjU0118101181eusmtip1Q;
        Fri,  7 Feb 2020 14:25:09 +0000 (GMT)
Subject: Re: [PATCH 24/28] ata: start separating SATA specific code from
 libata-scsi.c
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <63839ddc-a19e-62b1-30b6-8394eee1887a@samsung.com>
Date:   Fri, 7 Feb 2020 15:25:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <yq1h80e6tq1.fsf@oracle.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7puxbZxBh++i1qsvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBbLj/9jspjbOp3dgd1j56y77B6bV2h5XD5b6nHocAejx8ent1g8
        Pm+SC2CL4rJJSc3JLEst0rdL4MrofrOLtWA+S8WebWsZGxi3MncxcnJICJhITOjexdbFyMUh
        JLCCUeLOxU9QzhdGiWObtjJBOJ8ZJZ60XWOEaZmz/DwrRGI5o8St+RNYIJy3jBLX2ltZQaqE
        BSIk7jTeAOsQEYiTWPhpJiNIEbPABkaJz5O2gCXYBKwkJravArN5BewkHnz+wgZiswioSLzs
        uAs2SBRo0KcHh1khagQlTs58wgJicwpoSixZtxksziwgLnHryXwmCFteYvvbOcwgyyQEtrFL
        fJ17mA3ibheJS7+vQv0gLPHq+BZ2CFtG4v/O+UwQDesYJf52vIDq3s4osXzyP6hua4k7534B
        2RxAKzQl1u/Shwg7Siw+f4YZJCwhwCdx460gxBF8EpO2TYcK80p0tAlBVKtJbFi2gQ1mbdfO
        lcwTGJVmIXltFpJ3ZiF5ZxbC3gWMLKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzEC09Hp
        f8e/7mDc9yfpEKMAB6MSD2+Co02cEGtiWXFl7iFGCQ5mJRHePlXbOCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYmXYds5JUnXDt8a0jmx/erUm8fVJx
        9Sm/pHPbeGbK7w62UZurfVY74ve0P1sOHGGrnfri9yPJJN/NTxlks7ZW3ppiIbC9d/0191tJ
        ni+URT4uOv6Msyq++z/jsc0LHt764f3iJKPOeu2laWb3pkmtPbAgdiFn0c3DobwqTy5uXlHH
        dm3PXdkNwWJKLMUZiYZazEXFiQCOfnWGQwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7quxbZxBpNOW1usvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBbLj/9jspjbOp3dgd1j56y77B6bV2h5XD5b6nHocAejx8ent1g8
        Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0MvofrOLtWA+S8WebWsZGxi3MncxcnJICJhIzFl+nrWLkYtDSGApo8TSKSAOB1BCRuL4+jKI
        GmGJP9e62CBqXjNK3H3Qyw6SEBaIkLjTeIMRxBYRiJPof/WKCcRmFtjAKHH9iyBEQw+TxNqP
        d8ASbAJWEhPbV4E18ArYSTz4/IUNxGYRUJF42XGXFcQWBRp6eMcsqBpBiZMzn7CA2JwCmhJL
        1m1mhVigLvFn3iVmCFtc4taT+VCL5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc
        9NxiQ73ixNzi0rx0veT83E2MwNjbduzn5h2MlzYGH2IU4GBU4uFNcLSJE2JNLCuuzD3EKMHB
        rCTC26dqGyfEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cC0kFcSb2hqaG5haWhubG5sZqEk
        ztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgdFxg+O6xa8W5t/dvnD1pPn7vtYcvnD7dfKm8M2f
        Z01d2Vs9+Xyy2PQdVX19hiW3H++4Ydj0Kitn7tcnd2Yp1W1eb6iZYLqwI4TBQv2AlPal5N0i
        T8IVlZ18H5TVai/Zr3+IvfHB6cuJE5gN8z/ftXsZbD29/mXLwZVfG6xW3L+3okblaV5kc/F2
        JZbijERDLeai4kQARfwotdMCAAA=
X-CMS-MailID: 20200207142510eucas1p28123d96616e4ccbf039ddc07c4806eef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133418eucas1p157933935f14f9c83c604bc5dc38bcbae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133418eucas1p157933935f14f9c83c604bc5dc38bcbae
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133418eucas1p157933935f14f9c83c604bc5dc38bcbae@eucas1p1.samsung.com>
        <20200128133343.29905-25-b.zolnierkie@samsung.com>
        <20200129173156.GL12616@infradead.org> <yq1h80e6tq1.fsf@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/29/20 6:46 PM, Martin K. Petersen wrote:
> 
> Christoph,
> 
>> On Tue, Jan 28, 2020 at 02:33:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
>>> * include libata-scsi-sata.c in the build when CONFIG_SATA_HOST=y
>>
>> The libata-core.c vs libata-scsi.c split already is a bit weird, any
>> reason not to simply have a single libata-sata.c?
> 
> I agree, I also tripped over libata-scsi-sata.

Fixed in v2 version of the patchset.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
