From: Frans Pop <elendil@planet.nl>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Sun, 13 Apr 2008 15:59:20 +0200
Message-ID: <200804131559.21664.elendil@planet.nl>
References: <200804021524.27222.elendil@planet.nl> <200804031947.07674.elendil@planet.nl> <48017248.4030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml15.kpnxchange.com ([213.75.38.115]:1832 "EHLO
	hpsmtp-eml15.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757190AbYDMN70 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Apr 2008 09:59:26 -0400
In-Reply-To: <48017248.4030600@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Sunday 13 April 2008, Tejun Heo wrote:
> Please be advised that some modern controllers are dual interfaced.
> Native one and legacy one.  The legacy one is SFF compliant and
> depending on configuration may appear at legacy IO addresses, so if you
> aren't careful, you can end up with two drivers driving the same
> hardware which usually doesn't end too well.  Loading generic drivers
> w/o knowing that it's needed is quite dangerous.  I would strongly
> advise against it.

I totally agree. The problem being discussed here is exactly how to know it 
is needed. If you have better suggestions for that, I'd appreciate it.

As you specifically say "modern controllers", I suspect that the problem is 
limited as I guess those are fairly unlikely to be found in machines that 
have an ISA bus.

I also think the way I've implemented in the Debian installer should be 
relatively safe:
1) ide-generic is only loaded _after_ any otherwise detected modules
2) it is only loaded if an ISA bus is present
3) it is only included in the initrd for the installed system if loading it
   in the installer resulted in additional block devices appearing

I would unload ide-generic in the installer if no additional block devices 
appear, but unfortunately that's not possible as it is marked "permanent".

By loading it after any other drivers I expect there will be no issues 
during the installation (as the other driver will already have claimed the 
device). Making sure it is only loaded for the installed system if actually 
needed should avoid problems there.

ATM I can only see this causing problems in systems that need both 
ide-generic and some other driver as adding ide-generic in the initrd is 
likely to result in it being loaded before that other driver.

Again, if anyone has a better suggestion how to implement this (preferably 
without asking the user whether he has a device that needs ide-generic, 
which most users are unlikely to know anyway), I'd appreciate it.

Cheers,
FJP
