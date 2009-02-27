From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise fails to detect all 4 HDD on the TX4 since 2.6.26
Date: Fri, 27 Feb 2009 18:50:51 +0100
Message-ID: <18856.10235.99475.236246@harpo.it.uu.se>
References: <7c8826910902241756j6e2d9c88pc293503e9cbf73ae@mail.gmail.com>
	<49A50F20.9060600@kernel.org>
	<7c8826910902251005v5bd37867v6c7f688224e9af3f@mail.gmail.com>
	<18853.40821.848719.25410@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:33839 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbZB0RvI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Feb 2009 12:51:08 -0500
In-Reply-To: <18853.40821.848719.25410@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Mike Cui <cuicui@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Mikael Pettersson writes:
 > Mike Cui writes:
 >  > If you want the full kernel boot log I can get it to you in a couple
 >  > of days. But here is what I remember from the kernel logs. It probes
 >  > each of the 4 ports, and it always thinks that the first port is "link
 >  > down". The drives I have plugged into it are samsung HD753LJ
 > 
 > 1. Have you tried with different disks on port 0? Preferably also
 >    with different models or from different manufacturers.
 > 2. Does it matter if all ports are populated? Is there any difference
 >    if only port 0 is populated as opposed to all 4 being populated?
 > 
 > Full boot logs from the last working kernel and first non-working one would
 > be useful. And please make them www.kernel.org kernels, not Ubuntu ones.

I loaded my sata_promise test box with a SATA300TX4 and one SATA disk
on each of the four ports. 2.6.29-rc6 and 2.6.28 booted and worked with
no issues whatsoever. 2.6.27 and 2.6.26 experienced slight boot delays
as the disk on the first port (a Samsung HD501LJ) got a failed COMRESET
which EH had to recover from (and it did).

The sata_promise COMRESET problem was fixed in 2.6.28, and the fix was
backported to the 2.6.27 stable series in 2.6.27.5 (current is 2.6.27.19).
I suggest that you skip 2.6.26 and update to 2.6.27.19 or newer.

/Mikael
