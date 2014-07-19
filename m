From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v10 0/8] ARM: berlin: add AHCI support
Date: Sat, 19 Jul 2014 11:03:39 +0200
Message-ID: <53CA346B.1050802@gmail.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com> <20140718135758.GB13012@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:45021 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757620AbaGSJDe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jul 2014 05:03:34 -0400
In-Reply-To: <20140718135758.GB13012@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, =?ISO-8859-1?Q?Antoine_T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On 07/18/2014 03:57 PM, Tejun Heo wrote:
> On Fri, Jul 18, 2014 at 02:29:59PM +0200, Antoine T=E9nart wrote:
>> In both cases we do not have time to do this for the next release, a=
s
>> the request popped up quite late.
>>
>> So as of now:
>>   - Either the series is merged as is and changes to the AHCI framew=
ork
>>     can be made for 3.18, as it's not particularly linked to this
>>     series.
>>   - Or you really do not want it. Then that would be great if patche=
s
>>     1-2 and 7-8 could be merged so that we do not end up with this b=
ig
>>     series going for yet another cycle... I think Kishon already too=
k
>>     patches 1-2.
>=20
> I don't wanna take in code which isn't in the shape that it should be=
=2E
> Things like this accumulate to become a large maintenance burden over
> time.  Sure, urgent things can slip in and then later be fixed up but
> who are gonna do that here?  You guys already seem to be under time
> pressure as it is.
>=20
> If you guys can figure something out with Hans regarding how to
> proceed on this, I'll be happy take the code as is.

I cannot say much about AHCI, but if the PHY driver is fine I can
take the DT patches adding it to BG2Q and BG2Q-DMP at any time.

Sebastian

