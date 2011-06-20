From: Tim Small <tim@seoss.co.uk>
Subject: Re: Does Intel Sandy Bridge MB Sata support port multipliers?
Date: Mon, 20 Jun 2011 10:43:30 +0100
Message-ID: <4DFF1642.4040404@seoss.co.uk>
References: <20110620045138.GB21438@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([78.47.234.210]:34981 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab1FTJnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 05:43:35 -0400
In-Reply-To: <20110620045138.GB21438@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: linux-ide@vger.kernel.org

On 20/06/11 05:51, Marc MERLIN wrote:
> I upgraded the system and was hoping to use onboard sata (it's a Sandy
> Bridge lga1155).
>   

Which chipset?  Perhaps lspci of the ahci controller device?

> When I plug my PMP into that, the other drives are not detected.
>
> Where do I find the list of SATA drivers that support PMP.
>   

It's dependant on the hardware and the driver...

https://ata.wiki.kernel.org/index.php/SATA_hardware_features



> Are newer intel MBs with onboard SATA supposed to work?
>   

I believe Intel limit PMP support to certain chipsets and versions (for
"product differentiation" marketing reasons).  I have an H67 motherboard
here, and PMP is supported on all 6 ports, but only in "CBS" mode (i.e.
poor performance if you try to access two drives concurrently).

I'm currently wrestling with PMP support on Marvell AHCI devices....

It seems to work on an 88SE9125 with recent firmware, but not working
with an 88SE9123 with older firmware.  I'm planning on doing further
debug later today.

> ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
>   

no "pmp" in that flag list :-(

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

