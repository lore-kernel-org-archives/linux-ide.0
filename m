From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 04/10] ata: add ata_is_fpdma() accessor
Date: Thu, 14 Jul 2016 18:01:46 +0200
Message-ID: <5787B76A.7020500@suse.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
 <1468454751-12466-5-git-send-email-hch@lst.de>
 <20160714143756.GF15005@htj.duckdns.org> <5787ACA7.9050808@suse.com>
 <20160714151913.GL15005@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51674 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbcGNQBw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jul 2016 12:01:52 -0400
In-Reply-To: <20160714151913.GL15005@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, damien.lemoal@hgst.com, linux-ide@vger.kernel.org

On 07/14/2016 05:19 PM, Tejun Heo wrote:
> Hello, Hannes.
>=20
> On Thu, Jul 14, 2016 at 05:15:51PM +0200, Hannes Reinecke wrote:
>>>> +static inline bool ata_is_fpdma(u8 prot)
>>>> +{
>>>> +	return ata_prot_flags(prot) & ATA_PROT_FLAG_FPDMA;
>>>> +}
>>>
>>> ???
>>>
>> Yeah, strictly speaking there is no need for ATA_PROT_FLAG_FPDMA.
>> I'll be removing it if you insist.
>=20
> No, it's just really confusing to have a function named ata_is_fpdma(=
)
> and then have it test whether the protocol is NCQ or DMA.  If you
> wanna do that, name it ata_is_dma_or_fpdma().  ata_is_fpdma() should
> test (prot & ATA_PROT_FLAG_FPDMA) =3D=3D ATA_PROT_FLAG_FPDMA.
>=20
Ah. Now I see your point.

That was unintentional, and your suggestion is in fact correct.
I'll be fixing it up.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
