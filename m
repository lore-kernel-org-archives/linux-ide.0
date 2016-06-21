From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/6] ata: fixup ATA_PROT_NODATA
Date: Tue, 21 Jun 2016 07:52:30 +0200
Message-ID: <5768D61E.1060203@suse.de>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
 <1466422756-126637-5-git-send-email-hare@suse.de>
 <20160620154426.GL3262@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38413 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbcFUFw7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jun 2016 01:52:59 -0400
In-Reply-To: <20160620154426.GL3262@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org

On 06/20/2016 05:44 PM, Tejun Heo wrote:
> On Mon, Jun 20, 2016 at 01:39:14PM +0200, Hannes Reinecke wrote:
>> The taskfile protocol is a numeric value, and can not be ORed.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/ata/libata-core.c | 4 ++--
>>  drivers/ata/libata-eh.c   | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index e798915..d200102 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -1238,7 +1238,7 @@ static int ata_read_native_max_address(struct =
ata_device *dev, u64 *max_sectors)
>>  	} else
>>  		tf.command =3D ATA_CMD_READ_NATIVE_MAX;
>> =20
>> -	tf.protocol |=3D ATA_PROT_NODATA;
>> +	tf.protocol =3D ATA_PROT_NODATA;
>>  	tf.device |=3D ATA_LBA;
>=20
> Did the above lead to any actual brekage or was tf.protocol guarantee=
d
> to be zero always?  I wish the patch description described what the
> stake of the patch is.
>=20
This is actually a cleanup; if tf.protocl is '0' we won't see any issue=
s
here.
But if (for some obsure reason) tf.protocol is _not_ zero we'll run int=
o
very obscure problems.
Plus the OR here might give others the wrong impression, and might lead
to a confusion between ATA_PROT_XXX (which is a scalar value and cannot
be ORed) and ATA_PROT_FLAG_XXX (which is a bit value and can be ORed).

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
