From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] ata_piix: fix suspend/resume for some TOSHIBA laptops
Date: Tue, 24 Jul 2007 18:05:55 -0400
Message-ID: <46A677C3.9090107@garzik.org>
References: <20070710063605.GA21994@htj.dyndns.org>	<20070710065543.GA23568@htj.dyndns.org>	<46A66842.6040803@garzik.org> <20070724225747.1dd4d141@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59796 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755079AbXGXWF7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jul 2007 18:05:59 -0400
In-Reply-To: <20070724225747.1dd4d141@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, greg@kroah.com, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

Alan Cox wrote:
>> A more generalized rule to consider for the future would be to ensure 
>> that ALL suspend routines put the hardware back into its pre-Linux init 
>> mode before suspending.  i.e. that means if we turned on some enhanced 
>> mode, we must switch back to legacy mode before calling pci_xxx to 
>> suspend our device.
> 
> This sounds good but for some hardware you can't get it back into that
> state and there is no guarantee some laptops don't have ACPI suspend
> paths that "know" Windows will have reconfigured the hardware.

Good point.  To generalize a bit more:  it is quite possible that many 
situations will require us to put the hardware device into a certain 
mode before suspending, a mode that Linux may not currently be operating 
in.  ata_piix is definitely not going to be the only one needing this 
change, long term.

	Jeff



