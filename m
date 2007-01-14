From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_vsc.c cache line size question
Date: Sun, 14 Jan 2007 13:21:49 -0500
Message-ID: <45AA74BD.9020803@garzik.org>
References: <92952AEF1F064042B6EF2522E0EEF43703EE316A@EXNA.corp.stratus.com>	<20070114080301.GD61246@sgi.com> <20070114144722.73fe0b49@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42809 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbXANSVz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Jan 2007 13:21:55 -0500
In-Reply-To: <20070114144722.73fe0b49@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jeremy Higdon <jeremy@sgi.com>, "Dailey, Nate" <Nate.Dailey@stratus.com>, linux-ide@vger.kernel.org

Alan wrote:
>> So I suppose the driver should be modified to set it to 0x80 only
>> if it's 0.  I believe that most PCI implementations will set it in
>> the BIOS or whatever.
> 
> pci_set_master should handle this automtically on most platforms.

pci_set_master() sets the latency timer not cacheline size

pci_set_mwi() on x86-ish platforms sets cacheline size.

	Jeff



