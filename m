From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git pull] IDE updates part 4
Date: Tue, 07 Apr 2009 18:30:06 -0400
Message-ID: <49DBD3EE.3010601@garzik.org>
References: <200904080020.43175.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45771 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbZDGWaR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 18:30:17 -0400
In-Reply-To: <200904080020.43175.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> - TRIM support ("discard" operation for SSD devices)
>   (David Woodhouse & Matthew Wilcox)
> 
>   Since this is a new feature and hasn't seen much testing with production
>   devices it is not enabled by default yet (requires use of "ide_core.trim=1"
>   kernel parameter).


As noted by Matthew, this appears to be missing the requisite block support?

	Jeff



