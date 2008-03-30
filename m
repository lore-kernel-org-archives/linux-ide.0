From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Sat, 29 Mar 2008 19:06:12 -0600
Message-ID: <47EEE784.8090909@shaw.ca>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org>
 <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu>
 <47EEDACA.4060400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:28676 "EHLO
	pd3mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbYC3BG4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 21:06:56 -0400
Received: from pd3mr2so.prod.shaw.ca
 (pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JYI00FSSR2O3F30@l-daemon> for linux-ide@vger.kernel.org; Sat,
 29 Mar 2008 19:06:24 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
 by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JYI00ENQR2OHX70@pd3mr2so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Sat, 29 Mar 2008 19:06:25 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JYI00CAKR2NLU50@l-daemon> for linux-ide@vger.kernel.org; Sat,
 29 Mar 2008 19:06:23 -0600 (MDT)
In-reply-to: <47EEDACA.4060400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

Tejun Heo wrote:
> Zoltan Boszormenyi wrote:
>> Tejun Heo =EDrta:
>>> akpm@linux-foundation.org wrote:
>>>> From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>>>
>>>> unchangelogged patch.
>>>>
>>>> Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>>> Cc: Robert Hancock <hancockr@shaw.ca>
>>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>
>>> Nacked-by: Tejun Heo <htejun@gmail.com>
>>>
>>> Sorry, there are remaining issues to resolve before enabling ADMA b=
y=20
>>> default.
>>
>> Sorry, this is NOT ADMA. SWNCQ is completely independent from ADMA.
>=20
> Heh, right.  Sorry about that.  I disabled ADMA on the distro I work =
for=20
> and somehow ADMA was disabled on mainline too.  :-)
>=20
> Robert, is SWNCQ safe to turn on by default?  I personally think it's=
=20
> better to prefer safety over performance or optional features and giv=
en=20
> the history of NCQ support on nv satas, I feel a bit more cautious.
>=20
> Maybe we can enable SWNCQ on -mm and devel branches and disable it la=
te=20
> in release cycle for 2.6.26 for a trial?

I haven't seen any problem reports, but with it disabled by default mos=
t=20
people haven't tried it. The only way to really know is to try turning=20
it on by default and see what shakes out.

I'd vote to enable it by default in -mm and 2.6.26-rc and see what happ=
ens.
