From: Andy Warner <andyw@pobox.com>
Subject: Re: WARN_ON(buflen > PAGE_SIZE) libata-core.c
Date: Thu, 16 Sep 2004 21:34:50 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040916213450.A14950@florence.linkmargin.com>
References: <20040901150801.A12145@florence.linkmargin.com> <414A34A6.1020506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:46487 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S268410AbUIQCgp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Sep 2004 22:36:45 -0400
Content-Disposition: inline
In-Reply-To: <414A34A6.1020506@pobox.com>; from jgarzik@pobox.com on Thu, Sep 16, 2004 at 08:49:42PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> > In libata-core.c:ata_sg_init_one() there is:
> > 
> > 	WARN_ON(buflen > PAGE_SIZE);
> [...]
> A non-scatter-gather transfer is assumed to be one page in length, using 
> only a single 'struct scatterlist' element.  You could probably "cheat" 
> and indicate the scatterlist element is longer than PAGE_SIZE, but make 
> sure to review all code paths...

Bear with me, if I'm being dense, but why is that a valid
assumption ? Is it because in most instances, such requests
are made by filesystem code, as opposed to arbitrary user
initiated I/O ?
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
