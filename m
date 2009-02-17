From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/6] ide: add ->dma_expiry method and remove ->dma_exec_cmd one
Date: Tue, 17 Feb 2009 15:16:33 +0100
Message-ID: <200902171516.34091.bzolnier@gmail.com>
References: <20090209231945.32406.14874.sendpatchset@localhost.localdomain> <200902111730.39460.bzolnier@gmail.com> <49930B2D.8090503@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753222AbZBQOPj@vger.kernel.org>
In-Reply-To: <49930B2D.8090503@ru.mvista.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 11 February 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>Bartlomiej Zolnierkiewicz wrote:
> 
> >>>* Rename dma_timer_expiry() to ide_dma_sff_expiry() and export it.
> 
> >>>* Add ->dma_expiry method
> 
> >>    This name doesn't seem to make much sense. Why not leave it dma_timer_expiry?
> 
> > Well, the name matches with hwif->expiry one + the downside of leaving it at
> > dma_timer_expiry is a need to reformat all struct ide_dma_ops instances...

On the 2nd look it doesn't seem to be a problem (I must have been looking at
some odd case previously) -- I'll fix it up later.
