From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 82/86] pata_via: clear UDMA transfer mode bit for PIO
 and MWDMA
Date: Wed, 25 Nov 2009 18:06:48 +0000
Message-ID: <20091125180648.6ab19725@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125171218.5446.41962.sendpatchset@localhost>
	<20091125175257.796afeb3@lxorguk.ukuu.org.uk>
	<200911251858.38491.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934879AbZKYSEq@vger.kernel.org>
In-Reply-To: <200911251858.38491.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> Do you really find such tidy patch hard to review?

When doing it at speed - yes.

>  	/* Set UDMA unless device is not UDMA capable */
> -	if (udma_type && t.udma) {
> -		u8 cable80_status;
> +	if (udma_type) {
> +		u8 udma_etc;

Ok that makes sense - we in fact could hit this case on a failure
changedown from UDMA to PIO.
