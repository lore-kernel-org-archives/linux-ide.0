Return-Path: <SRS0=5IPi=5E=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C406C4332D
	for <linux-ide@archiver.kernel.org>; Thu, 19 Mar 2020 16:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D0920775
	for <linux-ide@archiver.kernel.org>; Thu, 19 Mar 2020 16:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vcvcXvtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCSQPM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:15:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60877 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbgCSQPM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Mar 2020 12:15:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200319161510euoutp0168436768e64cda7abfb679334eba5800~9wLD0XLZk0412804128euoutp01F
        for <linux-ide@vger.kernel.org>; Thu, 19 Mar 2020 16:15:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200319161510euoutp0168436768e64cda7abfb679334eba5800~9wLD0XLZk0412804128euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584634510;
        bh=PH4XpAvDTqRnnkexutJQDHffmNTuPS+R8AFy6ym3OEM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vcvcXvtZ0abSCDV5pqEpaQzKGOi4w1noRZh0iJRinft5n6kAqAlxXeZgVyNZNjsmA
         ed3OGumeWAuvn7Z8znSPwkrekb0c0snAq91g02c0u7v6HQtoSjNEc+zblGICeEnxiv
         bobP1n0GEg7f/drPlw1Fuyi1peRrm/73pXqJTpvQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200319161509eucas1p2afddab88cb58d0c9e5010bb10f3f84ce~9wLDnhj6C0339903399eucas1p27;
        Thu, 19 Mar 2020 16:15:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 23.E1.60698.D8A937E5; Thu, 19
        Mar 2020 16:15:09 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200319161509eucas1p168ca3c148f341f23e29d4637a538e17c~9wLDQWr5P0720007200eucas1p1R;
        Thu, 19 Mar 2020 16:15:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200319161509eusmtrp1c6b0b994825553f20d23c3288fa585dd~9wLDPrUl80891708917eusmtrp1U;
        Thu, 19 Mar 2020 16:15:09 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-65-5e739a8d0b35
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7A.08.07950.D8A937E5; Thu, 19
        Mar 2020 16:15:09 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200319161509eusmtip273a87bca46d0e365c4c4666d945b2d29~9wLCxGxdz1186411864eusmtip2i;
        Thu, 19 Mar 2020 16:15:08 +0000 (GMT)
Subject: Re: [PATCH v4 03/27] ata: make SATA_PMP option selectable only if
 any SATA host driver is enabled
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8b77928f-5985-046c-f760-b50625dbeeb4@samsung.com>
Date:   Thu, 19 Mar 2020 17:15:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1584456957.4545.7.camel@linux.ibm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTu3b279244uc7FDhZGw6IMtZjlxUKMgu6vDPoTgtbUy9R0yq5a
        +kejTBtFpsZwKJaBuqn5kfkVikzcEMtEf2TL+dX6UFpkVpqotO0q+e85z3mec84Dh8LkQ+Ig
        Kk2Xw+l1mgwVIcW7bH/Hwh6Y+MTj01Y10+R8SDCfHf0ixtw0LGLqprpEjK1nQcRM9lUTTIOr
        BWMa7FsipqbYSMZK2F6Tk2Qn3+Sy1qFSxJbVDSJ2pPgPzr56X0Swy58cOLvSEXyJipeeSeEy
        0vI4fUTMNWnqyq0fWLYz+KZlVF+EusGAJBTQkTDzYhY3ICklpxsRPG1ux4TiF4KN8VWxUKwg
        sHUaxTsWY4uNFBoNCNz9PdsWN4KRwUrSqwqkM6C5thL3YgV9BLrX55FXhNFmETwb/ugTEXQ0
        PCqxIC+W0THgmqv3GXD6EHwfLPHhvfQV+Dk3JBY0ATBS5fLxEs8ZlrV5zIsxWgkOV61IwAeg
        213tuwjoCRJer1Z7FlCe4jxsfUsTIgTCkr2TFPB+GK24jwv65wg2S79um7sRNFRsEYLqNEyP
        rRPeQRh9FFr7IgT6LHQ0bpLCfH+YcgcIN/hDeZcRE2gZlN6VC+rD0FbfRuysNfSasTKkMu1K
        ZtqVxrQrjen/3icItyAll8tnajlereNuhPOaTD5Xpw1PzsrsQJ7XGt2y/+5BAxtJVkRTSOUn
        i73DJ8rFmjw+P9OKgMJUClmY1kPJUjT5BZw+66o+N4PjrWgfhauUMnXdYoKc1mpyuOscl83p
        d7oiShJUhBKwwuykcqwufdwRQrrVF3XtjStRoaXWHt7JOCHE4LwXV/UyTqp6nGhclM7ET7xV
        LBTGX/7SyyvssRfWXP3v0nPshqhCNuLcxp7K6E2zMoRsTx3Q8rVT+tsF2dONNZHV5EjrsXSF
        fHhp+VT8rE1S+8GPUB6UJQcV5Z9cDFbhfKrmRCim5zX/ANwXbrNWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7q9s4rjDM6skrVYfbefzeLZrb1M
        FitXH2WyWHRjG5PFsR2PmCwu75rDZrH8yVpmi+XH/zFZzG2dzu7A6bFz1l12j8tnSz0OHe5g
        9Jiw6ACjx8nWbyweu282sHl8fHqLxePzJrkAjig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jM+NH5gL7spVrDpd1MC4XaKLkZNDQsBEYvraY+xd
        jFwcQgJLGSWufbjP0sXIAZSQkTi+vgyiRljiz7UuNoia14wSExe8YAZJCAvkSNy8+YEFxBYR
        0JDY/ushI0gRs8BKJok3W55CdbxllGjp/gLWwSZgJTGxfRUjiM0rYCfx5MEysG4WAVWJdwfa
        wWxRgQiJwztmQdUISpyc+QQszgl06qofD8HmMAuoS/yZdwnKFpe49WQ+E4QtL7H97RzmCYxC
        s5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERum2Yz+37GDsehd8
        iFGAg1GJh3dGW3GcEGtiWXFl7iFGCQ5mJRFe3XSgEG9KYmVValF+fFFpTmrxIUZToOcmMkuJ
        JucDE0heSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGbcqCVQoL
        ufc33RO1EnZWSi8R6jJbbrhtRpNTi3uh66vjYkw8ZzrWnPvbwGreYOs69bbRCl7WvzGH27WU
        +XxfOU384aB/SKlwwa/HJ3SEtmgstRbutmUrmep77FfV3+zOFbEt1+ZPn2Tz4qie+uamjNn+
        Zkf/MuxKXu/iwXuHa4+Uz5N7qR+VWIozEg21mIuKEwEFGdgb6AIAAA==
