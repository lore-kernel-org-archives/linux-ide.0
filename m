From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 05/25] ata: add the SW NCQ support to sata_nv for MCP51/MCP55/MCP61
Date: Tue, 25 Sep 2007 23:48:56 -0400
Message-ID: <46F9D6A8.8010809@garzik.org>
References: <200708102059.l7AKxYVQ008581@imap1.linux-foundation.org> <46F2F6E5.3010406@garzik.org> <46F35C7F.20400@dunaweb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39368 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755042AbXIZDtE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 23:49:04 -0400
In-Reply-To: <46F35C7F.20400@dunaweb.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: akpm@linux-foundation.org, kluo@nvidia.com, pchen@nvidia.com, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

Zoltan Boszormenyi wrote:
> Hi,
>=20
> Jeff Garzik =EDrta:
>> akpm@linux-foundation.org wrote:
>>> From: Kuan Luo <kluo@nvidia.com>
>>>
>>> Add the Software NCQ support to sata_nv.c for MCP51/MCP55/MCP61 SAT=
A
>>> controller.  NCQ function is disable by default, you can enable it =
with
>>> 'swncq=3D1'.  NCQ will be turned off if the drive is Maxtor on MCP5=
1 or=20
>>> MCP55
>>> rev 0xa2 platform.
>>>
>>> [akpm@linux-foundation.org: build fix]
>>> Signed-off-by: Kuan Luo <kluo@nvidia.com>
>>> Signed-off-by: Peer Chen <pchen@nvidia.com>
>>> Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>
>>>  drivers/ata/sata_nv.c |  860 +++++++++++++++++++++++++++++++++++++=
++-
>>>  1 files changed, 851 insertions(+), 9 deletions(-)
>>
>> I finally gave this a thorough review.
>>
>> Overall, good work.  The state transitions all seem solid.  I made=20
>> several minor changes and cleanups, and checked it into the 'nv-swnc=
q'=20
>> branch of=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> Two hurdles before I'm ready to push upstream:
>>
>> * someone please verify my minor changes did not break anything; I=20
>> don't have real hardware
>=20
> After reading the diff between the original and your cleaned up versi=
on
> it seems both the change from 4 individual flags to a single integer =
and=20
> the
> nv_swncq_bmdma_stop() -> __ata_bmdma_stop() transition are obviously=20
> correct.
> I attached a small cleanup patch which may make one check a bit more=20
> readable.
>=20
> However, can you explain this chunk below? Why isn't it needed?
>=20
> @@ -615,7 +622,6 @@ static const struct ata_port_info nv_por
>        {
>                .sht            =3D &nv_swncq_sht,
>                .flags          =3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY=
,
> -               .link_flags     =3D ATA_LFLAG_HRST_TO_RESUME,
>                .pio_mask       =3D NV_PIO_MASK,
>                .mwdma_mask     =3D NV_MWDMA_MASK,
>                .udma_mask      =3D NV_UDMA_MASK,

that's a bug.  fixed.

I also applied your cleanup.


