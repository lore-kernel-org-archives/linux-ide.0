From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Mon, 20 Feb 2006 12:44:23 +0100
Message-ID: <20060220114423.GF8852@suse.de>
References: <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de> <43F342E6.9060909@gmail.com> <20060215151200.GW4203@suse.de> <43F38D49.4080601@pobox.com> <20060216074258.GF4203@suse.de> <43F9A718.1060008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:53345 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932603AbWBTLor (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 06:44:47 -0500
Content-Disposition: inline
In-Reply-To: <43F9A718.1060008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

On Mon, Feb 20 2006, Jeff Garzik wrote:
> >How about making it 256 at the start of a kernel cycle and see if
> >anything falls apart? If IDE works, then surely SATA should as well.
> 
> As I said, it had nothing to do with hardware.  The variable in the 
> equation is the driver code itself, so IDE working implies nothing here, 
> alas.
> 
> Sigh...  I'll search through some old emails.

Hmmm, I'm having a hard time imagining what such a bug would look like
that would cause breakage with 256 sectors and work with 200. Especially
since we already do > 256 for lba48. But let me/us know what you dig up
from the email archives!

-- 
Jens Axboe

