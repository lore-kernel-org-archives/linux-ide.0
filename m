From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/4] drivers/ata: add low-level I/O calls
Date: Fri, 12 Jan 2007 21:41:06 +1100
Message-ID: <1168598466.5011.17.camel@localhost.localdomain>
References: <200701120958.l0C9wICB019343@toshiba.co.jp>
	 <20070112102406.6eb9374f@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56527 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161072AbXALKnX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jan 2007 05:43:23 -0500
In-Reply-To: <20070112102406.6eb9374f@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com

On Fri, 2007-01-12 at 10:24 +0000, Alan wrote:
> On Fri, 12 Jan 2007 19:00:45 +0900
> Akira Iguchi <akira2.iguchi@toshiba.co.jp> wrote:
> 
> > Dear everyone,
> > 
> > This is the patchset (based on 2.6.20-rc4) to add low-level I/O calls
> > which access the taskfile registers. The idea comes from drivers/ide
> > IN*/OUT* calls.
> 
> I think this is the wrong approach. The existing code provides methods
> for things like "read the status", "write a taskfile" and this is the
> style that should be kept.

I agree (Sorry Akira-san for the added work !), I've looked a bit and I
think that what we need is mainly an accessor for the control register
and for the LBA, and an ack for dmdma. It's unclear to me wether the
full taskfile access would be a good way to do the later though, I'm a
bit worried some HW might get upset if not accessing strictly only the
right registers (we all know how "touchy" those IDE controllers can be).

That would give us something like:

 - bmdma_irq_ack
 - dev_ctrl_read/write (unless we want to split that but there are
   quite a few different accesses so maybe not)
 - dev_sig read/write (read/write nsect/lbal, or maybe we want to let
drivers do their own post_reset)

I think that's it, unless I missd something. 'special' drivers can still
replace bmdma_start/stop etc..

That's just a very quick look, I might have missed something.

Ben.
 



