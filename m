From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/6] ata: add ata_is_fpdma() accessor
Date: Tue, 21 Jun 2016 07:49:26 +0200
Message-ID: <5768D566.9070207@suse.de>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
 <1466422756-126637-4-git-send-email-hare@suse.de>
 <20160620154249.GK3262@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37960 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932484AbcFUFuj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jun 2016 01:50:39 -0400
In-Reply-To: <20160620154249.GK3262@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>

On 06/20/2016 05:42 PM, Tejun Heo wrote:
> On Mon, Jun 20, 2016 at 01:39:13PM +0200, Hannes Reinecke wrote:
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index d15c19e..264414c 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -152,6 +152,7 @@ enum {
>>  	ATA_PROT_FLAG_DATA	=3D ATA_PROT_FLAG_PIO | ATA_PROT_FLAG_DMA,
>>  	ATA_PROT_FLAG_NCQ	=3D (1 << 2), /* is NCQ */
>>  	ATA_PROT_FLAG_ATAPI	=3D (1 << 3), /* is ATAPI */
>> +	ATA_PROT_FLAG_FPDMA	=3D ATA_PROT_FLAG_NCQ | ATA_PROT_FLAG_DMA,
>> =20
>>  	/* struct ata_device stuff */
>>  	ATA_DFLAG_LBA		=3D (1 << 0), /* device supports LBA */
>> @@ -1093,6 +1094,11 @@ static inline int ata_is_data(u8 prot)
>>  	return ata_prot_flags(prot) & ATA_PROT_FLAG_DATA;
>>  }
>> =20
>> +static inline int ata_is_fpdma(u8 prot)
>> +{
>> +	return ata_prot_flags(prot) & ATA_PROT_FLAG_FPDMA;
>> +}
>> +
>=20
> This is NCQ or DMA which isn't the same thing as some of the tests
> it's replacing.  Is this intentional?
>=20
Yes. Most of the SATA drivers (with the exception of ahci) don't know
about NCQ NON DATA commands, so they use the test for 'NCQ' as a
shorthand for 'NCQ command with DMA data'.
With the introduction of the ATA_PROT_NODATA protocol variable these tw=
o
are no longer equivalent, as you can have NCQ commands without DMA.
As I haven't vetted any of those adapters for NCQ NON DATA commands, an=
d
these driver internally also assume that any NCQ command will have
DMA-able data, I thought it prudent to introduce an ata_is_fpdma() flag=
,
which retains the original meaning of ata_is_ncq().

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
