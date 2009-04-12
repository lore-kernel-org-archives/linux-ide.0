From: Szabolcs Szakacsits <szaka@ntfs-3g.com>
Subject: Re: Implementing NVMHCI...
Date: Sun, 12 Apr 2009 18:14:21 +0300 (EEST)
Message-ID: <Pine.LNX.4.62.0904121806060.9521@tamago.serverit.net>
References: <20090412091228.GA29937@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tamago.serverit.net ([91.189.209.155]:55901 "EHLO
	mail.hosting2.serverit.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750772AbZDLPzR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Apr 2009 11:55:17 -0400
In-Reply-To: <20090412091228.GA29937@elte.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Grundler <grundler@google.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>


Linus Torvalds wrote:

> And people tend to really dislike hardware that forces a particular 
> filesystem on them. Guess how big the user base is going to be if you 
> cannot format the device as NTFS, for example? Hint: if a piece of 
> hardware only works well with special filesystems, that piece of hardware 
> won't be a big seller.
> 
> Modern technology needs big volume to become cheap and relevant.
> 
> And maybe I'm wrong, and NTFS works fine as-is with sectors >4kB. But let 
> me doubt that.

I did not hear about NTFS using >4kB sectors yet but technically 
it should work.

The atomic building units (sector size, block size, etc) of NTFS are 
entirely parametric. The maximum values could be bigger than the 
currently "configured" maximum limits. 

At present the limits are set in the BIOS Parameter Block in the NTFS
Boot Sector. This is 2 bytes for the "Bytes Per Sector" and 1 byte for 
"Sectors Per Block". So >4kB sector size should work since 1993.

64kB+ sector size could be possible by bootstrapping NTFS drivers 
in a different way. 

	Szaka

--
NTFS-3G: http://ntfs-3g.org
