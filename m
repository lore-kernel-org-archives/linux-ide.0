From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] libata: fixup oops in ata_eh_link_report()
Date: Mon, 19 Jan 2015 15:53:12 +0100
Message-ID: <54BD1A58.3000708@suse.de>
References: <1421668859-4593-1-git-send-email-hare@suse.de> <20150119143738.GA979@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150119143738.GA979@swordfish>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 01/19/2015 03:37 PM, Sergey Senozhatsky wrote:
> On (01/19/15 13:00), Hannes Reinecke wrote:
>> Date: Mon, 19 Jan 2015 13:00:59 +0100
>> From: Hannes Reinecke <hare@suse.de>
>> To: Tejun Heo <tj@kernel.org>
>> Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey
>>  Senozhatsky <sergey.senozhatsky@gmail.com>, Hannes Reinecke <hare@s=
use.de>
>> Subject: [PATCH] libata: fixup oops in ata_eh_link_report()
>> X-Mailer: git-send-email 1.8.5.2
>>
>> We should only try to evaluate the cdb if this is an ATAPI
>> device, for any other device the 'cdb' field and the cdb_len
>> has no meaning.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/ata/libata-eh.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 9179f11..584c6ae 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -2481,8 +2481,6 @@ static void ata_eh_link_report(struct ata_link=
 *link)
>>  	for (tag =3D 0; tag < ATA_MAX_QUEUE; tag++) {
>>  		struct ata_queued_cmd *qc =3D __ata_qc_from_tag(ap, tag);
>>  		struct ata_taskfile *cmd =3D &qc->tf, *res =3D &qc->result_tf;
>> -		const u8 *cdb =3D qc->cdb;
>> -		size_t cdb_len =3D qc->dev->cdb_len;
>>  		char data_buf[20] =3D "";
>>  		char cdb_buf[70] =3D "";
>> =20
>> @@ -2510,6 +2508,9 @@ static void ata_eh_link_report(struct ata_link=
 *link)
>>  		}
>> =20
>>  		if (ata_is_atapi(qc->tf.protocol)) {
>> +			const u8 *cdb =3D qc->cdb;
>> +			size_t cdb_len =3D qd->dev->cdb_len;
>=20
> I think, it supposed to be qc, not qd.
>=20
Bzzt.

Of course.

I'll be redoing the patch, and will be adding the original commit id
as indicated by Tejun.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
