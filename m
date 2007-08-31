From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hda: set_drive_speed_status: status=0x51 { DriveReady
 SeekComplete Error }
Date: Fri, 31 Aug 2007 12:49:58 +0100
Message-ID: <20070831124958.6f2104ec@the-village.bc.nu>
References: <46D59ED2.4000900@free.fr>
	<20070829174657.09c7de3c@the-village.bc.nu>
	<46D67D09.6090101@free.fr>
	<46D69E03.9080403@vc.cvut.cz>
	<46D6B85C.5050509@free.fr>
	<46D6DDF6.6080400@free.fr>
	<20070831003127.6f6950f4@the-village.bc.nu>
	<46D7CFD7.9030404@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41804 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965093AbXHaLl3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Aug 2007 07:41:29 -0400
In-Reply-To: <46D7CFD7.9030404@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> When a DMA operation is enabled, CS0- and CS1- shall not be asserted and 
> transfers shall be 16-bits wide.
> 
> I took the above to mean the device was designed to support DMA.
> Where did I err?

The bus is specified for DMA, not the device.

> 
> > The data sheet says the media can only do 4.1MB/second which is
> > consistent with only needing PIO2 (actually it's far slower than PIO2)
> 
> Is such a slow speed typical of DOMs sold today?
> 
> Or do DOMs sold today support DMA bus mastering, much higher interface 
> rates, and much higher sustained throughput?

Most CF is pretty slow but the newer CF cards do DMA and are getting far
better.

And yes I'd expect your real time app to deal for 3 or 4mS

(Mind you you'll get 1mS normal operating worst cases off even a fast DMA
IDE disk)
