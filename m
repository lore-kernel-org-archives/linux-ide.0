Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BCFC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0D62082E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pfc4FfGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgA3Lx6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:53:58 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46442 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgA3Lx5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 06:53:57 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130115356euoutp01412af32af8993653f1b07c9bd8e343c7~up-_5-fVi2098320983euoutp01Y
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 11:53:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130115356euoutp01412af32af8993653f1b07c9bd8e343c7~up-_5-fVi2098320983euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580385236;
        bh=cclT+0t3oQunwPHGpJ2Vfgi2usCXD8SL6hFX2/tq51c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pfc4FfGx6jf0BRqkWbs3t3QvTEKj8cd0Ip8AMgbCWHds+O30mG5GRtGyUxNvby50i
         ivpWcF3jIHoyiIcDak0kEZuz9K3L8P/ZCOZTvConPAufFdb+r+Cr0/d2QxfHVZQDOZ
         46e9u1TJeLcoc47PaW2DiWhnKMzXtvd5O0mqZK6Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130115355eucas1p2104bead72de38bcc6e1455433981e5f8~up-_gwOZI1491914919eucas1p2o;
        Thu, 30 Jan 2020 11:53:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CA.53.60698.3D3C23E5; Thu, 30
        Jan 2020 11:53:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130115355eucas1p13a5d3297f69db0177eeccc0f0f0fc1d5~up-_N9aSp1120611206eucas1p1O;
        Thu, 30 Jan 2020 11:53:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130115355eusmtrp15ad2240488ffbb95fdd2801706b507c2~up-_NYbCA2183821838eusmtrp1R;
        Thu, 30 Jan 2020 11:53:55 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-b3-5e32c3d32faf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.E7.08375.3D3C23E5; Thu, 30
        Jan 2020 11:53:55 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130115355eusmtip11ab7e19ba300243bbf489475b27e403a~up-99I-VE2126721267eusmtip1D;
        Thu, 30 Jan 2020 11:53:54 +0000 (GMT)
Subject: Re: [PATCH 19/24] libata: Use ata_port_printk() in ata_dump_id()
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Message-ID: <a77b1ab3-c63d-18a9-1762-03ba42b5c099@samsung.com>
Date:   Thu, 30 Jan 2020 12:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2e54cd29-6d42-a942-5503-3528239923ed@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87qXDxvFGXQuVLJYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6M5gMHmQs+
        Cla03j/H2MA4g6+LkZ1DQsBEYoVYFyMXh5DACkaJ58ffs0A4XxglGvqnQzmfgTJnT7B2MXKC
        NRw7+YcJIrGcUaKl7xkbhPOWUaL3021GkCphAU+JA4/WsIPYbAJWEhPbV4HFRQSUJD62HwKL
        MwvESTRduQtm8wrYSTxd8JMZxGYRUJV4MvMw2DZRgQiJTw8gbF4BQYmTM5+wgNicAvYSH2ZM
        YoKYIy5x68l8KFteYvvbOcwQl05ml3h10RrCdpF4fG0dC4QtLPHq+BZ2CFtG4vTkHrA3JQTW
        MUr87XjBDOFsZ5RYPvkfG0SVtcSdc7+AbA6gDZoS63fpQ4QdJf4u6WEGCUsI8EnceCsIcQOf
        xKRt06HCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSD6bheSbWUi+mYWwdwEjyypG8dTS4tz0
        1GLjvNRyveLE3OLSvHS95PzcTYzApHL63/GvOxj3/Uk6xCjAwajEw6uxwShOiDWxrLgy9xCj
        BAezkgivqKthnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTByc
        Ug2MB91aTrl9YLetuxniYJf2b8Gb+MIEKWlVc+/zl3wKGv82yx2P9n7i0j1VdYbzi2jBM4c3
        mcZHLa0+vk9D6rrabN4rFpK3s1N/y0erhpdl7KmdOevOyj/8qVcjH1s3lc/b5yUSOo+3YcWp
        JX22r1mqDB90m3Dr3F/7ntMiUVwoImO71ieFuauVWIozEg21mIuKEwFITTGzJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qXDxvFGaxcKGCx+m4/m8WCN3vZ
        LPYsmsRkcWzHIyYHFo/LZ0s91m+5yuKx+XS1x+dNcgEsUXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZzQcOMhd8FKxovX+OsYFxBl8XIyeHhICJ
        xLGTf5i6GLk4hASWMkrsOdXI3MXIAZSQkTi+vgyiRljiz7UuNhBbSOA1o8SONkEQW1jAU+LA
        ozXsIDabgJXExPZVjCC2iICSxMf2Q2BxZoE4iX99u6HmP2aU6O77ywKS4BWwk3i64CcziM0i
        oCrxZOZhVhBbVCBC4vCOWYwQNYISJ2c+AavnFLCX+DBjEhPEUHWJP/MuMUPY4hK3nsyHistL
        bH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFxtO3Y
        z807GC9tDD7EKMDBqMTDq7HBKE6INbGsuDL3EKMEB7OSCK+oq2GcEG9KYmVValF+fFFpTmrx
        IUZToOcmMkuJJucDYzyvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwen
        VAOjg6ftFHZOL9mzH18KWIouOfQnLbpj/VSlzl2Jpxl+T1kT99Z59s+ipAMPNrRrbHni6P93
        9qw5W/QOW1i42wnKXT1gUbrbVnDNUfWWM4yatUfVzOyM71kWfS5oa+e3C06P5/MV5ajO2Hq0
        fs3B5YZNidWzF4n12y9KujDhD1ew3/w1d/XOHXquxFKckWioxVxUnAgAW1fVVrkCAAA=
