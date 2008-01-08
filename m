From: Andi Kleen <andi@firstfloor.org>
Subject: Re: libata exception handling messages at boot on qemu
Date: Tue, 8 Jan 2008 22:37:16 +0100
Message-ID: <20080108213716.GB2403@one.firstfloor.org>
References: <20080108192352.GA9110@basil.nowhere.org> <20080108210428.63c90f9d@lxorguk.ukuu.org.uk> <20080108212109.GA2403@one.firstfloor.org> <20080108211931.4ef915fc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:35386 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbYAHVet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 16:34:49 -0500
Content-Disposition: inline
In-Reply-To: <20080108211931.4ef915fc@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, linux-ide@vger.kernel.org

On Tue, Jan 08, 2008 at 09:19:31PM +0000, Alan Cox wrote:
> > Since I assume that qemu code base is wide spread and if a workaround
> > is not too ugly I think it would be nice if the kernel handled that.
> 
> Qemu behaves exactly the same way as a broken device in a situation where
> data corruption may occur. It would be extremely bad to remove sanity
> checking in storage subsystems just to deal with a silly bug in an
> emulator.

It could just a quirk e.g. matching on the ID string? 

-Andi

