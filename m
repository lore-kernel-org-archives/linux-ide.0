From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Bug in libata
Date: Sat, 24 May 2008 15:35:23 -0400
Message-ID: <48386DFB.2090607@garzik.org>
References: <20080524191326.GA2917@ikki.ethgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39056 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYEXTfZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 May 2008 15:35:25 -0400
In-Reply-To: <20080524191326.GA2917@ikki.ethgen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Klaus Ethgen <Klaus@Ethgen.de>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

Klaus Ethgen wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Dear Jeff, dear Kernel developers,
> 
> after several time I decided to update the kernel on my IBM ThinkPad
> T43p to the newest one (2.6.25.4). After doing so my system was unable
> to boot. I always got the following error:
>    ata_piix 000:00:1f.2: failed to request/iomap BARs for port 0 (errno=-16)
> 
> After doing some regressions tests I got the wrong commit. Git commit
> 8cdfb29c0cd8018f92214c11c631d8926f4cb032 which is from Jeff Garzik
> introduce the bug that makes the system unbootable at all.
> 
> As I am not subscribed to the kernel-devel list please hold me in Cc
> about this bug.
> 
> Regards
>    Klaus Ethgen
> 
> Ps. Thanks to Linus for git-bisect. It costs me one day but without it I
> think I had have much longer to find the problematic patch.

This is a configuration problem.  You need to pick one driver or the 
other, not both, as that commit's description indicates.

	Jeff



