From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: WARN_ON(buflen > PAGE_SIZE) libata-core.c
Date: Thu, 16 Sep 2004 20:49:42 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <414A34A6.1020506@pobox.com>
References: <20040901150801.A12145@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4486 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265053AbUIQAty
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Sep 2004 20:49:54 -0400
In-Reply-To: <20040901150801.A12145@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org

Andy Warner wrote:
> I'm working on a tree pulled directly from
> bk://gkernel.bkbits.net/libata-2.6
> 
> In libata-core.c:ata_sg_init_one() there is:
> 
> 	WARN_ON(buflen > PAGE_SIZE);
> 
> Which (unsurpsingly) triggers for all non-tiny
> transfers (I'm using sg_utils to generate disk
> traffic.)
> 
> It's obviously there for a reason, what would
> I need to do to get past it. Give me some background
> and maybe I can come up with a patch :)


A non-scatter-gather transfer is assumed to be one page in length, using 
only a single 'struct scatterlist' element.  You could probably "cheat" 
and indicate the scatterlist element is longer than PAGE_SIZE, but make 
sure to review all code paths...

	Jeff


