From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Overagressive failing of disk reads, both LIBATA and IDE
Date: Sat, 21 Mar 2009 15:10:28 +0000
Message-ID: <20090321151028.2ac4101f@lxorguk.ukuu.org.uk>
References: <F79C774361EF45A6A68BC08F8621E406@DIAMOND8600>
	<49C30E67.4060702@rtr.ca>
	<1237645333.4600.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35059 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752110AbZCUPJi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Mar 2009 11:09:38 -0400
In-Reply-To: <1237645333.4600.9.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Lord <liml@rtr.ca>, Norman Diamond <n0diamond@yahoo.co.jp>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Using the disk supplied data about where the error occurred (provided
> the disk returns it) eliminates all the readahead problems like the one

ATA disks do provide sector information generally, as do CD-ROMs, in fact
we actually decode it for error reporting so probably all the bits are
there to improve any reporting for most read side cases.

>From some of the traces I have been debugging I am not convinced the scsi
mid layer does the right thing any more. It uses to be handling CD-R
media (where the end of media is not well defined) but nowdays seems to
be reporting errors even when told that the I/O partly succeeded. I need
to debug that case further however but as I don't have one of the problem
drives its a bit tricky.

> above.  Perhaps just turning of readahead for disks that don't supply
> error location information would be a reasonable workaround?

Not really. From a performance perspective Mark's patch is vastly
superior because it punishes the incredibly rare error case not the
routine working performance. Avoiding the need to do either would be even
better - as would fixing the block layer not to mess up retries in this
situation.

For low speed devices like MMC cards and flash it might make sense not to
merge unrelated requests however so that only the relevant one fails.

Alan
