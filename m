From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 5/9] libata: implement and use SHT initializers and ops
 inheritance
Date: Wed, 30 Jan 2008 23:04:59 -0500
Message-ID: <47A148EB.10203@rtr.ca>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853432907-git-send-email-htejun@gmail.com> <47A0AF3E.305@rtr.ca> <47A142E3.3040508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1470 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794AbYAaEFD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jan 2008 23:05:03 -0500
In-Reply-To: <47A142E3.3040508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> libata lets low level drivers build scsi_host_template and
>>> ata_port_operations tables and register them with upper layers.  This
>>> allows low level drivers high level of flexibility but also burdens
>>> them with lots of boilerplate entries in thoes data structures.
>> ..
>>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>>> index 939bf1d..c365650 100644
>>> --- a/drivers/ata/sata_mv.c
>>> +++ b/drivers/ata/sata_mv.c
>>> @@ -452,61 +452,28 @@ static void mv_channel_reset(struct mv_host_priv
>>> *hpriv, void __iomem *mmio,
>>>                   unsigned int port_no);
>>>  
>>>  static struct scsi_host_template mv5_sht = {
>>> -    .module            = THIS_MODULE,
>>> -    .name            = DRV_NAME,
>>> -    .ioctl            = ata_scsi_ioctl,
>>> -    .queuecommand        = ata_scsi_queuecmd,
>>> -    .can_queue        = ATA_DEF_QUEUE,
>>> -    .this_id        = ATA_SHT_THIS_ID,
>>> +    ATA_BASE_SHT(DRV_NAME),
>>>      .sg_tablesize        = MV_MAX_SG_CT / 2,
>> ..
>>
>> I think this will need to be re-diff'd against the latest sata_mv,
>> which now has NCQ support.
> 
> No problem at all.  Just push it into #upstream.  :-)
..

Oh, it is/was already there.  And I quoted the wrong lines from your patch.
Let's try again:
>
>  static struct scsi_host_template mv6_sht = {
> -       .module                 = THIS_MODULE,
> -       .name                   = DRV_NAME,
> -       .ioctl                  = ata_scsi_ioctl,
> -       .queuecommand           = ata_scsi_queuecmd,
> -       .can_queue              = ATA_DEF_QUEUE,
> -       .this_id                = ATA_SHT_THIS_ID,
> +       ATA_BASE_SHT(DRV_NAME),
>         .sg_tablesize           = MV_MAX_SG_CT / 2,
> -       .cmd_per_lun            = ATA_SHT_CMD_PER_LUN,
> -       .emulated               = ATA_SHT_EMULATED,
> -       .use_clustering         = 1,
> -       .proc_name              = DRV_NAME,
>         .dma_boundary           = MV_DMA_BOUNDARY,
> -       .slave_configure        = ata_scsi_slave_config,
> -       .slave_destroy          = ata_scsi_slave_destroy,
> -       .bios_param             = ata_std_bios_param,
>  };

That doesn't look correct.  :)
Shouldn't it be ATA_NCQ_SHT(DRV_NAME) there?

Cheers




