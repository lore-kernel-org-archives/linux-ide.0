From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: does AHCI work on intel 915 ICH6 controllers? Is it supposed
 to?
Date: Sat, 18 Jun 2005 16:40:18 -0400
Message-ID: <42B486B2.6050608@pobox.com>
References: <d87q4j$d37$1@sea.gmane.org> <42A7A191.7040700@pobox.com>	 <d89hcm$7ej$1@sea.gmane.org> <42AD0305.5060705@tw.ibm.com> <c195ebf705061813191a48a69f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:44179 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261299AbVFRUkW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Jun 2005 16:40:22 -0400
In-Reply-To: <c195ebf705061813191a48a69f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sean darcy <seandarcy2@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

sean darcy wrote:
> Mine is also 0x2651.
> 
> But I must be blind, but I don't see any statement that  only  -R and
> -M have AHCI support.


Here's my statement :)

PCI ID 0x2651 does not have AHCI support in the chip.

No amount of BIOS poking can fix that.

	Jeff


