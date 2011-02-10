From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 19:35:30 -0500
Message-ID: <4D5332D2.5090701@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <4D52ECB6.4010408@cfl.rr.com> <20110209214118.GA7196@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:63404 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab1BJAfb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 19:35:31 -0500
In-Reply-To: <20110209214118.GA7196@atj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 02/09/2011 04:41 PM, Tejun Heo wrote:
> So, no, the situation has always been quite muddy with HPA and if you
> ask me it is an inherently stupid feature bound to cause problems.

What problems?  Other than those caused by unlocking it in the first 
place, and then upgrading?

> The setting is not even bound to the hard drive.  You move a hard
> drive to a different machine, the size changes, hooray!  Oh right,

Unless the other machine decides to change it, then it is bound to the 
drive.  It is possible that both machines will change it, but since most 
don't bother using the HPA, it tends to be preserved when moving from a 
machine that uses it to one that does not.

> I think ide had it right all along.  We should just have unlocked
> things by default when HPA unlock feature was added.  A lot of BIOSen

Why?

> To sum up, no, not unlocking HPA by default was not a conscious
> decision and neither was some distros defaulting to unlocking it.
> Those decisions are all made by inertia, so please stop bringing them
> up.  They don't mean much.

Then why did you write a patch that seems to be a reasonable compromise 
between the two and will allow distros to stop diverging from upstream 
in this way, and are now arguing against that patch?
