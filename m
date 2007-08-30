From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hda: set_drive_speed_status: status=0x51 { DriveReady
 SeekComplete Error }
Date: Fri, 31 Aug 2007 00:31:27 +0100
Message-ID: <20070831003127.6f6950f4@the-village.bc.nu>
References: <46D59ED2.4000900@free.fr>
	<20070829174657.09c7de3c@the-village.bc.nu>
	<46D67D09.6090101@free.fr>
	<46D69E03.9080403@vc.cvut.cz>
	<46D6B85C.5050509@free.fr>
	<46D6DDF6.6080400@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52470 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762922AbXH3XW7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2007 19:22:59 -0400
In-Reply-To: <46D6DDF6.6080400@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, vojtech@suse.cz

> PIO mode 2 is mentioned. Even DMA seems to be supported.
> Or am I mistaken?
> 
> Could there be a bug in my south bridge?

Nothing there about DMA support.

The data sheet says the media can only do 4.1MB/second which is
consistent with only needing PIO2 (actually its far slower than PIO2)