X-CMS-MailID: 20200130115355eucas1p13a5d3297f69db0177eeccc0f0f0fc1d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104817epcas1p173179f4212a03ab93af37eeab41c89d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104817epcas1p173179f4212a03ab93af37eeab41c89d7
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104817epcas1p173179f4212a03ab93af37eeab41c89d7@epcas1p1.samsung.com>
        <20181213104716.31930-31-hare@suse.de>
        <2e54cd29-6d42-a942-5503-3528239923ed@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/30/20 12:52 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 12/13/18 11:47 AM, Hannes Reinecke wrote:
>> Use ata_port_printk() in ata_dump_id(), dropping DPRINTK usage there.
> 
> Wouldn't it be better to pass and use 'dev' instead of 'ap'
> (the function prints device's id block)?
> 
> Why does it convert DPRINTK() to ata_port_printk() and not dev_dbg()?

s/dev_dbg()/ata_port_dbg()/

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Also please preserve __func__ printing in the conversion.
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>  drivers/ata/libata-core.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index a36f24de399b..914520254215 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -1438,9 +1438,10 @@ static int ata_hpa_resize(struct ata_device *dev)
>>   *	caller.
>>   */
>>  
>> -static inline void ata_dump_id(const u16 *id)
>> +static inline void ata_dump_id(struct ata_port *ap, const u16 *id)
>>  {
>> -	DPRINTK("49==0x%04x  "
>> +	ata_port_printk(ap, KERN_DEBUG,
>> +		"49==0x%04x  "
>>  		"53==0x%04x  "
>>  		"63==0x%04x  "
>>  		"64==0x%04x  "
>> @@ -1450,7 +1451,8 @@ static inline void ata_dump_id(const u16 *id)
>>  		id[63],
>>  		id[64],
>>  		id[75]);
>> -	DPRINTK("80==0x%04x  "
>> +	ata_port_printk(ap, KERN_DEBUG,
>> +		"80==0x%04x  "
>>  		"81==0x%04x  "
>>  		"82==0x%04x  "
>>  		"83==0x%04x  "
>> @@ -1460,7 +1462,8 @@ static inline void ata_dump_id(const u16 *id)
>>  		id[82],
>>  		id[83],
>>  		id[84]);
>> -	DPRINTK("88==0x%04x  "
>> +	ata_port_printk(ap, KERN_DEBUG,
>> +		"88==0x%04x  "
>>  		"93==0x%04x\n",
>>  		id[88],
>>  		id[93]);
>> @@ -2542,7 +2545,7 @@ int ata_dev_configure(struct ata_device *dev)
>>  	xfer_mask = ata_id_xfermask(id);
>>  
>>  	if (ata_msg_probe(ap))
>> -		ata_dump_id(id);
>> +		ata_dump_id(ap, id);
>>  
>>  	/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
>>  	ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
