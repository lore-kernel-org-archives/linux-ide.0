From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: /dev/sd*
Date: Thu, 17 Aug 2006 09:42:23 +0100
Message-ID: <1155804143.15195.32.camel@localhost.localdomain>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060809212124.GC3691@stusta.de>
	 <1155160903.5729.263.camel@localhost.localdomain>
	 <20060809221857.GG3691@stusta.de>
	 <20060810123643.GC25187@boogie.lpds.sztaki.hu>
	 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
	 <44E42198.3030500@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2733 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932165AbWHQIZz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Aug 2006 04:25:55 -0400
In-Reply-To: <44E42198.3030500@tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Lee Trager <Lee@PicturesInMotion.net>, Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Iau, 2006-08-17 am 11:58 +0400, ysgrifennodd Michael Tokarev:
> The reason, in my opinion anyway, is that not all the word is IDE now,
> and it has been this way for a long time.  I mean, real scsi uses /dev/sd*
> *right now*, and changing this to /dev/disk* will break just everything,
> not only people using IDE.

If people would like their disks to appear in /dev/disk/ by label or
whatever just send Greg some udev rules for it. It isnt a kernel problem
what it is called just some of the things around partitions

