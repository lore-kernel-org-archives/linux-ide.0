Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56630C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 20 Jun 2022 22:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiFTWo0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiFTWo0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2022 18:44:26 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211B13F95
        for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2022 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655765065; x=1687301065;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=UiaZNMhPIM4L1Ymv5U2/MubzgiM/B581bMZe9tHbuT4=;
  b=gwnSNrJ14JGF1A6brbh53Iu1VZNGojIK+zl8TInWp8CATxYvLtx60n61
   Auxp87dsiqtxXtkqERREfOZKKd5UnqkR8/BR437wweMnhDBA8eppbhtR3
   J8sYYhzCSrbBJjej6QplxCWr+dZ62U+RV5r1eSXJVWWEoaaC9iIBSwJCU
   kL96qZSqzeLBDdbmfguZhi4+Zfsw6tDQA687OY0FzwQrzRCiRAVYc1Mfl
   /k2RfQiC9RlbYSMXf5OSnb0CpsCblHwLPZq0an4HfgxyaSR2rmkZ8+d0v
   LA7oim57nVRuojSYok4kTLTX+X0s5HFZxeca0ryXleBhN4tbqEoVl2zxg
   w==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="315760834"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 06:44:24 +0800
IronPort-SDR: jqSZvshR5G/kUNbPRU+hoMkddGiaynyfKU4H2GbLxu8jzJsnfkfmCAaO619Q4nmmXJZHZx6AUX
 qSvVLPXhBhrOHMkWJwQlfd7U7ydpq1nMWuGESFnJxQp+Juh/0NqRgWMzJr8moSdUykhw6bb3d+
 8hZq48Pa81coFTYn7tF8RQ7312C/SAfNZAEIMNBiMz0VeGfeOJn4UjlahJDm2xpVsbuX943OBn
 1nbxTkObanO1wP4vsTTI1P84tIP54Q0uVV56SJXW3oFrgjso/Bibyn4Tfqf+ioi+Cqmrtx0yCH
 KHkBChJfh5Tm19rN1kRJ8PC3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 15:02:32 -0700
IronPort-SDR: bHfCXRqYBB9TvwXdICYGXKNUlTOAPFvlCYnWys1k9ESFoGbtqaErr6hk6qMZXras0XtQDI+5lb
 IIaI5u2USOHuMmOBh9sAA4Jny08mRzIuNEhkbm5QBUZXOh0okcv22H+GH8Pc/ZPioZfvbXmx6y
 DFTAB73wV5GLlDwK2Vt8J3gdpu8OPmKIrkMi4GXC3Qpm8asZMFGEjElvdy8g3bjtRcJQNKVd/0
 R34JnPxvy0pDj4pO0cYnNl7sgjiUbZU4DIVd6QeJ39aXR/b2lI4Qi/gl3fyihsB5zuJgGU3JPk
 2e0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 15:44:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRl7r0kdKz1Rvlx
        for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2022 15:44:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655765063; x=1658357064; bh=UiaZNMhPIM4L1Ymv5U2/MubzgiM/B581bMZ
        e9tHbuT4=; b=Ptq/dYN35bRcj2DXYbNNqO/xi35IiLFU+lJQBZIzQgSTC2PPJip
        BZJbviKIxoTGaJGagVlJ2LGYiNavL85ue3dKIEBjIeZOmeQ4HdLH5SqM129zZX6e
        Dqc3jklQkxFLfVjFVAebycFSQp6xjHjEOTzpal+3qfNq1IptVwybCPRAqw2vc/tV
        6/pGN/+zVX0dCHBGa99YVKlptzaxiVxRw9LZmYRCY4bA4f+YypJLJJpIZ/+4rV9L
        WZhtLxPphQAm4V9U4A0qhJ8zAbL67MIXDfoTr2s7TNtHJ1TVkHmvVODbc8jHVmld
        O0IEFIcaio//EVTyxSwwuuq0Ty71RHWhRHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EkTLfzGefY52 for <linux-ide@vger.kernel.org>;
        Mon, 20 Jun 2022 15:44:23 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRl7q2c1Nz1Rvlc;
        Mon, 20 Jun 2022 15:44:23 -0700 (PDT)
Message-ID: <9c231ffe-df3c-9c36-4b8b-dc518009c3d2@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 07:44:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata-scsi: fix sloppy result type of ata_ioc32()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <4a695619-2de7-671e-7b67-2afddf22423f@omp.ru>
 <d653908c-1270-9c2f-eceb-2572e9c9d339@opensource.wdc.com>
 <e8dcebdc-7618-533e-0050-dd03ef1f4bb8@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e8dcebdc-7618-533e-0050-dd03ef1f4bb8@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/21/22 05:26, Sergey Shtylyov wrote:
> On 6/20/22 2:12 AM, Damien Le Moal wrote:
> 
>>> While ata_ioc32() returns *int*, its result gets assigned to and compared
>>> with the *unsigned long* variable 'val' in ata_sas_scsi_ioctl(), its only
>>> caller, which implies a problematic implicit cast -- fix that by returning
>>> *unsigned long* instead.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>>> analysis tool.
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> ---
>>> This patch is against the 'for-next' branch of Damien's 'libata.git' repo.
>>>
>>>  drivers/ata/libata-scsi.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Index: libata/drivers/ata/libata-scsi.c
>>> ===================================================================
>>> --- libata.orig/drivers/ata/libata-scsi.c
>>> +++ libata/drivers/ata/libata-scsi.c
>>> @@ -539,7 +539,7 @@ int ata_task_ioctl(struct scsi_device *s
>>>  	return rc;
>>>  }
>>>  
>>> -static int ata_ioc32(struct ata_port *ap)
>>> +static unsigned long ata_ioc32(struct ata_port *ap)
>>>  {
>>>  	if (ap->flags & ATA_FLAG_PIO_DMA)
>>>  		return 1;
> 
>> Actually, this should be a bool I think and the ioctl code cleaned to use
> 
>    By the ioctl code you mean ata_sas_scsi_ioctl()?

yes.

> 
>> that type since the val argument of the ioctl is also used as a bool.
> 
>    As for HDIO_SET_32BIT, that's prolly OK but what to do with HDIO_GET_32BIT
> (it calls put_user() on *unsigned long*)?

Something like this should work fine:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 86dbb1cdfabd..ec7f79cbb135 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -556,6 +556,7 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct
scsi_device *scsidev,
                     unsigned int cmd, void __user *arg)
 {
        unsigned long val;
+       bool pio32;
        int rc = -EINVAL;
        unsigned long flags;

@@ -571,16 +572,16 @@ int ata_sas_scsi_ioctl(struct ata_port *ap, struct
scsi_device *scsidev,
                return put_user(val, (unsigned long __user *)arg);

        case HDIO_SET_32BIT:
-               val = (unsigned long) arg;
+               pio32 = !!((unsigned long) arg);
                rc = 0;
                spin_lock_irqsave(ap->lock, flags);
                if (ap->pflags & ATA_PFLAG_PIO32CHANGE) {
-                       if (val)
+                       if (pio32)
                                ap->pflags |= ATA_PFLAG_PIO32;
                        else
                                ap->pflags &= ~ATA_PFLAG_PIO32;
                } else {
-                       if (val != ata_ioc32(ap))
+                       if (pio32 != ata_ioc32(ap))
                                rc = -EINVAL;
                }
                spin_unlock_irqrestore(ap->lock, flags);


> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
