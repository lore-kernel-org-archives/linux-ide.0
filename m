From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: new sata_sis.c file
Date: Mon, 28 Feb 2005 16:45:55 -0500
Message-ID: <42239113.3050506@pobox.com>
References: <1834e00e828e13c6c43b5dd98fd1f4c6@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58334 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261771AbVB1VqP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 16:46:15 -0500
In-Reply-To: <1834e00e828e13c6c43b5dd98fd1f4c6@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-ide@vger.kernel.org

Gary Poppitz wrote:
> Looks like SIS updated their sata_sis.c file but did not bother to  
> update its revision level. Jeff, would you add this to the current dev  
> build?

It needs a lot of work before that can happen.

It hardcodes things in the driver that need to be in the core instead, 
namely the dword alignment that fixes ATAPI issues across all SATA 
controllers.

It looks like they removed all the duplicate libata-scsi.c code that was 
in their previous submission, though, which is good.

	Jeff



