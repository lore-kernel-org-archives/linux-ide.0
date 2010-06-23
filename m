From: Tejun Heo <tj@kernel.org>
Subject: Re: ata link not reset properly
Date: Wed, 23 Jun 2010 19:28:09 +0200
Message-ID: <4C224429.6010705@kernel.org>
References: <4C223F8A.9030306@odi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45589 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532Ab0FWR2S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jun 2010 13:28:18 -0400
In-Reply-To: <4C223F8A.9030306@odi.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On 06/23/2010 07:08 PM, Ortwin Gl=FCck wrote:
>>From time to time this nVidia SATA controller chokes on a FLUSH CACHE=
=2E
>=20
> 1. why does the kernel not try to HARD reset the link?

Because hardreset sometimes brings the link completely offline on
sata_nv's.  Hardreset on sata_nv controllers is quite fragile.

> 2. it would be nice to have the possibility to manually force a
> (hard) reset or to re-initialize the device. Other than rebooting I
> mean :-)

Maybe we can use hardreset as the last resort before ditching the
device.  Something like the following.  Can you please try it and post
the kernel log?  Thanks.

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 2116113..5105951 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1587,7 +1587,7 @@ static int nv_hardreset(struct ata_link *link, un=
signed int *class,
         * comment above port ops for details.
         */
        if (!(link->ap->pflags & ATA_PFLAG_LOADING) &&
-           !ata_dev_enabled(link->device))
+           (!ata_dev_enabled(link->device) || ehc->tries[0] =3D=3D 1))
                sata_link_hardreset(link, sata_deb_timing_hotplug, dead=
line,
                                    NULL, NULL);
        else {

--=20
tejun
