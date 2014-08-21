From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA disks disabled on boot
Date: Thu, 21 Aug 2014 17:43:23 -0500
Message-ID: <20140821224323.GC7996@mtj.dyndns.org>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
 <20140714163641.GF31610@htj.dyndns.org>
 <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
 <20140817133942.GD7679@mtj.dyndns.org>
 <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:60620 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbaHUWn2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Aug 2014 18:43:28 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so9020611qaq.11
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2014 15:43:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nuno =?iso-8859-1?Q?Magalh=E3es?= <nunomagalhaes@eu.ipp.pt>
Cc: linux-ide@vger.kernel.org

On Thu, Aug 21, 2014 at 11:40:09PM +0100, Nuno Magalh=E3es wrote:
> I've been shifting the disks around,trying to find a pattern. So far
> only the Reds fail, i haven't been able to fail a Toshiba. At first i
> thought it was because the Toshibas were both on a RAID1 - i'm still
> testing this theory. I.e., i've recently dropped the RAID; one Toshib=
a
> now holds the OS @SATA1, all the others are empty.
>=20
> I'll keep running more tests and document all combinations (SATA
> ports, kernel parameters, etc) and results. I'll re-read on those
> parameters and report back once i have something significant.
>=20
> Could the PSU have an influence? It's a Nox Urano 500.

PSU issues can lead to nasty unexpected issues, so it's theoretically
possible but I can't suggest one way or the other.  If you have spare
components lying around, be it PSU, motherboard or a different sata
controller, trying out different combinations usually is an often
effective way of determining which one is the culprit.

Thanks.

--=20
tejun
