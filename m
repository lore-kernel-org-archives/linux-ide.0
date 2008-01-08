From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata exception handling messages at boot on qemu
Date: Tue, 8 Jan 2008 21:40:09 +0000
Message-ID: <20080108214009.7ea5c9a4@lxorguk.ukuu.org.uk>
References: <20080108192352.GA9110@basil.nowhere.org>
	<20080108210428.63c90f9d@lxorguk.ukuu.org.uk>
	<20080108212109.GA2403@one.firstfloor.org>
	<20080108211931.4ef915fc@lxorguk.ukuu.org.uk>
	<20080108213716.GB2403@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47526 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751271AbYAHVmN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 16:42:13 -0500
In-Reply-To: <20080108213716.GB2403@one.firstfloor.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>, linux-ide@vger.kernel.org

On Tue, 8 Jan 2008 22:37:16 +0100
Andi Kleen <andi@firstfloor.org> wrote:

> On Tue, Jan 08, 2008 at 09:19:31PM +0000, Alan Cox wrote:
> > > Since I assume that qemu code base is wide spread and if a workaround
> > > is not too ugly I think it would be nice if the kernel handled that.
> > 
> > Qemu behaves exactly the same way as a broken device in a situation where
> > data corruption may occur. It would be extremely bad to remove sanity
> > checking in storage subsystems just to deal with a silly bug in an
> > emulator.
> 
> It could just a quirk e.g. matching on the ID string? 

Qemu has been fixed for months, if they are slack about releases or it
only got fixed in one of the gazillion branches of qemu that's their
problem. That code is so horrible to look at I doubt that is the only
problem and I did seriously look into it before deciding that qemu was
just to gross to even work out what the bugs were.

