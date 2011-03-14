From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] libata: Include WWN ID in inquiry VPD emulation
Date: Mon, 14 Mar 2011 16:56:23 +0100
Message-ID: <4D7E3AA7.2020706@suse.de>
References: <20110304085501.8B331F90E1@ochil.suse.de> <20110304170904.GW20499@htj.dyndns.org> <4D711FD7.6080507@pobox.com> <4D748FF8.1070903@suse.de> <4D7496FD.6040202@pobox.com> <4D749CFA.3050104@suse.de> <4D7DBD5D.4070803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34098 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500Ab1CNP4Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Mar 2011 11:56:25 -0400
In-Reply-To: <4D7DBD5D.4070803@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 03/14/2011 08:01 AM, Jeff Garzik wrote:
> On 03/07/2011 03:53 AM, Hannes Reinecke wrote:
>> On 03/07/2011 09:27 AM, Jeff Garzik wrote:
>>> On 03/07/2011 02:57 AM, Hannes Reinecke wrote:
>>>> On 03/04/2011 06:22 PM, Jeff Garzik wrote:
>>>>> And if you're highly motivated, a separate patch to update
>>>>> include/linux/ata.h to return bool for obvious ata_id_has_xxx
>>>>> functions
>>>>> would be nice too.
>>>
>>>> Like this?
>>>
>>>> -static inline int ata_id_has_fua(const u16 *id)
>>>> +static inline bool ata_id_has_fua(const u16 *id)
>>>>   {
>>>>       if ((id[ATA_ID_CFSSE]&  0xC000) !=3D 0x4000)
>>>>           return 0;
>>>>       return id[ATA_ID_CFSSE]&  (1<<  6);
>>>>   }
>>>
>>> Not _quite_ that easy...  one must also s/0/false/ and s/1/true/ wh=
ere
>>> the return value is explicit, rather than the result of an expressi=
on.
>>>
>> Ok, there you go.
>=20
> looks good, except for the part where it doesn't build ;)
>=20
Ach, building is _much_ overrated.
Proving with sound mathematical principles that is _must_ work
is much more satisfying.

> Make that micro-fix, and resend as a normal patch, and I'll apply
> straightaway.
>=20
>=20


--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
