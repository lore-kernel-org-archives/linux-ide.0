From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: stable basic 4-port SATA card
Date: Thu, 13 Dec 2007 17:37:50 +0100
Message-ID: <47615FDE.5000702@ans.pl>
References: <200711151001.lAFA11wC019059@harpo.it.uu.se>	<fjrci9$v8o$1@ger.gmane.org> <18273.15617.119611.820953@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pigeon.axelspringer.pl ([195.177.210.68]:59648 "EHLO
	mx1.axelspringer.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbXLMRFH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 12:05:07 -0500
In-Reply-To: <18273.15617.119611.820953@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Patric Karlsson <patric@ce.chalmers.se>, linux-ide@vger.kernel.org

On 2007-12-13 15:09, Mikael Pettersson wrote:
> Patric Karlsson writes:
>  > Mikael Pettersson wrote:
>  > > On Thu, 15 Nov 2007 12:32:14 +0900, Tejun Heo wrote:
>  > >> * sata_promise: Generally works okay; however there are still s=
ome
>  > >> problems with recent 3Gbps chips. (Mikael, please pitch in)
>  > >=20
>  > > Right, 2nd-gen 3Gbps chips have had "intermittent" issues,
>  > > which we hope are cured by the recent ASIC bug workaround,
>  > > but it will take a while for that fix to propagate out.
>  > > To speed up that process I'm considering backporting the fix
>  > > to 2.6.23 and 2.6.22.
>  > >=20
>  > > NCQ and PMP are supported in the hardware and in the vendor's
>  > > driver, but not yet in sata_promise. My intention is to add
>  > > NCQ soon, but there's no time-plan yet for this.
>  > >=20
>  > > /Mikael
>  > > -
>  > > To unsubscribe from this list: send the line "unsubscribe linux-=
ide" in
>  > > the body of a message to majordomo@vger.kernel.org
>  > > More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>  > >=20
>  >=20
>  > Backporting would be nice, since we're still some ways from a stab=
le=20
>  > 2.6.24, and I'm not comfortable running -rc kernels in production=20
>  > enviroments.
>=20
> Ok.
>=20
> For 2.6.23 there is one patch:
>=20
> <http://user.it.uu.se/~mikpe/linux/patches/sata_promise/patch-sata_pr=
omise-1-asic-sg-bug-fix-v3-2.6.23>
> This is the workaround for the ASIC PRD/SG bug.
>=20
> For 2.6.22 there are two patches:
>=20
> <http://user.it.uu.se/~mikpe/linux/patches/sata_promise/patch-sata_pr=
omise-1-ft_tx4200-is-gen2-2.6.22>
> This corrects the classification of FastTrack TX4200 cards,
> which in turn fixes nasty errors in how they are accessed.
>=20
> <http://user.it.uu.se/~mikpe/linux/patches/sata_promise/patch-sata_pr=
omise-2-asic-sg-bug-fix-v3-2.6.22>
> This is the workaround for the ASIC PRD/SG bug.

Maybe -stable should get this?

Best regards,

				Krzysztof Ol=EAdzki
