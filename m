From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Driver retries disk errors.
Date: Mon, 30 Aug 2004 19:26:27 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41337153.60505@superbug.demon.co.uk>
References: <20040830163931.GA4295@bitwizard.nl> <20040830174632.GA21419@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:64271 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S268886AbUH3S03 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Aug 2004 14:26:29 -0400
In-Reply-To: <20040830174632.GA21419@thunk.org>
List-Id: linux-ide@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Theodore Ts'o wrote:
> On Mon, Aug 30, 2004 at 06:39:31PM +0200, Rogier Wolff wrote:
> 
>>We encounter "bad" drives with quite a lot more regularity than other
>>people (look at the Email address). We're however, wondering why the
>>IDE code still retries a bad block 8 times? 
> 
> 
> I could see retrying 2 or 3 times, but 8 times does seem to be a bit
> much, agreed.
> 
> 
>>In fact we regularly are able to recover data from drives: we have a
>>userspace application that retries over and over again, and this
>>sometimes recovers "marginal" blocks. This could be considered "good
>>practise" if there is a filesystem requesting the block. On the other
>>hand, when this happens, the drive is usually beyond being usable for
>>a filesystem: if we recover one block this way, the next block will be
>>errorred and the filesystem "crashes" anyway. In fact this behaviour
>>may masquerade the first warnings that something is going wrong....
> 
> 
> If the block gets successfully read after 2 or 3 tries, it might be a
> good idea for the kernel to automatically do a forced rewrite of the
> block, which should cause the disk to do its own disk block
> sparing/reassignment.  
> 
> 						- Ted

It does the same retries with CD-ROM and DVDs, and if the retries fail, 
it disables DMA! It even does the retries when reading CD-Audio.
Maybe there should be a "retrys" setting that can be set by hdparm, then 
we could set the retry counts, and what happens when a retry fails on a 
per device basis.

