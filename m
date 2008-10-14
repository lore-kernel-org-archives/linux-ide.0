From: Tejun Heo <tj@kernel.org>
Subject: Re: VIA SATA/PATA problem
Date: Tue, 14 Oct 2008 11:11:31 +0900
Message-ID: <48F3FFD3.6090009@kernel.org>
References: <1223559916.13924.13.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45318 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbYJNCNH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 22:13:07 -0400
In-Reply-To: <1223559916.13924.13.camel@jetpack.demon.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Alan Hourihane wrote:
> Hi,
> 
> I've got a VIA SATA/PATA PCI RAID card installed in a MIPS box, which
> obviously doesn't run the BIOS on the card.
> 
> When booting these messages appear....

Care to post lspci -nn?

-- 
tejun
