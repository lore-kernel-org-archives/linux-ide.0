From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Fri, 04 Mar 2011 12:36:29 +0100
Message-ID: <4D70CEBD.20803@suse.de>
References: <20110304085501.8B331F90E1@ochil.suse.de> <4D70CA38.5000904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55220 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab1CDL0f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2011 06:26:35 -0500
In-Reply-To: <4D70CA38.5000904@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 03/04/2011 12:17 PM, Sergei Shtylyov wrote:
> Hello.
>=20
> On 04-03-2011 11:55, Hannes Reinecke wrote:
>=20
>> As per SAT-3 the WWN ID should be included in the VPD page 0x83
>> (device identification) emulation.
>=20
>> Signed-off-by: Hannes Reinecke<hare@suse.de>
> [...]
>=20
>> diff --git a/include/linux/ata.h b/include/linux/ata.h
>> index 0c4929f..f62463e 100644
>> --- a/include/linux/ata.h
>> +++ b/include/linux/ata.h
> [...]
>> @@ -815,6 +817,13 @@ static inline int ata_id_has_unload(const u16 *=
id)
>>       return 0;
>>   }
>>
>> +static inline int ata_id_has_wwn(const u16 *id)
>> +{
>> +    if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) !=3D 0x4000)
>> +        return 0;
>> +    return id[ATA_ID_CSF_DEFAULT] & (1 << 8);
>=20
>    Could be compacted to:
>=20
>     return (id[ATA_ID_CSF_DEFAULT] & 0xC100) =3D=3D 0x4100;
>=20
Indeed.

Will be reposting the patch if one of the libata gods gives it's
overall assent.

Tejun?

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
