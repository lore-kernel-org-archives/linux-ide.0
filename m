From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: kill spurious assignment in piix_sata_probe()
Date: Sun, 12 Feb 2006 14:18:01 -0500
Message-ID: <43EF89E9.1040601@pobox.com>
References: <20060212100507.GA20979@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:29914 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750870AbWBLTSF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 14:18:05 -0500
In-Reply-To: <20060212100507.GA20979@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> In piix_sata_probe(), mask gets assigned unnecessarily at the
> beginning of the function.  Kill the assignment.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
> This patch is against
> the current upstream (bef4a456b8dc8b3638f4d49a25a89e1467da9483)
> + http://article.gmane.org/gmane.linux.ide/7967
> + http://article.gmane.org/gmane.linux.ide/7968 (2 patches)

applied, though this function needs a further look:

1) We should really:

* enable port X via PCS, if not already
* delay a bit, for SATA device detection
* check 'present' bit
* if nothing present, disable port X via PCS


2) In ICH6 and later, according to the docs:  PCS enable bits should 
always be set, and the port should be controlled via SATA phy registers. 
  As I noted in another email, ICH6+ should support SATA PHY registers 
even if AHCI is disabled.  See bit 9 of SIR (94h) register in ICH6 and 
ICH7, which enables access to SATA PHY regs.


I am hoping that we can make all ICH6/7 use SATA PHY registers, but I am 
worried that in some cases the AHCI BAR may not have been assigned a value.

	Jeff