X-CMS-MailID: 20200319161509eucas1p168ca3c148f341f23e29d4637a538e17c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144342eucas1p2d73deadcdb4cee860dd610f9f8e26bda
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144342eucas1p2d73deadcdb4cee860dd610f9f8e26bda
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144342eucas1p2d73deadcdb4cee860dd610f9f8e26bda@eucas1p2.samsung.com>
        <20200317144333.2904-4-b.zolnierkie@samsung.com>
        <1584456957.4545.7.camel@linux.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 3/17/20 3:55 PM, James Bottomley wrote:
> On Tue, 2020-03-17 at 15:43 +0100, Bartlomiej Zolnierkiewicz wrote:
>> There is no reason to expose SATA_PMP config option when no SATA
>> host drivers are enabled. To fix it add SATA_HOST config option,
>> make all SATA host drivers select it and finally make SATA_PMP
>> config options depend on it.
>>
>> This also serves as preparation for the future changes which
>> optimize libata core code size on PATA only setups.
>>
>> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com> # for
>> SCSI bits
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/ata/Kconfig         | 40
>> +++++++++++++++++++++++++++++++++++++
>>  drivers/scsi/Kconfig        |  1 +
>>  drivers/scsi/libsas/Kconfig |  1 +
>>  3 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index a6beb2c5a692..ad7760656f71 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -34,6 +34,9 @@ if ATA
>>  config ATA_NONSTANDARD
>>         bool
>>  
>> +config SATA_HOST
>> +	bool
>> +
>>  config ATA_VERBOSE_ERROR
>>  	bool "Verbose ATA error reporting"
>>  	default y
>> @@ -73,6 +76,7 @@ config SATA_ZPODD
>>  
>>  config SATA_PMP
>>  	bool "SATA Port Multiplier support"
>> +	depends on SATA_HOST
>>  	default y
>>  	help
>>  	  This option adds support for SATA Port Multipliers
>> @@ -85,6 +89,7 @@ comment "Controllers with non-SFF native interface"
>>  config SATA_AHCI
>>  	tristate "AHCI SATA support"
>>  	depends on PCI
>> +	select SATA_HOST
>>  	help
>>  	  This option enables support for AHCI Serial ATA.
> 
> This is a bit fragile and not the way Kconfig should be done.  The
> fragility comes because anyone adding a new host has also to remember
> to add the select, and there will be no real consequences for not doing

People adding the new host driver usually look at the existing Kconfig
entries before introducing the new one (most probably just copy and then
modify existing entry) so they should notice that the existing entries
contain the select.

Also we shouldn't have problem in catching potential select omissions
during the code review.

Not to mention that the addition of the new ATA host driver is quite
a rare event nowadays.. ;)

> so.  The way to get rid of the fragility is to make SATA_HOST a
> menuconfig option enclosing all the hosts, which makes the patch much
> smaller as well.  The hint implies you want to separate out all the
> PATA drivers, which also makes a menuconfig sound like the better
> option.
SATA_HOST is not for grouping SATA hosts, it is for core libata
code to enable SATA support (please see patches #13-26 for details,
maybe it should have been named ATA_SATA?) and menuconfig usage in
this case is problematic:

- we have host drivers supporting both SATA and PATA (i.e. ata_piix)

- we have currently host drivers sorted in Kconfig by different 
  criteria than SATA or PATA support

- I would prefer to avoid making users to have explicitly select
  SATA_HOST option (right now it gets auto-selected when needed)

- SCSI_SAS_ATA (which also needs to select SATA_HOST) lives in
  drivers/scsi/libsas/Kconfig so menuconfig will not cover it

> I've also got to say that the problem doesn't seem to be one ... even
> if some raving lunatic disables all SATA hosts and then enables PMP it
> doesn't cause any problems does it?

It doesn't cause any real problems (just some dead code being present
in the kernel image) but this patch is a prerequisite for patches #13-26
(patch description mentions that this change is needed for the future
changes which optimize libata core code size on PATA only setups).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
