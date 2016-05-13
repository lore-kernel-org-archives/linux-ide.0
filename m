From: Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCHv3 12/14] libata: NCQ encapsulation for ZAC MANAGEMENT OUT
Date: Fri, 13 May 2016 10:53:40 +0200
Message-ID: <57359614.704@suse.com>
References: <1461581156-92581-1-git-send-email-hare@suse.de>
 <1461581156-92581-13-git-send-email-hare@suse.de>
 <81AF36B5-A610-4E04-A4E7-F9DB47D6E73F@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56808 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbcEMIx5 (ORCPT
	<rfc822;groupwise-linux-ide@vger.kernel.org:0:0>);
	Fri, 13 May 2016 04:53:57 -0400
In-Reply-To: <81AF36B5-A610-4E04-A4E7-F9DB47D6E73F@hgst.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <Damien.LeMoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>

On 05/13/2016 10:32 AM, Damien Le Moal wrote:
>
> Hannes,
>
>> Add NCQ encapsulation for ZAC MANAGEMENT OUT and evaluate
>> NCQ Non-Data log pages to figure out if NCQ encapsulation
>> is supported.
> ...
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 6afd084..43403aa 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3506,11 +3506,19 @@ static unsigned int ata_scsi_zbc_out_xlat(struct ata_queued_cmd *qc)
>>
>> 	reset_all = cdb[14] & 0x1;
>>
>> -	tf->protocol = ATA_PROT_NODATA;
>> -	tf->command = ATA_CMD_ZAC_MGMT_OUT;
>> -	tf->feature = sa;
>> -	tf->hob_feature = reset_all & 0x1;
>> -
>> +	if (ata_ncq_enabled(qc->dev) &&
>> +	    ata_fpdma_zac_mgmt_out_supported(qc->dev)) {
>> +		tf->protocol = ATA_PROT_NCQ;
>> +		tf->command = ATA_CMD_NCQ_NON_DATA;
>> +		tf->hob_nsect = ATA_SUBCMD_NCQ_NON_DATA_ZAC_MGMT_OUT;
>> +		tf->nsect = qc->tag << 3;
>> +		tf->auxiliary = sa | (reset_all & 0x1) << 8;
>> +	} else {
>> +		tf->protocol = ATA_PROT_NODATA;
>> +		tf->command = ATA_CMD_ZAC_MGMT_OUT;
>> +		tf->feature = sa;
>> +		tf->hob_feature = reset_all & 0x1;
>> +	}
>
> Calls to ata_is_data(prot) for ATA_PROT_NCQ task files will always
> return "true", even if the command is ATA_CMD_NCQ_NON_DATA (because
> the DMA prot flag is always set by ata_prot_flags for NCQ protocol).
> This result in all the ATA_CMD_ZAC_MGMT_OUT commands to fail in
> ata_qc_issue because of the check:
>
>          if (WARN_ON_ONCE(ata_is_data(prot) &&
>                           (!qc->sg || !qc->n_elem || !qc->nbytes)))
>                  goto sys_err;
>
>
> I am not sure the best way to fix this... Hacking ata_qc_issue using the protocol
> AND command code to define a bool "is_data" prevents the error but ata_is_data is
> also used in different drivers so a more solid fix seem necessary.
>
> Adding a new ATA_PROT_NCQ_NODATA for ATA_CMD_NCQ_NON_DATA would be better, but this
> does not really correspond to anything in the standards. And with this, the error
> moves to the command sg dma setup complaining that the DMA direction is not known.
> Any ideas ?
>
Hmm. Isn't there simply an 'ATA_TFLAG_WRITE' missing in tf->flags later on?

>
> Also, the "& 0x1" in "tf->auxiliary = sa | (reset_all & 0x1) << 8;" is not necessary
> since reset_all is initialized already as "reset_all = cdb[14] & 0x1;"
>
Yeah. We can fix it up.

Cheers,

Hannes

