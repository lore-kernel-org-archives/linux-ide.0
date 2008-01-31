From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/9] libata: implement and use SHT initializers and ops
 inheritance
Date: Thu, 31 Jan 2008 12:39:15 +0900
Message-ID: <47A142E3.3040508@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853432907-git-send-email-htejun@gmail.com> <47A0AF3E.305@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.159]:26358 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbYAaDjW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 22:39:22 -0500
Received: by po-out-1718.google.com with SMTP id c31so851918poi.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 19:39:21 -0800 (PST)
In-Reply-To: <47A0AF3E.305@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Mark Lord wrote:
> Tejun Heo wrote:
>> libata lets low level drivers build scsi_host_template and
>> ata_port_operations tables and register them with upper layers.  This
>> allows low level drivers high level of flexibility but also burdens
>> them with lots of boilerplate entries in thoes data structures.
> ..
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index 939bf1d..c365650 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -452,61 +452,28 @@ static void mv_channel_reset(struct mv_host_priv
>> *hpriv, void __iomem *mmio,
>>                   unsigned int port_no);
>>  
>>  static struct scsi_host_template mv5_sht = {
>> -    .module            = THIS_MODULE,
>> -    .name            = DRV_NAME,
>> -    .ioctl            = ata_scsi_ioctl,
>> -    .queuecommand        = ata_scsi_queuecmd,
>> -    .can_queue        = ATA_DEF_QUEUE,
>> -    .this_id        = ATA_SHT_THIS_ID,
>> +    ATA_BASE_SHT(DRV_NAME),
>>      .sg_tablesize        = MV_MAX_SG_CT / 2,
> ..
> 
> I think this will need to be re-diff'd against the latest sata_mv,
> which now has NCQ support.

No problem at all.  Just push it into #upstream.  :-)

-- 
tejun
