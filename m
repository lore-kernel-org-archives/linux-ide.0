Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3151C2D0CE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 12:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADAB2051A
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 12:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sJfv3zqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAUMVJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:21:09 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57616 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgAUMVI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2020 07:21:08 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200121122106euoutp0122e6d2650d4c08c791d20fc85ce65d8c~r5kJHNvD82583125831euoutp01a
        for <linux-ide@vger.kernel.org>; Tue, 21 Jan 2020 12:21:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200121122106euoutp0122e6d2650d4c08c791d20fc85ce65d8c~r5kJHNvD82583125831euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579609266;
        bh=nocvT2lGM2EnmRu6ElmVwH0OV1NLnXktZKcrAJsI8Bk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sJfv3zqmSkdK1k9bwO032LKbx3PzrsdVp61/yeBqu7WtrObDyBz7rUakBs1zpmzjh
         gzKf3VeQ2eLxS2zoUBeFmVboliCHaV4g4IfDVnKXwld3xFeM0AW/LS8ju4yXc3w5yT
         nr4fAYcqDItkA92vfqZvhGauo+eX2/PBeewvxkno=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200121122106eucas1p2b9e468cbed667a406a60799ecac3dc85~r5kI9Ax4Z3047030470eucas1p2f;
        Tue, 21 Jan 2020 12:21:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7A.33.61286.2BCE62E5; Tue, 21
        Jan 2020 12:21:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121122106eucas1p210f1ec737850c2b74e4446bd3f1beb06~r5kIoenmH1179311793eucas1p2o;
        Tue, 21 Jan 2020 12:21:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200121122106eusmtrp14fb5889abfa8f8d810471f29805eb3a8~r5kIn7RPr2207322073eusmtrp1F;
        Tue, 21 Jan 2020 12:21:06 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-fa-5e26ecb283e9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E8.A2.08375.1BCE62E5; Tue, 21
        Jan 2020 12:21:06 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200121122104eusmtip17ff2c78fb6d2298c87f63e84f3881873~r5kG1iwT20980809808eusmtip1H;
        Tue, 21 Jan 2020 12:21:04 +0000 (GMT)
Subject: Re: [PATCH 1/2] cmd64x: potential buffer overflow in
 cmd64x_program_timings()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <02ea0fe7-fedd-66ac-ac60-0cdcb8802076@samsung.com>
Date:   Tue, 21 Jan 2020 13:21:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200121114835.GB1847@kadam>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7qb3qjFGWxvkbR4/W86i8Wc8y0s
        FltvSVsc2/GIyYHFY8vKm0weH5/eYvH4vEkugDmKyyYlNSezLLVI3y6BK+Ps/iesBZPEKw41
        r2VqYDwp0MXIySEhYCIxYcYZxi5GLg4hgRWMElfWvWCBcL4wSrw9dYENwvnMKHF28hImmJbn
        z9+xQySWM0osvDGdFcJ5yyhx7MkEFpAqYYEIiVkXdrOB2CICOhKXO3+wg9jMAikSE29MYwWx
        2QSsJCa2r2IEsXkF7CSOdEwA28AioCpx4PIDsHpRoDmfHhxmhagRlDg58wnQfA4OTgEtia/3
        EiFGikvcejKfCcKWl9j+dg4zyD0SAu3sEpdaP7NBXO0iMW/JK0YIW1ji1fEt7BC2jMTpyT0s
        EA3rGCX+dryA6t7OKLF88j+obmuJO+d+sYFsZhbQlFi/Sx8i7Chx7McRsIMkBPgkbrwVhDiC
        T2LStunMEGFeiY42IYhqNYkNyzawwazt2rmSeQKj0iwkn81C8s4sJO/MQti7gJFlFaN4amlx
        bnpqsWFearlecWJucWleul5yfu4mRmBCOf3v+KcdjF8vJR1iFOBgVOLhzXiqFifEmlhWXJl7
        iFGCg1lJhHdBk2qcEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJM
        HJxSDYye3UISNjmb/j5nPVrtMa1E2oVXVLF9+hdnp+LP+psUrr7saPlZU1fgwRCZNdc34M6i
        924v/U+bTvw3S+HYLM+zJ+J/dnw7en7uwSeM3dVL/9lX+WUsmXj2h2q9l8KblSfviduJFS34
        t+CPnn/HlTm9Xqefz9hkuvCE+LPFyk5Fl97xW4TvifBRYinOSDTUYi4qTgQAGpb6DSQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7qb3qjFGWw8wmTx+t90Fos551tY
        LLbekrY4tuMRkwOLx5aVN5k8Pj69xeLxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6R
        iaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbZ/U9YCyaJVxxqXsvUwHhSoIuRk0NCwETi+fN3
        7CC2kMBSRonzlyO7GDmA4jISx9eXQZQIS/y51sXWxcgFVPKaUeLbhANg9cICERKzLuxmA7FF
        BHQkLnf+AIszC6RITLs8F6phAZPE3ePvGEESbAJWEhPbV4HZvAJ2Ekc6JjCB2CwCqhIHLj8A
        axYFGnp4xyyoGkGJkzOfsIAcxCmgJfH1XiLEfHWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVFo
        FpLuWUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA6Nl27OfmHYyXNgYf
        YhTgYFTi4c14qhYnxJpYVlyZe4hRgoNZSYR3QZNqnBBvSmJlVWpRfnxRaU5q8SFGU6DfJjJL
        iSbnAyM7ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo0deVqef
        yJrz9XNOxv+1nsx744WahthPtrvTnAqljJY4Sm9Qm/WJaeK8g2VPj/zrk5dex3zg4IlXzduM
        PmqszWO84GKbus2KYWLdy5nHWPOWzzoWNUGcTzWca9H/1pK53O9txELyVQssXSWirl2cvpOh
        r/KaiXTy5IeCAvXB5kZujVuOvq+7p8RSnJFoqMVcVJwIAH+pbua0AgAA
