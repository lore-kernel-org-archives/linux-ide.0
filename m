From: "Kuan Luo" <kluo@nvidia.com>
Subject: RE: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Mon, 31 Mar 2008 10:58:55 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B1BFE2AF1@hkemmail01.nvidia.com>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org> <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu> <47EEDACA.4060400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.112.152]:19979 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbYCaDEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2008 23:04:08 -0400
In-Reply-To: <47EEDACA.4060400@gmail.com>
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, hancockr@shaw.ca, Peer Chen <pchen@nvidia.com>

=46or ADMA, I lean to disable it for default because stability is more =
important to our customers. At least, bug in this link: http://www.goss=
amer-threads.com/lists/linux/kernel/885929  is not resolved.

Best regards,
Kuan Luo
=20

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com]=20
> Sent: Sunday, March 30, 2008 8:12 AM
> To: Zoltan Boszormenyi
> Cc: akpm@linux-foundation.org; jeff@garzik.org;=20
> linux-ide@vger.kernel.org; hancockr@shaw.ca; Kuan Luo; Peer Chen
> Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
>=20
> Zoltan Boszormenyi wrote:
> > Tejun Heo =EDrta:
> >> akpm@linux-foundation.org wrote:
> >>> From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
> >>>
> >>> unchangelogged patch.
> >>>
> >>> Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
> >>> Cc: Robert Hancock <hancockr@shaw.ca>
> >>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >>
> >> Nacked-by: Tejun Heo <htejun@gmail.com>
> >>
> >> Sorry, there are remaining issues to resolve before=20
> enabling ADMA by=20
> >> default.
> >=20
> > Sorry, this is NOT ADMA. SWNCQ is completely independent from ADMA.
>=20
> Heh, right.  Sorry about that.  I disabled ADMA on the distro=20
> I work for=20
> and somehow ADMA was disabled on mainline too.  :-)
>=20
> Robert, is SWNCQ safe to turn on by default?  I personally think it's=
=20
> better to prefer safety over performance or optional features=20
> and given=20
> the history of NCQ support on nv satas, I feel a bit more cautious.
>=20
> Maybe we can enable SWNCQ on -mm and devel branches and=20
> disable it late=20
> in release cycle for 2.6.26 for a trial?
>=20
> Kuan Luo and Peer Chen, what do you guys think about this? =20
> And can you=20
> guys please find a way to assist Robert in fixing the ADMA problems?=20
> For 2.6.25, we're too late to disable it.  For 2.6.26, I'm afraid we=20
> will have to disable it unless those known issues are solved.  :-(
>=20
> Thanks.
>=20
> --=20
> tejun
>=20
-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
