From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates
Date: Tue, 21 Mar 2006 11:40:49 -0500
Message-ID: <44202C91.30601@garzik.org>
References: <20060320111658.GA16172@havoc.gtf.org>	 <1142872556.21455.7.camel@localhost.localdomain>	 <441F52F7.8030309@garzik.org> <1142936420.21455.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:11409 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750818AbWCUQkv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 11:40:51 -0500
In-Reply-To: <1142936420.21455.26.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-03-20 at 20:12 -0500, Jeff Garzik wrote:
> 
>>In my [no doubt warped] brain, I equate the SFF-8038 interface to "PCI 
>>IDE BMDMA", and from there, view most hardware as a subset of PCI IDE 
>>BMDMA.  It might not do DMA, might not be PCI, might not do irqs, but 
>>most PATA hardware seems able to be driven by a "bmdma driver".  Thus, 
>>the name :)
> 
> 
> Most of that file is ST-506 type register interfaces, only a tiny bit is
> SFF PCI IDE with DMA.
> 
> Expect some patches soon. I've got my tree merged against the git tree
> now, just needs some testing.

To be specific, are the patches against libata-dev.git 'upstream' branch?

(most should apply to Linus-vanilla branch, so regardless of the 
definition of "the git tree" it should be OK)

	Jeff



