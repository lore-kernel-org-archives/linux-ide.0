From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 3/3] ata: SWNCQ should be enabled by default
Date: Sun, 30 Mar 2008 09:11:54 +0900
Message-ID: <47EEDACA.4060400@gmail.com>
References: <200803282133.m2SLXlWk011463@imap1.linux-foundation.org> <47EE465E.80401@gmail.com> <47EE88C9.3020805@dunaweb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:3935 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbYC3AL7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 20:11:59 -0400
Received: by wf-out-1314.google.com with SMTP id 28so874864wff.4
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 17:11:59 -0700 (PDT)
In-Reply-To: <47EE88C9.3020805@dunaweb.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, hancockr@shaw.ca, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

Zoltan Boszormenyi wrote:
> Tejun Heo =EDrta:
>> akpm@linux-foundation.org wrote:
>>> From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>>
>>> unchangelogged patch.
>>>
>>> Signed-off-by: Zoltan Boszormenyi <zboszor@dunaweb.hu>
>>> Cc: Robert Hancock <hancockr@shaw.ca>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>
>> Nacked-by: Tejun Heo <htejun@gmail.com>
>>
>> Sorry, there are remaining issues to resolve before enabling ADMA by=
=20
>> default.
>=20
> Sorry, this is NOT ADMA. SWNCQ is completely independent from ADMA.

Heh, right.  Sorry about that.  I disabled ADMA on the distro I work fo=
r=20
and somehow ADMA was disabled on mainline too.  :-)

Robert, is SWNCQ safe to turn on by default?  I personally think it's=20
better to prefer safety over performance or optional features and given=
=20
the history of NCQ support on nv satas, I feel a bit more cautious.

Maybe we can enable SWNCQ on -mm and devel branches and disable it late=
=20
in release cycle for 2.6.26 for a trial?

Kuan Luo and Peer Chen, what do you guys think about this?  And can you=
=20
guys please find a way to assist Robert in fixing the ADMA problems?=20
=46or 2.6.25, we're too late to disable it.  For 2.6.26, I'm afraid we=20
will have to disable it unless those known issues are solved.  :-(

Thanks.

--=20
tejun
