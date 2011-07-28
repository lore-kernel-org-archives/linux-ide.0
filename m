From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Subject: Re: boot failure in 2.6.39.3
Date: Thu, 28 Jul 2011 13:24:00 -0400
Message-ID: <1311873840.3223.2.camel@montroll.chem.mcgill.ca>
References: <1311808122.4630.12.camel@montroll.chem.mcgill.ca>
	 <4E312D95.6090805@mrc-lmb.cam.ac.uk>
Reply-To: David.Ronis@McGill.CA
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from torrent.CC.McGill.CA ([132.206.27.49]:48421 "EHLO
	torrent.cc.mcgill.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab1G1RYF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jul 2011 13:24:05 -0400
In-Reply-To: <4E312D95.6090805@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Cc: linux-ide@vger.kernel.org

Hi Dave,

Thanks for the reply.  I've posted a jpg of the last screen at

http://ronispc.chem.mcgill.ca/ronis/images/boot_crash.jpg

Note the material before the backtrace.  The disks and partitions seem
correct.

David


On Thu, 2011-07-28 at 10:36 +0100, Dave Howorth wrote:
> David Ronis wrote:
> > I've just tried to upgrade from a slackware-2.6.37.6-huge (most drivers
> > are enabled at least as modules) to 2.6.39.3, built locally.   The
> > resulting kernel won't boot (generating an oops).   What I see on the
> > console is a list of the various disk partitions (sd driver) and then a
> > complaint about not being able to mount /dev/root.   (The older kernel
> > works fine-the disks using the ata_pixx driver).
> > 
> > My suspicion is that I've misconfigured the kernel.  Any suggestions?
> 
> Show the detail log of the oops?! Use a photo if necessary.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
