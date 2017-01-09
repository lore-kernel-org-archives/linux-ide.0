From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/3] ata: allow subsystem to be used on m68k arch
Date: Mon, 09 Jan 2017 17:01:25 +0100
Message-ID: <10029890.Tg9y6dSoXd@amdc3058>
References: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <3484511.F6TxDiWTi4@amdc3058> <20170108100823.GD25268@infradead.org>
 <CGME20170109160128epcas1p36a0a8f79b32e5024ffa480fd848e3a79@epcas1p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170108100823.GD25268@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Sunday, January 08, 2017 02:08:23 AM Christoph Hellwig wrote:
> On Fri, Dec 30, 2016 at 06:14:36PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > * m32r: I don't know why it was restricted but it builds fine nowadays
> >   (I will fix it later in incremental patch)
> > 
> > * s390: no PATA hardware, legacy IDE subsystem is also not supported
> 
> s390 now has PCIe support, so PATA could be attached through a PCIe to
> PCI bridge in theory.  And while that is very theoretical not having
> arch ifdefs is still something we should strive for, so I'd suggest
> removing the condition entirely.

I agree.  I will do it later unless someone beats me to it.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
