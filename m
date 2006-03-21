From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates
Date: Mon, 20 Mar 2006 20:12:23 -0500
Message-ID: <441F52F7.8030309@garzik.org>
References: <20060320111658.GA16172@havoc.gtf.org> <1142872556.21455.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932259AbWCUBMc@vger.kernel.org>
In-Reply-To: <1142872556.21455.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-03-20 at 06:16 -0500, Jeff Garzik wrote:
> 
>>Jeff Garzik:
>>      [libata] Move PCI IDE BMDMA-related code to new file libata-bmdma.c.
> 
> 
> This is a most confusing choice as 80% of the file has nothing to do
> with bus mastering DMA, and a large amount of it has nothing to do with
> PCI either. Also lots of DMA stuff is in the drivers so all the new bus
> mastering drivers don't use bmdma.c
> 
> The split makes sense, the choice of name is peculiar, if not completely
> broken 8)

Peculiar?  Probably...  :)

In my [no doubt warped] brain, I equate the SFF-8038 interface to "PCI 
IDE BMDMA", and from there, view most hardware as a subset of PCI IDE 
BMDMA.  It might not do DMA, might not be PCI, might not do irqs, but 
most PATA hardware seems able to be driven by a "bmdma driver".  Thus, 
the name :)

	Jeff
