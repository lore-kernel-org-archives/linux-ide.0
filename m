From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] ata: allow subsystem to be used on m68k arch
Date: Sun, 8 Jan 2017 02:08:23 -0800
Message-ID: <20170108100823.GD25268@infradead.org>
References: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <1483106478-1382-2-git-send-email-b.zolnierkie@samsung.com>
 <20161230141249.GA4543@infradead.org>
 <CGME20161230171438epcas1p3c1d8ea8e4c77d796b81f7130c5e61d3f@epcas1p3.samsung.com>
 <3484511.F6TxDiWTi4@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3484511.F6TxDiWTi4@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Dec 30, 2016 at 06:14:36PM +0100, Bartlomiej Zolnierkiewicz wrote:
> * m32r: I don't know why it was restricted but it builds fine nowadays
>   (I will fix it later in incremental patch)
> 
> * s390: no PATA hardware, legacy IDE subsystem is also not supported

s390 now has PCIe support, so PATA could be attached through a PCIe to
PCI bridge in theory.  And while that is very theoretical not having
arch ifdefs is still something we should strive for, so I'd suggest
removing the condition entirely.
