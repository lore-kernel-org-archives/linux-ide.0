Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3730C433FE
	for <linux-ide@archiver.kernel.org>; Wed, 16 Nov 2022 01:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiKPBax (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Nov 2022 20:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiKPBaw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2022 20:30:52 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD5DED6
        for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2022 17:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668562250; x=1700098250;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i0gHRwXuIJOP8atw8EZvBB0QFTOEHheZ0uEGpIud+BM=;
  b=UG0oKDPs3FVGESlvdmdwWfeCDv1l1rUhx9i0GM9umDn1Rwoa3Ui8RB9U
   yatMj2edY8Tet18C3ElJoMZXvR9KD8gfmydldhaXQJv+DAC2IxX6FCo94
   7jsbt3L/Fuj6k748CSiQkFGh/3s6zA6OqjtOxQyRSlgwiIK7CFnLV3fmi
   ShzyaM+aZVh1vu3ebmJeaS60t50we9XKwMpfTKL8SL4Tp/4eyOqqAy2ml
   OZTIangM+oMeowxvdwtMbuZcGBQKz4Z7DU8FfmQ+lDo8yEpXQ1u5ynKjr
   tLm0FB+e9NuCVq9tcPxYgQTXmf2e8R0UFq6lzIzSU2TFbAbwDAoKJJ0Gb
   g==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665417600"; 
   d="scan'208";a="328468524"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2022 09:30:50 +0800
IronPort-SDR: kkba90Up2fhnOYw/ac4ZxN/Vp+gOZAnfvSe16bJ0tVolDopANJ3qOPX/+TMaQe0QVFEAP2/PnD
 69XfGGjpZUAhsg7/z5Cmi4soOCsKA3pUWISDBghq3NyWGuZo4WN9+o7qAAF0QlzHDzdawOeHiM
 cDT+Foai7jOifuf6RGu4QEo1Uh4Cpow2ODMkmW60U0W22YrRK0wppScfpcTHTwEUtwC+Ty8O8W
 StcbL23IT8z5IrQIHIPJMBhF+czJa8SxWwO6hOBN2pGxOhK+yxD1Ml5F8YAvKWzOd7S5maHTuS
 mwM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2022 16:44:02 -0800
IronPort-SDR: aA+V6gLQThfhDyBKaKpuOMbX4F4CjNuxL/ytAYOVrzybL1oAbpGbHeW4AIOx2HVRG5YJSwNWQB
 qzsvUrMEeEeUYEc4RHL9Ijqs8E+UvWQks1hPjSD1asH5DbGmwUINHzMJe4ujhJVHzuW/lV7vol
 xESL9emxIVE4smQLvjRZaAhgfFsO5n/1Mu+AJL9b1URhT3qRTL3lkLYMJKbJw1hzROKuCXdsXK
 OhhcFwaug47dr/Tp7Cp5foEWHvU+09DfgfA9glhLpOt7hAsQjK59AW0swCHV2Bl2aWsy9qFWRc
 E4k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2022 17:30:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NBlqZ1TyRz1Rwrq
        for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2022 17:30:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668562249; x=1671154250; bh=i0gHRwXuIJOP8atw8EZvBB0QFTOEHheZ0uE
        GpIud+BM=; b=BBIEMAk856oaXs3IanIMxDQOlnD/E9Ik7i+gmzHFWZfz7TF7sjY
        e3kBBmtQ3D66tqy7s7X7TloXP083wtLoiYC0sVlkAAB7fzl581zmMA0hFRJ8M+Dd
        oUnSZgaUzPcSAuAMtJbOwxS4mDB5KRUOFoUvLPkNPu0b1YPO/Ljm+dWOSB5pYmwh
        hUAAk3GzToH8ggHAxz7/BweHVBuLVITRf3uyA5gb8TwaQiUaTK48PEaybRLjUBnX
        oy0mfa7eHjpM9Cvwvi0aG/tA2MMb3cZPZZOsLlZghSYv/LkJzv3s4OVjBfODzj6z
        SjdVr5Dgmhw3Nda6hYwEv/6K0oFM7E/cNRQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eNaixRYFkKj1 for <linux-ide@vger.kernel.org>;
        Tue, 15 Nov 2022 17:30:49 -0800 (PST)
Received: from [10.89.82.19] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.19])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NBlqW6TR0z1RvLy;
        Tue, 15 Nov 2022 17:30:47 -0800 (PST)
