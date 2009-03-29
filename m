From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Removing PCI dependency of ahci and making it amba bus
  compatible
Date: Sun, 29 Mar 2009 18:46:57 -0400
Message-ID: <49CFFA61.8000107@pobox.com>
References: <3fb94e50903260700r36365d4ue27edf43b5ee9efd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49999 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbZC2WrI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Mar 2009 18:47:08 -0400
In-Reply-To: <3fb94e50903260700r36365d4ue27edf43b5ee9efd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Comments:

* I am concerned at the unmodified duplication of so much code.  Given 
that so little core AHCI modification was done, I would be interested in 
exploring alternatives to wholesale code duplication.

* Avoid global variables.  Use a private struct and hpriv rather than 
creating globals such as 'amba_base'

* calls to ioremap() must handle NULL return values.  You can 
ahci_save_initial_config() from a simple table lookup to an actual map

* Don't add magic numbers like '0' to replace AHCI_PCI_BAR.  Create your 
own symbol AMBA_IOMAP_IDX or somesuch, with value zero.

* ahci_configure_dma_masks() is wrong.  You must call generic DMA 
mapping API or amba bus DMA mapping API (if exists), since you cannot 
call PCI DMA mapping API.

* amba_request_regions() should pass the driver name ("ahci"), not the 
more-generic "sata"

* we put spaces between all function parameters.  You incorrect elide 
spaces such as in this example:

-	rc = ahci_reset_controller(host);
+	rc = ahci_reset_controller(host,pdev);

* there is nothing AMBA-specific about the implementation of function 
ata_amba_remove_one().  I would rather ata_amba_remove_one() be a 
one-line call to a function that works on generic struct device-based 
devices.

	Jeff




