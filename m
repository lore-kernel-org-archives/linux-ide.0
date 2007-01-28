From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] libata IORDY handling
Date: Sun, 28 Jan 2007 19:03:25 +0000
Message-ID: <20070128190325.7ba9af66@localhost.localdomain>
References: <200701282024.17518.sshtylyov@ru.mvista.com>
	<45BCEA03.8070901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59712 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752478AbXA1Svq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jan 2007 13:51:46 -0500
In-Reply-To: <45BCEA03.8070901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, htejun@gmail.com

>     I looked into fixing this but had a feeling that the thing wasn't right 
> from the very start, including ata_pio_need_iordy().  In my understanding of 
> the ANSI T13 stadrads, when one issues Set Features subcommand Set Transfer 
> Mode with sector count register of 0x8 thru 0xC this means that IORDY *must* 
> be enabled. 

Yes. It is more complex than the current code handles. That's one reason
I added ata_pio_need_iordy(), because it would need to change and
hardcoding it would be particularly ugly.

This will matter for supporting some utterly ancient junk.

Alan
