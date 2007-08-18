From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Sat, 18 Aug 2007 23:41:36 +0100
Message-ID: <20070818234136.22043c6c@the-village.bc.nu>
References: <46C69913.1060505@g7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53904 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750828AbXHRWdn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 18:33:43 -0400
In-Reply-To: <46C69913.1060505@g7.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Malcolm Gillies <malcolm@g7.org>
Cc: linux-ide@vger.kernel.org

On Sat, 18 Aug 2007 17:00:35 +1000
Malcolm Gillies <malcolm@g7.org> wrote:

> My PATA hard disk is crippled by CRC errors when it's on the same cable 
> as a 1GB SanDisk Ultra II CompactFlash card in CF to IDE adaptor. Any 
> ideas why?

I would guess the resulting pipe of cables and bits means you are out of
spec for UDMA66 speeds. The restrictions on cables are very tight and
dangling convertors off them is often enough to mess it up.

