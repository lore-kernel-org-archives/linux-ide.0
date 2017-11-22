From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 12/30] Drivers: ide: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 08:53:02 +0100
Message-ID: <20171122075302.GB26583@kroah.com>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-13-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbdKVHw6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Nov 2017 02:52:58 -0500
Content-Disposition: inline
In-Reply-To: <1511328675-21981-13-git-send-email-okaya@codeaurora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, "open list:IDE SUBSYSTEM" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Nov 22, 2017 at 12:30:57AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.

While this is a great generic text, you might want to make it a bit more
custom to each specific patch.  For example, you don't use a domain of 0
in this one, so the text is a bit wrong and confusing if you look at it
stand-alone.

I like the series and the idea, just fix up this text in some of the
patches and you should be fine.

thanks,

greg k-h
