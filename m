From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver retries disk errors.
Date: Tue, 31 Aug 2004 12:38:45 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1093952325.32684.7.camel@localhost.localdomain>
References: <20040830163931.GA4295@bitwizard.nl>
	 <20040830174632.GA21419@thunk.org>  <41337153.60505@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:6791 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268162AbUHaMkw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Aug 2004 08:40:52 -0400
In-Reply-To: <41337153.60505@superbug.demon.co.uk>
List-Id: linux-ide@vger.kernel.org
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Theodore Ts'o <tytso@mit.edu>, Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Llu, 2004-08-30 at 19:26, James Courtier-Dutton wrote:
> Theodore Ts'o wrote:
> > If the block gets successfully read after 2 or 3 tries, it might be a
> > good idea for the kernel to automatically do a forced rewrite of the
> > block, which should cause the disk to do its own disk block
> > sparing/reassignment.  

Not really as far as I can tell. It isn't a disk any more, its a storage
appliance on a funny connector. It already knows a lot about retries
internally as well as rewriting blocks with high ECC error
count. In fact you actually have to issue a different command to do 
read/write without retry.

> It does the same retries with CD-ROM and DVDs, and if the retries fail, 
> it disables DMA! It even does the retries when reading CD-Audio.
> Maybe there should be a "retrys" setting that can be set by hdparm, then 
> we could set the retry counts, and what happens when a retry fails on a 
> per device basis.

It probably should be smarter about error strategy here. You can use
hdparm to control some of this in the IDE case but not enough.

Alan