Message-ID: <bfc49618-dbc3-8ffb-f536-3b4486e1980e@opensource.wdc.com>
Date:   Wed, 16 Nov 2022 10:30:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <202211142025.46723.linux@zary.sk>
 <dc4e757a-737d-0bfa-c85d-9521feaa8d5f@opensource.wdc.com>
 <202211151556.52895.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202211151556.52895.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/11/15 23:56, Ondrej Zary wrote:
> On Tuesday 15 November 2022, Damien Le Moal wrote:
>> On 11/15/22 04:25, Ondrej Zary wrote:
>>> On Monday 14 November 2022 09:03:28 Damien Le Moal wrote:
>>>> On 11/14/22 16:53, Ondrej Zary wrote:
>>>>> On Monday 14 November 2022, Damien Le Moal wrote:
>>>>>> On 11/12/22 20:17, Ondrej Zary wrote:
>>>>>>> On Wednesday 19 October 2022 09:34:31 Christoph Hellwig wrote:
>>>>>>>> It's been a while - did you get a chance to make some progress on
>>>>>>>> this?  Do you need any help to unblock you?
>>>>>>>>
>>>>>>>
>>>>>>> Sorry again, I'm back now. Trying to fix locking problems.
>>>>>>> Added this to each function for analysis how the functions are called wrt.
>>>>>>> locking:
>>>>>>>
>>>>>>> 	printk("%s, locked=%d\n", __FUNCTION__, spin_is_locked(ap->lock));
>>>>>>
>>>>>> Do you have your code somewhere that we can look at ?
>>>>>
>>>>> This is the current version with debug printks. I've also added dump_stack()
>>>>> to find out the code path but haven't analyzed the output yet.
>>>>
>>>> Can you send a proper patch ? Or a link to a git tree ? That is easier to
>>>> handle than pasted code in an email...
>>>
>>> Patch against what? I don't have a git server.
>>
>> patch against current 6.1-rc, or against an older kernel should be OK too.
>> But please "git send-email" a patch, or push your dev tree to github ?
>>
>>> I've done some call trace analysis. These code paths are calling
>>> pata_parport functions with ap->lock locked during init.
>>>
>>> Comm: kworker, Workqueue: ata_sff ata_sff_pio_task
>>> ata_sff_hsm_move -> ata_pio_sectors-> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
>>> ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_tf_read -> pata_parport_check_altstatus
>>> ata_sff_pio_task -> ata_sff_busy_wait -> pata_parport_check_status
>>> ata_sff_hsm_move -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
>>> ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
>>> ata_sff_pio_task -> ata_sff_hsm_move -> ata_pio_sectors -> ata_pio_sector -> ata_pio_xfer -> pata_parport_data_xfer
>>> ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_data_xfer
>>> ata_sff_pio_task -> ata_sff_hsm_move -> pata_parport_tf_read
>>> ata_sff_hsm_move -> ata_hsm_qc_complete -> ata_qc_complete -> fill_result_tf -> ata_sff_qc_fill_rtf -> pata_parport_tf_read
>>> ata_sff_hsm_move -> ata_pio_sectors -> ata_sff_altstatus -> pata_parport_check_altstatus
>>> ata_sff_hsm_move -> ata_sff_altstatus -> pata_parport_check_altstatus
>>>
>>> Comm: modprobe
>>> ata_host_start -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
>>>
>>> Comm: scsi_eh_4
>>> ata_eh_recover -> ata_eh_reset -> ata_eh_thaw_port -> ata_sff_thaw -> ata_sff_irq_on -> ata_wait_idle -> ata_sff_busy_wait -> pata_parport_check_status
>>> ata_eh_reset -> ata_eh_freeze_port -> ata_sff_freeze -> pata_parport_check_status
>>> ata_scsi_error -> ata_scsi_port_error_handler -> ata_port_freeze -> ata_sff_freeze -> pata_parport_check_status
>>> ata_sff_error_handler -> pata_parport_drain_fifo -> pata_parport_check_status
>>
>> What exactly are the issues you are having with ap->lock ? It looks like
>> you have done a lot of analysis of the code, but without any context about
>> the problem, I do not understand what I am looking at.
>>
> 
> The problem is that pi_connect() can sleep because it calls
> parport_claim_or_block(). And any access (even reading ATA status register)
> requires pi_connect.

OK. Let me have a look.

-- 
Damien Le Moal
Western Digital Research