X-CMS-MailID: 20200121122106eucas1p210f1ec737850c2b74e4446bd3f1beb06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f
References: <20200107130441.y3owvcnxdljailt5@kili.mountain>
        <20200120.144042.1810086369376110530.davem@davemloft.net>
        <CGME20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f@eucas1p2.samsung.com>
        <faf4b367-29b3-474c-73bc-400f6ab36758@samsung.com>
        <20200121114835.GB1847@kadam>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/21/20 12:48 PM, Dan Carpenter wrote:
> On Tue, Jan 21, 2020 at 12:15:54PM +0100, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi,
>>
>> On 1/20/20 2:40 PM, David Miller wrote:
>>> From: Dan Carpenter <dan.carpenter@oracle.com>
>>> Date: Tue, 7 Jan 2020 16:04:41 +0300
>>>
>>>> The "drive->dn" value is a u8 and it is controlled by root only, but
>>>> it could be out of bounds here so let's check.
>>
>> drive->dn should not be root controllable, please point me where it
>> happens as this may need fixing instead of cmd64x driver.
>>
>> [ IDE core makes sure that drive->dn is never > 3 and a lot of code
>>   assumes it. ]
>>
> 
> It's a marked as a setable field in ide-proc.c
> 
> drivers/ide/ide-proc.c
>    206  ide_devset_rw(current_speed, xfer_rate);
>    207  ide_devset_rw_field(init_speed, init_speed);
>    208  ide_devset_rw_flag(nice1, IDE_DFLAG_NICE1);
>    209  ide_devset_rw_field(number, dn);
>                             ^^^^^^^^^^
> Sets ->dn

It is a bug.

We should add:

#define ide_devset_ro_field(_name, _field) \
ide_devset_get(_name, _field); \
IDE_DEVSET(_name, 0, get_##_name, NULL)

in <linux/ide.h> (just after ide_devset_rw_field())

and use it instead.

Care to make a patch?

>    210  
>    211  static const struct ide_proc_devset ide_generic_settings[] = {
>    212          IDE_PROC_DEVSET(current_speed, 0, 70),
>    213          IDE_PROC_DEVSET(init_speed, 0, 70),
>    214          IDE_PROC_DEVSET(io_32bit,  0, 1 + (SUPPORT_VLB_SYNC << 1)),
>    215          IDE_PROC_DEVSET(keepsettings, 0, 1),
>    216          IDE_PROC_DEVSET(nice1, 0, 1),
>    217          IDE_PROC_DEVSET(number, 0, 3),

Please note the minimum and maximum values above and look at code in
ide_write_setting():

	if ((ds->flags & DS_SYNC)
	    && (val < setting->min || val > setting->max))
		return -EINVAL;

[ DS_SYNC flag is set by ide_devset_rw_field() macro. ]

Thus even without fixing ide-proc.c both your patches are superfluous.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>    218          IDE_PROC_DEVSET(pio_mode, 0, 255),
>    219          IDE_PROC_DEVSET(unmaskirq, 0, 1),
>    220          IDE_PROC_DEVSET(using_dma, 0, 1),
>    221          { NULL },
>    222  };
> 
> drivers/ide/ide-devsets.c
>    159  int ide_devset_execute(ide_drive_t *drive, const struct ide_devset *setting,
>    160                         int arg)
>    161  {
>    162          struct request_queue *q = drive->queue;
>    163          struct request *rq;
>    164          int ret = 0;
>    165  
>    166          if (!(setting->flags & DS_SYNC))
>    167                  return setting->set(drive, arg);
>                                ^^^^^^^^^^^^^^^^^^^^^^^^
> Called from here according to Smatch.
> 
>    168  
>    169          rq = blk_get_request(q, REQ_OP_DRV_IN, 0);
> 
> regards,
> dan carpenter
