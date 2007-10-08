From: Hernan G Solari <hgsolari@gmail.com>
Subject: Re: Serial ATA does not find partitions (Hitachi HD, new? ATI controller)
 where old SATA works
Date: Sun, 07 Oct 2007 23:30:00 -0300
Message-ID: <47099628.2050108@gmail.com>
References: <46FC4384.7080607@df.uba.ar> <46FCCD57.2020507@gmail.com> <47014740.5080002@df.uba.ar> <4701EA71.2000609@gmail.com> <470220FE.2090506@gmail.com> <47044C6C.5030905@gmail.com> <47083555.2060605@gmail.com> <470981EE.30103@gmail.com>
Reply-To: hgsolari@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:57740 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbXJHDju (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 23:39:50 -0400
Received: by wr-out-0506.google.com with SMTP id 36so557405wra
        for <linux-ide@vger.kernel.org>; Sun, 07 Oct 2007 20:28:09 -0700 (PDT)
In-Reply-To: <470981EE.30103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>


> Hmmm... and the kernel freezes after this?  libata driver isn't
> initialized yet.  I don't think libata has anything to do with here.
>
>  =20
as I told you, the ATA problem was with the 2.6.22 version of the kerne=
l
and is not longer related to the freeze with kernel 2.6.23-rc8  I asked=
=20
whether you wanted to see the ATA problem in that kernel or the present=
=20
crash.

> Options: I can compile the 2.6.22 kernel to get the reported problem
>       or try to debug the problem in 2.6.22.8 or something else it
>        fits the kernel-team.

was my offer.

As you did not answer that point (you answered other points) I thought=20
it was useless to debug a problem that is not longer there. I still=20
thing that way.
The booting is apparently allocating port services at the  point of=20
freezing but not too close of the disk driver, that much I  knew.

regards
                Hernan




--=20
Hern=E1n Gustavo Solari, solari@df.uba.ar, http://www.df.uba.ar/~solari


