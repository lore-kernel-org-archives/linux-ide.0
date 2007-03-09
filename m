From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: implement and use DMA mask configuration helper
Date: Fri, 09 Mar 2007 07:41:07 -0500
Message-ID: <45F155E3.9040604@garzik.org>
References: <20070309104945.GG32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55603 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767215AbXCIMlK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:41:10 -0500
In-Reply-To: <20070309104945.GG32687@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement and use DMA mask configuration helper.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This function probably belongs to pci layer.  Put it in libata with
> pci_test_bits() for the time being.

AFAIK the default DMA mask is always 32-bit.  Code (often written by me) 
that sets it to a 32-bit mask was just paranoia, and not really needed.

Hence, the pci_go_64() function I added, found in #upstream.

	Jeff



