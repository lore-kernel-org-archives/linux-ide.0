From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Fri, 2 Feb 2007 18:49:28 +0000
Message-ID: <20070202184928.4229f99a@localhost.localdomain>
References: <20070202151856.GD1625@htj.dyndns.org>
	<45C359FC.2000601@ru.mvista.com>
	<45C369C5.5000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45615 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946028AbXBBShL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 13:37:11 -0500
In-Reply-To: <45C369C5.5000201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, ahaas@airmail.net, linux-ide@vger.kernel.org

On Sat, 03 Feb 2007 01:41:41 +0900
Tejun Heo <htejun@gmail.com> wrote:
> >    Actually, I think ata_timing_merge() should just be performed when
> > setting MWDMA mode... This should be the right thing to do in most cases
> > (however, this hardware has some complications in the form of only 2-bit
> > wide active/recovery counts and 2 fast timing bank select bits)...
> 
> Yeap, that'll be nice.  Dunno whether modifying piix/ata_piix too much
> would be a good idea tho considering the wide usage.

If I remember rightly the 2bits is ok because you can set the bit to say
that timings are for DMA only, the device then uses slower than PIO0 for
all other cycles.

> In both mwdma and pio cases, they're just turning off UDMA.  Don't know
> whether it's actually necessary but still afraid to change it unless
> there is a good reason.

The tuning manual I have does it, so I do it 8)

Alan
