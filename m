From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 14:11:59 -0500
Message-ID: <4D54387F.3030809@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <4D52ECB6.4010408@cfl.rr.com> <20110209214118.GA7196@atj.dyndns.org> <4D5332D2.5090701@cfl.rr.com> <4D534378.3050304@gmail.com> <20110210091325.GK3770@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:46961 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab1BJTLy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 14:11:54 -0500
In-Reply-To: <20110210091325.GK3770@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/10/2011 4:13 AM, Tejun Heo wrote:
> What happens if a drive is moved to another machine?  What about
> hotplugging a drive?  What if partition detection code incorrectly
> interprets a chunk of data in a RAID5 member as a partition table
> (most partition tables don't have good protection against
> misinterpretation)?

I don't see how any of these cases are made worse by your change.  If
you move to another machine and it adds an HPA, then your change will
unlock it.  If you incorrectly interpret a chunk of data as a partition
table, then you incorrectly unlock ( this is exactly what I am to fix ),
but that isn't worse than always unlocking.

> BIOS features are designed with the mindset "If it works on this
> motherboard and windows, we're done.  Hell with all other use cases",
> which is quite different from what Linux should be aiming for.

I agree, but always unlocking seems to HURT that goal rather than help it.

> You've got it backwards.  The patch doesn't do anything for distros
> which unlock by default.  On the contrary, the patch unlocks _more_ on
> ones which didn't use to.  IIRC, debian didn't want to unlock by
> default (the rationale was that they already had both ide and libata
> userbases) and it seemed like a good enough tradeoff to avoid breaking
> ide compatibility for most people.

You can't unlock any more than always ;)

Ubuntu has dropped its patch to always unlock in favor of your upstream
change to unlock when it makes sense.  The net result is that it unlocks
less, but still sometimes unlocks when it should not with certain raid
setups.  Also this is not just a problem for fakeraid; mdadm raid setups
can run into the same problem.

> Making the condition more intricate won't fix the problem.  It's just
> gonna make it fail in more weird and convoluted ways.

If it fails less, then it is an improvement.

> Hotplugging and being able to move hard drives between different
> machines, and in general behaving consistently across different
> hardware configurations have way higher priority than trying to avoid

Your auto unlock change seems to address that issue just fine.
