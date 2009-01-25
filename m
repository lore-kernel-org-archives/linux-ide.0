From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Switching from (deprecated) IDE driver -> SATA (PATA support)
Date: Sun, 25 Jan 2009 11:07:42 +0000
Message-ID: <20090125110742.4ba54c0b@lxorguk.ukuu.org.uk>
References: <alpine.DEB.1.10.0901250553430.2441@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47405 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752060AbZAYLHc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jan 2009 06:07:32 -0500
In-Reply-To: <alpine.DEB.1.10.0901250553430.2441@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> and I cannot upgrade the kernel anymore unless I move to the 
> PATA-supported SATA driver, but I have no idea what the root disk will be 
> after a reboot and there is a high probability it will not come back after 
> a reboot..

Easiest is to use labels. Old ide will keep hda,b,c,d constant
providing you have interfaces using the legacy IDE port mappings (0x1f0
and 0x170). Libata doesn't do that as pretty much every distribution had
already switched to volume labels, and the user space can do the job far
better than the kernel - especially as the newer devices with modern
interfaces don't have the old BIOS/DOS legacy ideas any more.

Mount by label also means you can flip back and forth between the
different drivers and kernel revisions.

Alan
