From: =?UTF-8?Q?Nuno_Magalh=C3=A3es?= <nunomagalhaes@eu.ipp.pt>
Subject: Re: SATA disks disabled on boot
Date: Thu, 21 Aug 2014 23:40:09 +0100
Message-ID: <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
 <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
 <20140817133942.GD7679@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:60838 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbaHUWkb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Aug 2014 18:40:31 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so9414600wib.3
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2014 15:40:30 -0700 (PDT)
In-Reply-To: <20140817133942.GD7679@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

> dump_id shouldn't affect anything but should give us more data about
> the failure.  Can you please try to reproduce the problem with dump_id
> specified?  nohrst may make the problem go away.  Can you please try
> to reproduce the issue with the parameter specified.

I've been shifting the disks around,trying to find a pattern. So far
only the Reds fail, i haven't been able to fail a Toshiba. At first i
thought it was because the Toshibas were both on a RAID1 - i'm still
testing this theory. I.e., i've recently dropped the RAID; one Toshiba
now holds the OS @SATA1, all the others are empty.

I'll keep running more tests and document all combinations (SATA
ports, kernel parameters, etc) and results. I'll re-read on those
parameters and report back once i have something significant.

Could the PSU have an influence? It's a Nox Urano 500.

Thank you for your time.

Cheers,
Nuno
