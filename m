From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/6] libsas: use ata_is_ncq() and ata_has_dma() accessors
Date: Tue, 21 Jun 2016 07:44:25 +0200
Message-ID: <5768D439.2080709@suse.de>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
 <1466422756-126637-3-git-send-email-hare@suse.de>
 <20160620154016.GJ3262@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42239 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbcFUGfh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jun 2016 02:35:37 -0400
In-Reply-To: <20160620154016.GJ3262@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>

On 06/20/2016 05:40 PM, Tejun Heo wrote:
> On Mon, Jun 20, 2016 at 01:39:12PM +0200, Hannes Reinecke wrote:
>> Use accessors instead of the raw protocol value.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>  drivers/scsi/libsas/sas_ata.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas=
_ata.c
>> index 935c430..e1da52c 100644
>> --- a/drivers/scsi/libsas/sas_ata.c
>> +++ b/drivers/scsi/libsas/sas_ata.c
>> @@ -233,15 +233,10 @@ static unsigned int sas_ata_qc_issue(struct at=
a_queued_cmd *qc)
>>  	task->task_state_flags =3D SAS_TASK_STATE_PENDING;
>>  	qc->lldd_task =3D task;
>> =20
>> -	switch (qc->tf.protocol) {
>> -	case ATA_PROT_NCQ:
>> +	if (ata_is_ncq(qc->tf.protocol))
>>  		task->ata_task.use_ncq =3D 1;
>> -		/* fall through */
>> -	case ATAPI_PROT_DMA:
>> -	case ATA_PROT_DMA:
>> +	if (ata_is_dma(qc->tf.protocol))
>>  		task->ata_task.dma_xfer =3D 1;
>> -		break;
>> -	}
>=20
> As you're cleaning it up anyway, can you please make ata_is_*()
> functions return bool and do
>=20
> 	task->ata_task.use_ncq =3D ata_is_ncq()
>=20
> instead?
>=20
Sure, will do with the next round.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
