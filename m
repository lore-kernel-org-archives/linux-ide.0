From: Tejun Heo <tj@kernel.org>
Subject: Re: [stable] [PATCH] ahci: restore pci_intx() handling
Date: Thu, 17 Sep 2009 00:52:02 +0900
Message-ID: <4AB109A2.5080504@kernel.org>
References: <4AB1058F.3070108@kernel.org> <20090916154807.GA27478@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38627 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753681AbZIPPwm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Sep 2009 11:52:42 -0400
In-Reply-To: <20090916154807.GA27478@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org, Jeff Garzik <jeff@garzik.org>, Thomas Jarosch <thomas.jarosch@intra2net.com>

Greg KH wrote:
> In the future, for stuff that you want sent to stable, can you also add:
> 	Cc: stable <stable@kernel.org>
> in this signed-off-by area?  That way, when the patch hits Linus's tree,
> we get automatically notified of it and I don't have to dig back through
> log files to try to find out if your commit has made it in or not.

Ah... new protocol.  Will do.

Thanks.

-- 
tejun
