From: Shane Hathaway <shane@hathawaymix.org>
Subject: Re: Bug: Resume with Host Protected Area
Date: Tue, 19 Apr 2005 21:43:20 -0600
Message-ID: <4265CFD8.4010408@hathawaymix.org>
References: <4265640B.5060402@hathawaymix.org> <87f94c370504191420d2f5c32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 67.107.199.112.ptr.us.xo.net ([67.107.199.112]:13823 "EHLO
	hathawaymix.org") by vger.kernel.org with ESMTP id S261320AbVDTDnZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Apr 2005 23:43:25 -0400
In-Reply-To: <87f94c370504191420d2f5c32@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: linux-ide@vger.kernel.org

Greg Freemyer wrote:
> IMHO, if you are going to put live data in the HPA, you really should
> just kill the HPA permanently not depend on Linux to do a volitile
> reset on every reboot/resume.
>
> See setmax at http://www.win.tue.nl/~aeb/linux/setmax.c 

Thanks for the pointer.

Still, I'm thinking of all the others who may have fallen into the same
trap.  I got into this situation purely by accident--I was never made
aware of HPA at installation time; Linux must have disabled it
automatically.  Then it took me a year to guess that the problems with
sleeping might be related to some peculiar messages I saw in the kernel
logs.

The HPA support needs to be all or nothing: either Linux disables HPA
automatically at boot *and* at resume, or it doesn't touch HPA at all.
Also, HPA shouldn't be disabled without user consent.  IBM put the
Windows installer in my laptop's HPA rather than provide installation
CDs.  There were no partition table entries indicating there was
anything stored at the end of the drive, so when I installed Linux, I
wiped out the Windows installer without knowing it.  IBM still hasn't
sent the replacement CDs.

Shane
