From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 14:36:22 -0500
Message-ID: <4D52ECB6.4010408@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com>	<20110209085935.GE6558@htj.dyndns.org>	<4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:41602 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab1BITgQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 14:36:16 -0500
In-Reply-To: <20110209153714.558133d7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/9/2011 10:37 AM, Alan Cox wrote:
> Unlocking the HPA is actually necessary for sanity on a lot of systems

Right.. ones that were partitioned using an older kernel with the buggy
behavior of unlocking it by default.

> too, and there are really no standards. Remember the primary use of HPA
> has actually been to hide most of the disk from buggy BIOSen so that the
> OS can then unlock it after the BIOS has stopped looking.

The ATA spec describes the HPA saying:

A reserved area for data storage outside the normal operating system
file system is required for several
specialized applications.

This tells me that it is intended for the bios to reserve an area of the
disk that the OS should NOT access.  So far the only use of it that I
have seen is by bioses to hide a small area, presumably to store
platform specific information.  I see about a dozen reports on the
ubuntu forums and bug tracker each year of people with HPA problems and
it always seems to be a small area, as opposed to hiding everything
above 128 MB or something.

> We cannot create a situation where any system that now unlocks the HPA
> ceases to do so, that breaks back compat in a potentially catastrophic
> way.

We already have that situation today.  This is the reason why Ubuntu
defaulted to having libata unlock the HPA by default, even though
Linus's tree did not ( and AFAIK, still does not, excepting the commit
in question here ).  No matter which choice you make, you cause some
breakage, so the goal is to minimize that breakage.  This commit
attempts to do that by auto unlocking the HPA iff it appears necessary
to access user data.  It is that test that I am asking be refined a bit
since it finds false positives for raid users.

> Probably the fakeraid layers need a way to see the geometry reported
> before unlock, then they can make their own decisions. The lock/unlock in
> hardware is just a hardware hack. We can still do the unlocking of
> hardware and using whatever values we choose in software at different
> points.
> 
> "Should we unlock" is almost an academic debate given we are the OS and
> control the commands sent to the drive anyway.

Again, Linus's tree does not unlock, and should not since the bios
presumably had a reason for locking it in the first place ( it stores
something there ).
