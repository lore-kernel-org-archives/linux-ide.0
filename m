From: "David A. Sinck" <bugs+linux-ide@grueslayer.com>
Subject: Re: pata_pdc202xx_old regression?
Date: Sat, 2 Jan 2010 19:10:57 -0700
Message-ID: <19263.64689.654744.283071@jabber.grueslayer.com>
References: <19263.43745.540746.751448@jabber.grueslayer.com>
	<4B3FB771.3070701@gmail.com>
Reply-To: bugs+linux-ide@grueslayer.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53668 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab0ACCK6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jan 2010 21:10:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockrwd@gmail.com
Cc: linux-ide@vger.kernel.org



> SMTP quoth Robert Hancock on 1/2/2010 15:15 as having spake thusly:
>
> On 01/02/2010 02:21 PM, David A Sinck wrote:
> >
> > Greetings&  Happy New Year!
> >
> > I believe I've come across one of two things:
> >
> > a) a regression in pata_pdc202xx_old
> > b) a clueless end user wrt the list :-)
> >
> > The short version: running Ubuntu's Jaunty release (2.6.28-17-generic
> > #58-Ubuntu i686) I can cleanly access the disks hanging off of an
> > onboard Promise 20265; attempting to upgrade to Ubuntu Karmic
> > (presumptively 2.6.31.16.29) has numerious problems reading these same
> > drives, including:
> >
> >    e2label: No such file or directory while trying to open /dev/sda1
> >    Couldn't find a valid filesystem superblock.
> >
> > I've documented as much as I can think of that's relevant here:
> >
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/489685
> >
> > I'm willing to run tests + update the bug with further information
> > ... if I knew what would be useful.
> >
> > It might even be solved upstream from the release Karmic's using?
> 
> That dmesg output is from the working setup, correct? Can you get any 
> output from the non-working one?

I've uploaded /var/log/ { kern.log | syslog | dmesg } from a running
Karmic live cd (post release); I snapshotted the whole directory but
limited myself to those files figuring they'd be most likely to be the
helpful ones.  

Let me know what else I can do; thanks for the timely response!

David
