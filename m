From: Tejun Heo <teheo@suse.de>
Subject: Re: about TRIM/DISCARD support and barriers
Date: Sun, 23 Nov 2008 16:57:31 +0900
Message-ID: <49290CEB.7070509@suse.de>
References: <4928E010.4090801@kernel.org> <4929023C.2060302@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60713 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbYKWH5i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Nov 2008 02:57:38 -0500
In-Reply-To: <4929023C.2060302@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dwmw2@infradead.org, Nick Piggin <npiggin@suse.de>, Jens Axboe <jens.axboe@oracle.com>, IDE/ATA development list <linux-ide@v>
Cc: Matthew Wilcox <matthew@wil.cx>

Tejun Heo wrote:
> Dongjun, the only doc I can find about ATA TRIM is the following one.
> 
>  http://t13.org/Documents/UploadedDocuments/docs2007/e07154r3-Data_Set_Management_Proposal_for_ATA-ACS2.pdf
> 
> And AFAICS this hasn't made into ACS yet.  Is this what you guys are
> gonna implement and Windows7 is gonna use?

Just went over it.  Matthew, if ATA trim is gonna be implemented as
described in the above document, it will support multiple ranges per
command.

Dongjun, the above document strikes out all the latency/performance
related stuff, which looks like the right move to me.  Most of those
information can be extracted from access pattern by the device itself
and exposing such optimization parameters to outside seldom works well.
 I'm fairly sure such over complexity will end up being
counter-optimization due to different interpretations and executions by
different parties (be it harddrive vendors or different filesystems).

So, can you please confirm that, what we eventually get is simple TRIM
w/ multiple ranges?  Which, BTW, makes sense as it's something the
device can't infer from the access pattern.  Also, if there still is
wiggle room, what would be a worthy optimization is to allow TRIM
commands to be sent together with other NCQ commands as otherwise the
drive will have to drain all other commands to process a TRIM command
which will be inefficient.

Thanks.

-- 
tejun
