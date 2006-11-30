From: Olaf Hering <olaf@aepfle.de>
Subject: Re: pata_sl82c105 can not reserve IO region
Date: Thu, 30 Nov 2006 19:47:48 +0100 (MET)
Message-ID: <20061130184748.GA24071@aepfle.de>
References: <20061130165202.GA23205@aepfle.de> <20061130171049.7b80a40c@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:10426 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1031010AbWK3SsY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 13:48:24 -0500
Content-Disposition: inline
In-Reply-To: <20061130171049.7b80a40c@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

On Thu, Nov 30, Alan wrote:

> I/O region #6.
> 
> pci_request_regions() and pci_request_selcted_regions() end up in a loop
> calling pci_request_region with the values 0 to 5. Never 6.

The printk in pci_request_region has 'bar + 1', so 6 should be possible
if i becomes 5.

I see the failure in 2.6.16 and 2.6.18 too, if that matters. Will look
at it tomorrow.
