From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PMP] sil3132 st6600 problem
Date: Tue, 21 Nov 2006 15:00:07 +0900
Message-ID: <456295E7.9080909@gmail.com>
References: <45552660.4050902@dschroeder.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:33523 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030770AbWKUGAQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 01:00:16 -0500
Received: by nf-out-0910.google.com with SMTP id o25so67073nfa
        for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2006 22:00:15 -0800 (PST)
In-Reply-To: <45552660.4050902@dschroeder.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Daniel_Schr=F6der?= <mail@dschroeder.info>
Cc: linux-ide@vger.kernel.org

Daniel Schr=F6der wrote:
> Hello *,
>=20
> a couple of weeks ago, i posted a "success" message. This time i have=
 a
> strange issue to report. A couple of weeks, with only one Samsung
> HD401LJ and everything was fine. Yesterday, i put another drive a
> Samsung HD501LJ into the second bay and shortly after this. (After FD=
ISK
> and MKFS and a couple of powercycles) The device is completely
> unresponsive. With this device on, Windows XP freezes instantly...Lin=
ux
> shows the following at turning on:
>=20
> And everytime, when i played with this device, he said something abou=
t
> USB...WTF?! Same IRQ? I dont think so:

USB messages seem to be power supply related..  If you have another=20
power supply available, try to use it for disks (using power supply w/o=
=20
motherboard isn't difficult. just ask google) or buy a better one.

When PMP detection fails, did you have the first PMP port occupied?=20
Sil3726/4726 PMPs fail to initialize if the first port isn't occupied.=20
Dunno if it's those hardware's fault or driver's fault yet.

--=20
tejun
