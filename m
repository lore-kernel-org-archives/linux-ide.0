From: Jeff Garzik <jeff@garzik.org>
Subject: Re: pata_amd dropping to PIO on resume
Date: Tue, 20 Feb 2007 10:27:59 -0500
Message-ID: <45DB137F.1060301@garzik.org>
References: <fa.q7ZuddHInqn2dVlS+EWjXjPvFC8@ifi.uio.no>	<45D63BCE.2080700@shaw.ca>	<45D6436C.4060209@garzik.org> <20070219220812.11c3baba@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43752 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965049AbXBTP2G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 10:28:06 -0500
In-Reply-To: <20070219220812.11c3baba@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockr@shaw.ca>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Alan wrote:
>> Deleting the ata_pci_clear_simplex() call, then adding 
>> ATA_FLAG_IGN_SIMPLEX to the ata_port_info info[] array, is also worth 
>> trying.
> 
> I think I know what is going on here. Firstly the simplex bits
> need re-clearing on a resume. On my todo list now I'm back

If the bit does not actually alter /hardware/ operation, then
ATA_FLAG_IGN_SIMPLEX use is preferred over having to remember various 
places where the bit must be twiddled.  Its easier to leave the bit in 
the BIOS-initialized state, and ignore the hardware bit's existence in 
software, if we know the behavior in the controller is hardwired.  Less 
room for software bugs that way, IMO.

	Jeff


