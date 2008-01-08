From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata exception handling messages at boot on qemu
Date: Tue, 8 Jan 2008 21:19:31 +0000
Message-ID: <20080108211931.4ef915fc@lxorguk.ukuu.org.uk>
References: <20080108192352.GA9110@basil.nowhere.org>
	<20080108210428.63c90f9d@lxorguk.ukuu.org.uk>
	<20080108212109.GA2403@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40028 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758751AbYAHVVf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 16:21:35 -0500
In-Reply-To: <20080108212109.GA2403@one.firstfloor.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>, linux-ide@vger.kernel.org

> Since I assume that qemu code base is wide spread and if a workaround
> is not too ugly I think it would be nice if the kernel handled that.

Qemu behaves exactly the same way as a broken device in a situation where
data corruption may occur. It would be extremely bad to remove sanity
checking in storage subsystems just to deal with a silly bug in an
emulator.

Alan
