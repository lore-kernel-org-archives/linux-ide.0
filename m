From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata atapi work #5
Date: Fri, 14 May 2004 16:15:58 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A528FE.8040301@pobox.com>
References: <1084560167.8752.7.camel@patibmrh9> <40A5195C.2000402@pobox.com>	<1084562845.8752.37.camel@patibmrh9>  <40A5225B.9000907@pobox.com> <1084564801.3084.13.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262580AbUENUQO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 16:16:14 -0400
In-Reply-To: <1084564801.3084.13.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> Jeff G:
> 
> 
>>an open IP core 
>>compliant to the AHCI specification:
>>http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
> 
> 
> Does the web now offer PCI chip designs in open source?

Yes.  http://www.opencores.org/projects.cgi/web/pci

The above IP core bridges from the PCI bus to the internal wishbone [IP 
core interconnect] bus.

In theory, you connect your AHCI IP core to the PCI IP core via 
wishbone.  opencores.org also has a wishbone-compliant DMA engine.


> 1987..1990 or so I did register-transfer-level chip design (a la
> Verilog).  I naturally prefer concurrent designs over sequential.

All good EE designs are concurrent rather than sequential ;-)

But I'm a computer scientist, what do I know...

	Jeff



