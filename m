From: Alan Cox <alan@redhat.com>
Subject: Re: [patch for 2.6.24? 1/1] libata: correct handling of TSS DVD
Date: Tue, 15 Jan 2008 16:01:59 -0500
Message-ID: <20080115210159.GA13282@devserv.devel.redhat.com>
References: <200801140906.m0E96Ks2020536@imap1.linux-foundation.org> <478D1CF9.1040707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbYAOVCx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jan 2008 16:02:53 -0500
Content-Disposition: inline
In-Reply-To: <478D1CF9.1040707@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Tue, Jan 15, 2008 at 03:52:09PM -0500, Jeff Garzik wrote:
> > {
> >-	if (ata_id_is_sata(dev_id))
> >-		return 0;	/* SATA */
> > 	if ((dev_id[93] & 0x2000) == 0x2000)
> > 		return 0;	/* 80 wire */
> > 	return 1;
> 
> 
> Alan, is this .24 material?
> 
> There were a lot of different threads and BZs about this one device, and 
> I want to triple-check that multiple fixes are not being applied 
> independently for the same problem.

Yes.

Without this fix a TSScorp CD-ROM on 40 wire ata reports itself as SATA

Alan

