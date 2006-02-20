From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Mon, 20 Feb 2006 14:58:10 +0100
Message-ID: <20060220135809.GK8852@suse.de>
References: <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de> <43F342E6.9060909@gmail.com> <20060215151200.GW4203@suse.de> <43F38D49.4080601@pobox.com> <43F3B3CE.5060105@pobox.com> <43F9A6A8.4020606@pobox.com> <43F9CA10.8000206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:7538 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030228AbWBTN6W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 08:58:22 -0500
Content-Disposition: inline
In-Reply-To: <43F9CA10.8000206@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Mon, Feb 20 2006, Mark Lord wrote:
> Jeff Garzik wrote:
> >
> >Indeed.  I am paranoid about controllers assuming that no more than 256 
> >PRD entries will be submitted.  But I have never seen any document that 
> >says PCI IDE BMDMA hardware can -only- do 256 PRD entries.  Never tested 
> >it, either...
> 
> The hardware vendors I have worked with have never had any limit
> on PRD count -- they'd happily keep reading through an infinite
> list of PRDs if we could supply one.
> 
> A number of them did have issues with 64KB boundary crossings,
> and it is generally VERY unsafe to have a single PRD "wrap"
> into a fresh 64KB segment mid-stride.

Both IDE and libata take care not to make that happen, so we should be
fine there. The block layer also supports this property.

-- 
Jens Axboe

