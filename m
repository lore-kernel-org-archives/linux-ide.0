From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DVD drive not recognized on Intel G965 (2.6.19-rc2)
Date: Tue, 17 Oct 2006 23:32:29 +0100
Message-ID: <1161124349.5014.12.camel@localhost.localdomain>
References: <20061017180420.GD24789@tau.solarneutrino.net>
	 <453533AB.9020801@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28573 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750807AbWJQWGC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Oct 2006 18:06:02 -0400
In-Reply-To: <453533AB.9020801@argo.co.il>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Avi Kivity <avi@argo.co.il>
Cc: Ryan Richter <ryan@tau.solarneutrino.net>, "Dr. David Alan Gilbert" <dave@treblig.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Maw, 2006-10-17 am 21:48 +0200, ysgrifennodd Avi Kivity:
> > I tried the JMicron driver, but it didn't find a controller.  This board
> > has only one PATA port, and I'm pretty sure it's from the Intel
> > southbridge.

JMB368 by the sound of it, this should "just work" with either the
generic pci driver in 2.6.18.1 or later, or the jmicron driver if you
have libata support enabled.

> Try adding all-generic-ide to the kernel command line, and if that 
> fails, post your lspci output.

Please cc me on any jmicron chipset problems. I've got
hardware/docs/nice man at Jmicron to ask questions of

