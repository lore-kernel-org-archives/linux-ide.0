From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/9] libata: implement and use SHT initializers and ops
 inheritance
Date: Thu, 31 Jan 2008 13:12:15 +0900
Message-ID: <47A14A9F.5070405@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853432907-git-send-email-htejun@gmail.com> <47A0AF3E.305@rtr.ca> <47A142E3.3040508@gmail.com> <47A148EB.10203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.153]:47001 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960AbYAaEMX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 23:12:23 -0500
Received: by po-out-1718.google.com with SMTP id c31so867257poi.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 20:12:22 -0800 (PST)
In-Reply-To: <47A148EB.10203@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Mark Lord wrote:
>>> I think this will need to be re-diff'd against the latest sata_mv,
>>> which now has NCQ support.
>>
>> No problem at all.  Just push it into #upstream.  :-)
> ..
> 
> Oh, it is/was already there.  And I quoted the wrong lines from your patch.
> Let's try again:

Is it?  I don't see it in my copy of #upstream which I synced yesterday.
 Pulling again... Oh.. it's there.  I must have made a mistake while
pulling yesterday.

>>  static struct scsi_host_template mv6_sht = {
>> -       .module                 = THIS_MODULE,
>> -       .name                   = DRV_NAME,
>> -       .ioctl                  = ata_scsi_ioctl,
>> -       .queuecommand           = ata_scsi_queuecmd,
>> -       .can_queue              = ATA_DEF_QUEUE,
>> -       .this_id                = ATA_SHT_THIS_ID,
>> +       ATA_BASE_SHT(DRV_NAME),
>>         .sg_tablesize           = MV_MAX_SG_CT / 2,
>> -       .cmd_per_lun            = ATA_SHT_CMD_PER_LUN,
>> -       .emulated               = ATA_SHT_EMULATED,
>> -       .use_clustering         = 1,
>> -       .proc_name              = DRV_NAME,
>>         .dma_boundary           = MV_DMA_BOUNDARY,
>> -       .slave_configure        = ata_scsi_slave_config,
>> -       .slave_destroy          = ata_scsi_slave_destroy,
>> -       .bios_param             = ata_std_bios_param,
>>  };
> 
> That doesn't look correct.  :)
> Shouldn't it be ATA_NCQ_SHT(DRV_NAME) there?

On top of a984f58dd97f22f5113700322fed311a0ee29947, it is correct
because .can_queue is ATA_DEF_QUEUE and no queue_depth callback is
specified.  Anyways, after review, I'll regenerate the patchset on top
of the current sata_mv.

Thanks.

-- 
tejun
