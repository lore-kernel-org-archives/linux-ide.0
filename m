From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream] ahci/sata_vsc: drop intx manipulation on msi
 enable
Date: Sun, 01 Feb 2009 10:32:30 +0900
Message-ID: <4984FBAE.1090709@kernel.org>
References: <49792C0B.6070602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33783 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbZBABcq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2009 20:32:46 -0500
In-Reply-To: <49792C0B.6070602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> There's no need to turn off intx explicitly on msi enable.  This is
> automatically handled by pci.  Drop it.
> 
> Note that, in sata_vsc's case, it was completely redundant; however,
> for ahci, it might be needed on machines if the BIOS turns intx off
> during boot.  However, there's no evidence of such behavior for ahci
> and the only such case seems to be ICH5 PATA according to ata_piix.
> Also, given the way ahci operates, it's highly unlikely BIOS ever
> disables IRQ for the controller.  However, as this change has slight
> possibility of introducing failure, please schedule it for #upstream.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Ping.

-- 
tejun
