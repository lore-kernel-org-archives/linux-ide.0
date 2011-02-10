From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 13:49:01 +0100
Message-ID: <AANLkTikL6rGvg7PeCzJPAaWm9-4dniCY4NErGUgi_54N@mail.gmail.com>
References: <4D51A648.20707@cfl.rr.com>
	<20110209085935.GE6558@htj.dyndns.org>
	<4D52B0B3.40900@cfl.rr.com>
	<20110209153714.558133d7@lxorguk.ukuu.org.uk>
	<4D52ECB6.4010408@cfl.rr.com>
	<20110209211351.3d7eff85@lxorguk.ukuu.org.uk>
	<4D5306F8.6050106@cfl.rr.com>
	<20110209213904.4aff945d@lxorguk.ukuu.org.uk>
	<4D532FFC.2020503@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34521 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab1BJMtD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 07:49:03 -0500
Received: by qyj19 with SMTP id 19so2288995qyj.19
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2011 04:49:02 -0800 (PST)
In-Reply-To: <4D532FFC.2020503@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Feb 10, 2011 at 1:23 AM, Phillip Susi <psusi@cfl.rr.com> wrote:
> On 02/09/2011 04:39 PM, Alan Cox wrote:
>>
>> The old IDE driver defaulted to unlocking based upon years of experi=
ence
>> in the real world. Jeff insisted on being different, and surprise
>> surprise everyone ended up setting distro defaults that were differe=
nt.
>
> What experience? =A0The only reason that I have heard for unlocking i=
t is to
> maintain compatibility with the old ide driver which did so. =A0What =
reason
> does Linux have to access an area of the disk that the system has mad=
e clear
> it should not? =A0Aside from the upgrade case, I can not see any upsi=
de to
> this, only the downside of breaking on systems that work fine on Wind=
ows,
> because it does not disregard the platform request to leave that part=
 of the
> disk alone.

I wish it was so simple.. HPA was originally used for accessing disk
area > 128GB (so default to unlock) on systems with buggy BIOSes and
then on some laptops vendors started to use it in _theirs_ Windows
versions for recovery area (so default to lock!), somewhere in between
fakeraid vendors came in to the game and finally we had conflicting
Linux defaults more as a result of premature deployment by some
distributions than a policy decision (since there were no feature
implemented to make a policy decision for).. oh and please do not
forget about distribution upgrades/downgrades -- not a common case in
Linux world but such things really do happen.. Do you see a problem
now?  You just cannot make a one policy nowadays and whatever policy
you decide on you're going to break some setups.. :-)  HPA policy is
system _and_ disk _and_ specific configuration dependent so there is
no way for kernel alone to get all different cases right.  The best we
can do is export all data points to user-space and let it & user deal
with the resulting mess..

Thanks,
Bartlomiej
