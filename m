From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata drain fifo on stuck DRQ HSM violation
Date: Sat, 29 Sep 2007 07:28:31 +0100
Message-ID: <20070929072831.2df5f5ed@the-village.bc.nu>
References: <46CFA08E.6090604@arbores.ca>
	<6bffcb0e0708261610g10d9c59ck5789fac6feca9f42@mail.gmail.com>
	<46DBCB6C.8080206@gmail.com>
	<20070905095327.6277d054.akpm@linux-foundation.org>
	<46DEE617.4050004@rtr.ca>
	<46E0A253.7060803@gmail.com>
	<46E154DE.2060602@rtr.ca>
	<46FB563A.80108@gmail.com>
	<20070927193701.6230d77f@the-village.bc.nu>
	<46FC3D7D.90009@gmail.com>
	<46FC3FDD.5060201@pobox.com>
	<46FC423C.2050206@gmail.com>
	<46FC7B72.2030103@rtr.ca>
	<20070928112735.264733ad@the-village.bc.nu>
	<46FDA4F3.7050205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757898AbXI2GX3@vger.kernel.org>
In-Reply-To: <46FDA4F3.7050205@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, michal.k.k.piotrowski@gmail.com, bryan@arbores.ca, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> > Why 512 words ?
> 
> Though I have queued Mark's patch to be applied, my gut feeling would 
> lean towards a single DRQ block, rather than 512.

Why not just work from the old IDE code.
> 
> 
> >>  	ata_altstatus(ap);
> >> -	ata_chk_status(ap);
> >> +	ata_drain_fifo(ap, qc);
> > 
> > ap->ops->cleanup();
> > 
> > might be wiser
> 
> If someone needs that, they can override the error handler with their 
> own.  No need for a new op.

PDC202xx needs
