From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Tue, 3 Jan 2006 11:56:56 -0500
Message-ID: <20060103165656.GA1270@havoc.gtf.org>
References: <20060103164319.GA402@havoc.gtf.org> <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:48770 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751468AbWACQ45 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2006 11:56:57 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e0601030851w62fc917bibe0fd5069b2f3e44@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 05:51:57PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 1/3/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > --- a/drivers/scsi/ata_piix.c
> > +++ b/drivers/scsi/ata_piix.c
> 
> > + * with SITRE and the 0x44 timing register). See pata_oldpiix and pata_mpiix
> > + * for the early chip drivers.
> 
> pata_oldpiix and pata_mpiix are not in the mainline

Good point.  I'll update to say "in libata-dev#pata-drivers".

	Jeff



