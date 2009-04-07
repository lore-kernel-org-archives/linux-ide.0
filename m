From: Tejun Heo <tj@kernel.org>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Tue, 07 Apr 2009 16:57:12 -0700
Message-ID: <49DBE858.9040004@kernel.org>
References: <49DB6914.1030107@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38443 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbZDGX6R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 19:58:17 -0400
In-Reply-To: <49DB6914.1030107@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Hello,

Timur Tabi wrote:
>> ahci: drop intx manipulation on msi enable
>>     
>>     There's no need to turn off intx explicitly on msi enable.  This is
>>     automatically handled by pci.  Drop it.
>>     
>>     This might be needed on machines if the BIOS turns intx off during
>>     boot.  However, there's no evidence of such behavior for ahci and
>>     the only such case seems to be ICH5 PATA according to ata_piix.
>>     Also, given the way ahci operates, it's highly unlikely BIOS ever
>>     disables IRQ for the controller.  However, as this change has slight
>>     possibility of introducing failure, please schedule it for #upstream.
> 
> breaks SATA support on a Freescale MPC8610 HPCD (PowerPC) reference
> board.  When I apply the patch, I get this result during boot:
...
> This board uses a ULI M1575 for SATA support.
> 
> Unfortunately, I don't know enough about SATA or PCI interrupts to
> understand why you made the change or why it breaks on my board.

cc'ing Jeff.

Hmmm... that means intx isn't set by default.  I'm not sure what is
the right thing to do here.  I think it's something which should be
handled by the PCI layer.  Oh well, maybe we should just revert the
change and keep setting intx?

Thanks.

-- 
tejun
