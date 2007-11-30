From: Kjartan Maraas <kmaraas@broadpark.no>
Subject: Re: laptop reboots right after hibernation
Date: Fri, 30 Nov 2007 22:37:07 +0100
Message-ID: <1196458627.4106.1.camel@localhost.localdomain>
References: <473730F6.2010900@dbservice.com> <20071118105214.GB7299@ucw.cz>
 <4740692E.7010801@dbservice.com> <47409DA3.7070909@dbservice.com>
 <1195551141.2792.3.camel@localhost.localdomain> <474CBFB6.4020105@gmail.com>
 <1196253340.2884.1.camel@localhost.localdomain> <474FE862.4040700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from osl1smout1.broadpark.no ([80.202.4.58]:35298 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbXK3VhK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 16:37:10 -0500
In-reply-to: <474FE862.4040700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tomas Carnecky <tom@dbservice.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>


fr., 30.11.2007 kl. 19.39 +0900, skrev Tejun Heo:
> Kjartan Maraas wrote:
> > on., 28.11.2007 kl. 10.09 +0900, skrev Tejun Heo:
> >> Kjartan Maraas wrote:
> >>> I get this exact error message on a normal first time boot here. I'm
> >>> using the latest fedora development kernel which is 2.6.24-rc2-git6
> >>> based. And I have the latest BIOS from HP IIRC.
> >>>
> >>> This is an HP nc6400 intel based laptop:
> >> Care to post boot dmesg?  Or does harddisk detection fail because of this?
> >>
> > Here you go. It shows the error two times and then it gets it right and
> > continues to boot. No other problems arise from this that I can see.
> 
> I'm attaching two patches.  Please apply each on top of clean 2.6.24-rc3
> and report kernel boot logs for both.
> 
I tried to do that but recent kernels hang on boot here after TSC:
clocksource installed.

Filed a bug here:
https://bugzilla.redhat.com/show_bug.cgi?id=405721

but it also happens on the plain rc3 kernel...

Cheers
Kjartan


