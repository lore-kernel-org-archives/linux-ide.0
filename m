Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2AEC2D0E5
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C7720857
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DdZs0B7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgCZQRI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:17:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57371 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgCZQRI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 12:17:08 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326161706euoutp02c443fba6d92344530b2f3a880bfda702~-5twT6DS01157311573euoutp02f
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 16:17:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326161706euoutp02c443fba6d92344530b2f3a880bfda702~-5twT6DS01157311573euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585239426;
        bh=mlr6X8MPWZHzVO5afRfEhMBUcBa5uRmLLtJFWSxoqMM=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=DdZs0B7clVlDxrgWPcUv+4qtdj7/ohPUSswevF6OcgTdv6xq0Qa0W7/GzeFf8snh8
         SzULL4BFcb0RSRIv+uAtePD81E6cIndCQnpsRdLp3RTkI3jyyzA4kFTfn18LdwC/K0
         lWWAN7/4ca2NqbxAcALILA1PnJbpQhdFjhBou+9w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326161706eucas1p20b37fa3c36e50bfe859816f53622a874~-5tv1hluO3256532565eucas1p2N;
        Thu, 26 Mar 2020 16:17:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 20.5A.60698.285DC7E5; Thu, 26
        Mar 2020 16:17:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326161705eucas1p1c41061b29d9c3bc58a5d127211c3e3e9~-5tvVnkYO2811828118eucas1p18;
        Thu, 26 Mar 2020 16:17:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326161705eusmtrp1e878269c1dae460bbbcd9408b9ecb726~-5tvVABxx0072100721eusmtrp1y;
        Thu, 26 Mar 2020 16:17:05 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f1-5e7cd5829d0c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.FC.07950.185DC7E5; Thu, 26
        Mar 2020 16:17:05 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326161705eusmtip179bb55c215c1a75d6aee8d93c69973cf~-5tu7Mjey2790027900eusmtip1Y;
        Thu, 26 Mar 2020 16:17:05 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 00/27] ata: optimize core code size on PATA only
 setups
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-ID: <7c1e3658-2405-03f5-37ed-b9951886d674@samsung.com>
Date:   Thu, 26 Mar 2020 17:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3ec639bd-f307-df95-857c-d613a375c7fc@kernel.dk>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7pNV2viDGad57RYfbefzeLZrb1M
        FitXH2WyOLbjEZPF5V1z2CyWP1nLbDG3dTq7A7vHzll32T0uny31OHS4g9HjZOs3Fo/dNxvY
        PD5vkgtgi+KySUnNySxLLdK3S+DK+LTmGWtBA2fF/jd7mBsYV7J3MXJySAiYSHSd+8nUxcjF
        ISSwglFixoR97BDOF0aJ44vWsUI4nxklXkxZywzT0j+vASqxnFFi3duLLBDOW0aJ3euOglWx
        CVhJTGxfxQhiCwsESLxech1soYiAgkTP75VsIA3MAlcZJY6t+84KkuAVsJPYfLsJzGYRUJX4
        cvcJG4gtKhAh8enBYagaQYmTM5+wgNicArYSb07MAxvKLCAucevJfCYIW15i+9s5zCALJAR2
        sUt8/rkGKMEB5LhIzFxvB/GCsMSr41ugISAjcXpyDwtE/TpGib8dL6CatzNKLJ/8jw2iylri
        zrlfbCCDmAU0Jdbv0ocIO0o8WLiaHWI+n8SNt4IQN/BJTNo2nRkizCvR0SYEUa0msWHZBjaY
        tV07VzJPYFSaheSzWUi+mYXkm1kIexcwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQI
        TEen/x3/uoNx35+kQ4wCHIxKPLwNbTVxQqyJZcWVuYcYJTiYlUR4n0YChXhTEiurUovy44tK
        c1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamDkuf20v+d38qKSE81vz61+qGP2
        umKGkuxbJwNbvrJvxxn37jZsaX7VJh5sulAiuSTk87mqtw26GzqmJ+WJp+R5XM738j65t1XV
        t7dmd7uKs+tZ9SnpjMlJ0fEarhlLG6ta10dM/nlvW/t2h0fbOCdfteNNnPf81d9ZP0P5NWwE
        LCJ8pzQWvFViKc5INNRiLipOBACyyKG6QwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7qNV2viDHbOVbdYfbefzeLZrb1M
        FitXH2WyOLbjEZPF5V1z2CyWP1nLbDG3dTq7A7vHzll32T0uny31OHS4g9HjZOs3Fo/dNxvY
        PD5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
        S9DL+LTmGWtBA2fF/jd7mBsYV7J3MXJySAiYSPTPa2AFsYUEljJK7LvF08XIARSXkTi+vgyi
        RFjiz7Uuti5GLqCS14wSR7qvg9WzCVhJTGxfxQhSLyzgJ3FmZjlIWERAQaLn90o2EJtZ4Cqj
        xN4jNRC9hxkl2jcfBdvLK2Ansfl2E9gcFgFViS93n4A1iApESBzeMYsRokZQ4uTMJywgNqeA
        rcSbE/PYIYaqS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMQrOQtM9C0jILScssJC0LGFlWMYqk
        lhbnpucWG+kVJ+YWl+al6yXn525iBEbetmM/t+xg7HoXfIhRgINRiYdXo6UmTog1say4MvcQ
        owQHs5II79NIoBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA5NCXkm8oamhuYWlobmxubGZ
        hZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxpgXW6u+mL/9F3lgT9tsxhvRN/9sTl2S9jI1
        wmLK391a0xzW3/5zYt7qyg1/7738pnul6ar3l/U/dVdsEIk4Hvn2OUd5wEmGj7uPdMUUdnMq
        KOXfidN9IqruGi5n1J48WfmHzjpzdse1Gcv7rJ6HPTvs4TBRU9Su7o3xNZY9dr3v/Z43Wub+
        71ViKc5INNRiLipOBACuNIJ80gIAAA==
X-CMS-MailID: 20200326161705eucas1p1c41061b29d9c3bc58a5d127211c3e3e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144340eucas1p1f6f7a6fbd27cbfeaab2ea97fbccb2836
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144340eucas1p1f6f7a6fbd27cbfeaab2ea97fbccb2836
References: <CGME20200317144340eucas1p1f6f7a6fbd27cbfeaab2ea97fbccb2836@eucas1p1.samsung.com>
        <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <3ec639bd-f307-df95-857c-d613a375c7fc@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 3/26/20 4:16 PM, Jens Axboe wrote:
> On 3/17/20 8:43 AM, Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>>
>> There have been reports in the past of libata core code size
>> being a problem in migration from deprecated IDE subsystem on
>> legacy PATA only systems, i.e.:
>>
>> https://lore.kernel.org/linux-ide/db2838b7-4862-785b-3a1d-3bf09811340a@gmail.com/
>>
>> This patchset re-organizes libata core code to exclude SATA
>> specific code from being built for PATA only setups.
>>
>> The end result is up to 24% (by 23949 bytes, from 101769 bytes to
>> 77820 bytes) smaller libata core code size (as measured for m68k
>> arch using modified atari_defconfig) on affected setups.
>>
>> I've tested this patchset using pata_falcon driver under ARAnyM
>> emulator.
> 
> Bart, I'd like to get this into 5.7, can you rebase on current
> for-5.7/libata? As you know, I dropped the dprintk series, and it's
> now throwing rejects.

Sure, I've just posted v5 (I've rebased it on today's -next and
added Reviewed-by tags from Christoph).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
