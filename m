From: Grant Grundler <grundler@google.com>
Subject: Re: Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier (PMP) Not
	working
Date: Thu, 27 Aug 2009 09:53:45 -0700
Message-ID: <da824cf30908270953q4e782344t96bc9a7221ef1718@mail.gmail.com>
References: <e3fccfde0908101354y4e98a985nc119d8941e8b1665@mail.gmail.com>
	 <4A8242C5.3060605@gmail.com>
	 <e3fccfde0908121536wbacde3bt447c3b8e769f184d@mail.gmail.com>
	 <da824cf30908171425i3ec9237bi1370e71d5096c174@mail.gmail.com>
	 <e3fccfde0908171530w43f78711lea85ffa1ea26d2ea@mail.gmail.com>
	 <da824cf30908171939o7110322bn993dc5d3217a4cfa@mail.gmail.com>
	 <e3fccfde0908181454w3e45ef65ucf2b5173d97d10eb@mail.gmail.com>
	 <da824cf30908251528h25c2dffcp9943abd4af85cb52@mail.gmail.com>
	 <4A961F60.8080400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:20093 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbZH0Qxt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Aug 2009 12:53:49 -0400
Received: from spaceape7.eur.corp.google.com (spaceape7.eur.corp.google.com [172.28.16.141])
	by smtp-out.google.com with ESMTP id n7RGro4Y002778
	for <linux-ide@vger.kernel.org>; Thu, 27 Aug 2009 09:53:50 -0700
Received: from pxi13 (pxi13.prod.google.com [10.243.27.13])
	by spaceape7.eur.corp.google.com with ESMTP id n7RGrlHI010100
	for <linux-ide@vger.kernel.org>; Thu, 27 Aug 2009 09:53:47 -0700
Received: by pxi13 with SMTP id 13so1108570pxi.10
        for <linux-ide@vger.kernel.org>; Thu, 27 Aug 2009 09:53:46 -0700 (PDT)
In-Reply-To: <4A961F60.8080400@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Chris K <kayex@rogers.com>, Linux IDE <linux-ide@vger.kernel.org>

On Wed, Aug 26, 2009 at 10:53 PM, Tejun Heo<tj@kernel.org> wrote:
=2E..
>> I don't believe port ata7.05 exists. AFAIK, =C2=A0sil3736 only has 5=
 ports (0 to 4).
>> One of the quirks isn't applying or needs to be added to the kernel.
>> I don't recall what the psuedo port is for but Tejun or "Sans Digita=
l
>> TRM4-B" vendor might know.
>>
>> I think this comment in libata-pmp.c might be relevant:
>> =C2=A0 =C2=A0 =C2=A0/* port 5 is for SEMB device and it doesn't like=
 SRST */
>>
>> But it looks like port 5 isn't responding at all. You might add a ha=
ck to change
>> "6" to "5" inside the "sil3726 quirks" code chunk.
>
> Ah... right, it's the SEMB port which is causing the problem. =C2=A0I=
 left
> it there just in case someone would extend on it and make it useful,
> which never really happened and given the general flakiness of this
> first generation PMPs, I think we would be better off simply disablin=
g
> these SEMB and configuration devices altogether. =C2=A0Any objections=
?

No objection.

Just some thoughts:
How can we find out if anyone has the SEMB properly wired up?
Would it be hard to make libata aware of "SEMB port not responding" cas=
e?
ie if the SEMB port times out or has no link, reduce the port count of
the sil3726 PMP by one.

Maybe add a "enable_sil24_semb" flag to libata?
(avoid checking unless someone asks for it). I hate magic flags but als=
o
don't want to subject most people to the timeout delay.

hth,
grant
