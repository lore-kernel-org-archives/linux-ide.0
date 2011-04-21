From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] block: don't propagate unlisted DISK_EVENTs to
 userland
Date: Thu, 21 Apr 2011 10:27:18 -0700 (PDT)
Message-ID: <20110421.102718.27823822.davem@davemloft.net>
References: <20110421170826.GC15988@htj.dyndns.org>
	<BANLkTinwPt=aRSsh_Ppb8hLOaURh6mL2GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57810
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754881Ab1DUR1x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2011 13:27:53 -0400
In-Reply-To: <BANLkTinwPt=aRSsh_Ppb8hLOaURh6mL2GQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: tj@kernel.org, jaxboe@fusionio.com, hch@lst.de, neilb@suse.de, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kay.sievers@vrfy.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Apr 2011 10:25:35 -0700

> Should I take these as patches, or through Jens/David/Who?
> 
> I'll happily take them as patches, but I'd also like to hear
> confirmation from the people who saw the lock-up that it's gone now..

I ACK'd the IDE part so that this can get integrated either
directly or via Jens's tree.
