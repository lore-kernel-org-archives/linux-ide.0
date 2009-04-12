From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Implementing NVMHCI...
Date: Sun, 12 Apr 2009 16:20:18 +0100
Message-ID: <20090412162018.6c1507b4@lxorguk.ukuu.org.uk>
References: <20090412091228.GA29937@elte.hu>
	<Pine.LNX.4.62.0904121806060.9521@tamago.serverit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48286 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754147AbZDLPU2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Apr 2009 11:20:28 -0400
In-Reply-To: <Pine.LNX.4.62.0904121806060.9521@tamago.serverit.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Szabolcs Szakacsits <szaka@ntfs-3g.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Grant Grundler <grundler@google.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>

> The atomic building units (sector size, block size, etc) of NTFS are 
> entirely parametric. The maximum values could be bigger than the 
> currently "configured" maximum limits. 

That isn't what bites you - you can run 8K-32K ext2 file systems but if
your physical page size is smaller than the fs page size you have a
problem.

The question is whether the NT VM can cope rather than the fs.

Alan
