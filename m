From: Andi Kleen <andi@firstfloor.org>
Subject: Re: libata exception handling messages at boot on qemu
Date: Tue, 8 Jan 2008 22:21:09 +0100
Message-ID: <20080108212109.GA2403@one.firstfloor.org>
References: <20080108192352.GA9110@basil.nowhere.org> <20080108210428.63c90f9d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:50328 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758754AbYAHVSm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 16:18:42 -0500
Content-Disposition: inline
In-Reply-To: <20080108210428.63c90f9d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, linux-ide@vger.kernel.org

On Tue, Jan 08, 2008 at 09:04:28PM +0000, Alan Cox wrote:
> On Tue, 8 Jan 2008 20:23:52 +0100
> Andi Kleen <andi@firstfloor.org> wrote:
> 
> > 
> > Is there a workaround for the long ugly boot messages on sees
> > with libata and qemu (0.9.0 CVS 070719)? It boots eventually, but it looks 
> > quite ugly.
> > 
> > I suppose that's a qemu device model bug or could it be a Linux
> > problem?
> 
> libata actually bothers to check things like data directions and device
> state. This as far as I can tell is a qemu bug. I did look at the
> relevant code but it was so vomitously horrible I didn't investigate in
> detail. I believe the Xen qemu fork is ok ?

It's fixed in qemu CVS as Jim pointed out. Still it's a little annoying
to always have to update qemu from rpms to CVS. 

Since I assume that qemu code base is wide spread and if a workaround
is not too ugly I think it would be nice if the kernel handled that.

-Andi

