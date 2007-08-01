From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST340823A disk size issue
Date: Wed, 1 Aug 2007 14:05:56 +0100
Message-ID: <20070801140556.136ed130@the-village.bc.nu>
References: <20070801092903.GA1199@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44021 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761920AbXHAM6q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 08:58:46 -0400
In-Reply-To: <20070801092903.GA1199@nalle>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: linux-ide@vger.kernel.org

On Wed, 1 Aug 2007 12:29:04 +0300
Mikko Rapeli <mikko.rapeli@iki.fi> wrote:

> Hello, 
> 
> (More details at http://bugzilla.kernel.org/show_bug.cgi?id=8816 )
> 
> My home server disk doesn't work with latest kernels since its size is
> reported or probed correctly. With 2.6.22.1 I get:

You've got an odd sized disk. If you have that, old IDE, and you also have
anything which tries to read the last sector (eg GPT partitioning) it'll
break as it tries to read 1K block sizes.

Vendors normally clip the drive to an even size which seems to be the
case on your box with the HPA left alone.

It *should* all "just work" with the libata drivers but needs more
testing of odd sizes to be 100% sure
