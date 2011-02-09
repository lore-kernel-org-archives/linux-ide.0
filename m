From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 16:28:24 -0500
Message-ID: <4D5306F8.6050106@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com>	<20110209085935.GE6558@htj.dyndns.org>	<4D52B0B3.40900@cfl.rr.com>	<20110209153714.558133d7@lxorguk.ukuu.org.uk>	<4D52ECB6.4010408@cfl.rr.com> <20110209211351.3d7eff85@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:61599 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746Ab1BIV2Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 16:28:16 -0500
In-Reply-To: <20110209211351.3d7eff85@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/9/2011 4:13 PM, Alan Cox wrote:
> Correct. The vendors however primarily used it for completely different
> things. Also trusting the BIOS is generally not a good idea.

I disagree.  Trusting the bios /generally/ is exactly what you should
do.  When it is known to be broken in specific cases, then sure, over
ride it, but /generally/ you should assume it knows what it's talking about.

>> ubuntu forums and bug tracker each year of people with HPA problems and
>> it always seems to be a small area, as opposed to hiding everything
>> above 128 MB or something.
> 
> Possibly because we unlock them in the distro cases.

I meant that the reports I have seen show the kernel prints listing the
size before and after the unlock, and they are always very close.

> So the best option from a kernel point of view appears to be to unlock
> the drive but to remember and enable user space to retrieve the
> parameters.
> 
> In essence "what geometry do I care about" is policy for application code
> like dmraid, and it can be better refined there. However we can't refine
> it there if we don't unlock.

That assumes that the bios is reserving the HPA for no good reason at
all and it is safe to ignore it.  This does not seem to be a good
assumption based on both the ATA spec and the behavior of Windows.  At
any rate, the decision to NOT unlock by default seems to have been made
years ago when libata was written, and certain distributions decided to
risk breaking compatibility with hardware that runs Windows just fine in
favor of not breaking upgrades from systems installed with the old ide
driver that did default to unlocking.

The discussion at hand is about a change made a few months ago that is a
good compromise between always unlocking, and never unlocking.  Both of
those have problems, so a good compromise can have the benefits of both,
and the drawbacks of neither.  Furthermore, it is already in the kernel,
so continuing to argue about whether it should have been done or not
seems a moot point.
