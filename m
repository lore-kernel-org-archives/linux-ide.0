From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 8/20] libata: reimplement ata_pci_init_one() using new
 init helpers
Date: Tue, 19 Sep 2006 02:09:11 -0400
Message-ID: <450F8987.8020202@pobox.com>
References: <11559779723326-git-send-email-htejun@gmail.com> <450F80E5.7080009@pobox.com> <450F8865.70804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55968 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964935AbWISGJb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 02:09:31 -0400
In-Reply-To: <450F8865.70804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> NAK -- you can't do anything with the PCI device before calling 
>> pci_enable_device()
> 
> This is what we're currently doing in ata_pci_init_one().  I thought the 


You just found a bug in the current code :)

