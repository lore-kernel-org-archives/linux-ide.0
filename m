From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: libata reports bogus addresses for everything (was PATA_PCMCIA  cmd
 port)
Date: Sat, 17 Mar 2007 15:43:33 +0000
Message-ID: <20070317154333.088d77d4@lxorguk.ukuu.org.uk>
References: <20061217212752.d93816b4.komurojun-mbn@nifty.com>
	<20061217040222.GD17561@ftp.linux.org.uk>
	<20070211101537.e40fa309.komurojun-mbn@nifty.com>
	<20070317220050.380d9f51.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54597 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965639AbXCQOkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 10:40:18 -0400
In-Reply-To: <20070317220050.380d9f51.komurojun-mbn@nifty.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, 17 Mar 2007 22:00:50 +0900
Komuro <komurojun-mbn@nifty.com> wrote:

> 
> Hi,
>  
> The pata_pcmcia driver reports the cmd port is 0x00010100,
> but actually the cmd port is 0x0100.
> 
> Is this corect?

When the pci_iomap patches were applied the ports reported for every
device went strange.  It appears to display the wrong information
nowdays. I see the same but I've got many more important things to work
on before I even bother to look at it.

My guess is someone is now printing the iomap virtual addresses not the
bus ones.

Alan
