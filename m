From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Sun, 30 Mar 2008 10:17:31 +0900
Message-ID: <47EEEA2B.8010204@gmail.com>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org> <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu> <47EEDACA.4060400@gmail.com> <47EEE784.8090909@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:29997 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYC3BRi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 21:17:38 -0400
Received: by rv-out-0910.google.com with SMTP id k20so525221rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 18:17:37 -0700 (PDT)
In-Reply-To: <47EEE784.8090909@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Zoltan Boszormenyi <zboszor@dunaweb.hu>, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

Robert Hancock wrote:
> Tejun Heo wrote:
>> Zoltan Boszormenyi wrote:
>>> Tejun Heo =EDrta:
>>>> akpm@linux-foundation.org wrote:
>>>>> From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>>>>
>>>>> unchangelogged patch.
>>>>>
>>>>> Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>>>> Cc: Robert Hancock <hancockr@shaw.ca>
>>>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>>
>>>> Nacked-by: Tejun Heo <htejun@gmail.com>
>>>>
>>>> Sorry, there are remaining issues to resolve before enabling ADMA =
by=20
>>>> default.
>>>
>>> Sorry, this is NOT ADMA. SWNCQ is completely independent from ADMA.
>>
>> Heh, right.  Sorry about that.  I disabled ADMA on the distro I work=
=20
>> for and somehow ADMA was disabled on mainline too.  :-)
>>
>> Robert, is SWNCQ safe to turn on by default?  I personally think it'=
s=20
>> better to prefer safety over performance or optional features and=20
>> given the history of NCQ support on nv satas, I feel a bit more caut=
ious.
>>
>> Maybe we can enable SWNCQ on -mm and devel branches and disable it=20
>> late in release cycle for 2.6.26 for a trial?
>=20
> I haven't seen any problem reports, but with it disabled by default m=
ost=20
> people haven't tried it. The only way to really know is to try turnin=
g=20
> it on by default and see what shakes out.
>=20
> I'd vote to enable it by default in -mm and 2.6.26-rc and see what ha=
ppens.

Alright, Zoltan can you please repost w/ commit message fixed and=20
comment stating /* FIXME: for testing during blah blah */ added?

--=20
tejun
