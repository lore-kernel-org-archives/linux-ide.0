From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 12:31:01 +0100
Message-ID: <20080506113101.GA14542@srcf.ucam.org>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506084625.GA10817@srcf.ucam.org> <48201C7D.1070303@gmail.com> <20080506091718.GA11617@srcf.ucam.org> <20080506112145.GA8560@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:57314 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbYEFLbR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 07:31:17 -0400
Content-Disposition: inline
In-Reply-To: <20080506112145.GA8560@homac>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Tue, May 06, 2008 at 01:21:45PM +0200, Holger Macht wrote:

> Not by default. The dock driver immediately undocks unless
> immediate_undock parameter is set to 0. Any access to the bay inside the
> dock afterwards might freeze the system.
> 
> Actually I was talking about the "bay not in the dock"-case here.

In that case, the effect differs depending on the hardware. In the ideal 
universe, Thinkpad users flick out the eject lever and wait for a 
confirmation that they can pull out the drive. Dell and HP users have to 
request a safe remove in advance.

> There are those which do simple PCI hotplugging without the involvement of
> ACPI (many/all HPs AFAIK) and those which present themselves as a
> dockstation through ACPI (those with a _DCK method). The thinkpad X60 dock
> I have here has the request button, too.

Right. In that case, it needs to be possible for userspace to indicate 
that the eject request should not automatically destroy the device. 
Actually removing the dock should do so in all circumstances.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
