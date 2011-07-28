From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: boot failure in 2.6.39.3
Date: Thu, 28 Jul 2011 10:36:21 +0100
Message-ID: <4E312D95.6090805@mrc-lmb.cam.ac.uk>
References: <1311808122.4630.12.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:34316 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab1G1JgY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jul 2011 05:36:24 -0400
Received: from mail.mrc-lmb.cam.ac.uk ([131.111.85.9]:44810 helo=mail.lmb.internal)
	by ppsw-51.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.138]:25)
	with esmtp id 1QmN0v-00063I-ZA (Exim 4.72) for linux-ide@vger.kernel.org
	(return-path <dhoworth@mrc-lmb.cam.ac.uk>); Thu, 28 Jul 2011 10:36:21 +0100
Received: from cpepc210-3.lmb.internal ([10.14.0.2])
	by mail.lmb.internal with esmtp (Exim 4.63)
	(envelope-from <dhoworth@mrc-lmb.cam.ac.uk>)
	id 1QmN0v-0000rG-F2
	for linux-ide@vger.kernel.org; Thu, 28 Jul 2011 10:36:21 +0100
In-Reply-To: <1311808122.4630.12.camel@montroll.chem.mcgill.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

David Ronis wrote:
> I've just tried to upgrade from a slackware-2.6.37.6-huge (most drivers
> are enabled at least as modules) to 2.6.39.3, built locally.   The
> resulting kernel won't boot (generating an oops).   What I see on the
> console is a list of the various disk partitions (sd driver) and then a
> complaint about not being able to mount /dev/root.   (The older kernel
> works fine-the disks using the ata_pixx driver).
> 
> My suspicion is that I've misconfigured the kernel.  Any suggestions?

Show the detail log of the oops?! Use a photo if necessary.
