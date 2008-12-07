From: Mark Lord <liml@rtr.ca>
Subject: Re: What's with libata and DVDs ?
Date: Sun, 07 Dec 2008 00:01:13 -0500
Message-ID: <493B5899.8050803@rtr.ca>
References: <493B554D.3070403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:59820 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590AbYLGFAB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Dec 2008 00:00:01 -0500
Received: from [10.0.0.6] (corey.localnet [10.0.0.6])
	by mail.rtr.ca (Postfix) with ESMTP id 9A53794679E
	for <linux-ide@vger.kernel.org>; Sun,  7 Dec 2008 00:01:13 -0500 (EST)
In-Reply-To: <493B554D.3070403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Attempting to play a known-good DVD-video in MythTV-0.21
> using libata in kernel 2.6.27.7 :
> 
> sr 4:0:0:0: [sr0] unaligned transfer
> Buffer I/O error on device sr0, logical block 1080
> Buffer I/O error on device sr0, logical block 1081
> Buffer I/O error on device sr0, logical block 1082
> Buffer I/O error on device sr0, logical block 1083
> Buffer I/O error on device sr0, logical block 1084
> Buffer I/O error on device sr0, logical block 1085
> Buffer I/O error on device sr0, logical block 1086
> Buffer I/O error on device sr0, logical block 1087
> Buffer I/O error on device sr0, logical block 1088
> sr 4:0:0:0: [sr0] unaligned transfer
> sr 4:0:0:0: [sr0] unaligned transfer
> sr 4:0:0:0: [sr0] unaligned transfer
> 
> This used to work back in 2.6.25 or so.
> Anyone else out there have similar DVD issues ?
..

Mmm.. some DVDs play, others don't.  I'll instrument the code
and see if anything obvious pops up someday.  Ignore me for now. :)
