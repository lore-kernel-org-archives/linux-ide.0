From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add Marvell 6141 PATA support to AHCI driver
Date: Sat, 07 Jul 2007 11:29:23 -0400
Message-ID: <468FB153.5040404@garzik.org>
References: <20070527030954.GA18974@havoc.gtf.org> <22E26940476D1E48AA6F292B5316C9C33827@bes1.peakin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35486 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529AbXGGP3Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jul 2007 11:29:25 -0400
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33827@bes1.peakin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "George T. Joseph (development)" <gtj.devel@peakin.com>
Cc: linux-ide@vger.kernel.org

George T. Joseph (development) wrote:
> Jeff,
> 
> Any news from Marvell on the msi and ncq issues?  

Only terse "NCQ works for us" and "we don't turn on PCI MSI ourselves" 
answers... :)

So my current plan is to disable NCQ and guarantee PCI MSI is not 
enabled for Marvell AHCI-like devices, and push SATA support upstream.

Marvell AHCI-like PATA support (branch mv-ahci-pata) will take a little 
bit longer, since it definitely needs a fix to its "PATA controller 
command" code.

	Jeff



