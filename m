From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 10:36:28 +0100
Message-ID: <20080506093628.GA12469@srcf.ucam.org>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506092653.GB4378@homac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:46227 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbYEFJgi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 05:36:38 -0400
Content-Disposition: inline
In-Reply-To: <20080506092653.GB4378@homac>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Tue, May 06, 2008 at 11:26:53AM +0200, Holger Macht wrote:

> No. The moment when the bay event is generated, the moment the user pushes
> the lever on the bay, the user might immediately pull out the device,
> letting no chance for cleaning up...There must be an event before the user
> touches anything, to have the time to unmount etc. and then tell "now it's
> save to remove the bay device". This would also solve the "there's no bay
> event" case.

Hm. The hardware I have here has a separate "eject request" button and 
"physical eject" button. Hitting the former sends the request to the OS, 
and the light then pulses until the OS confirms that the dock can be 
removed. If the user removes the dock before this happens, that's user 
error. Unfortunately, the hardware in question doesn't contain a bay. 
The only dock I have with no request button doesn't present as an ACPI 
dock to begin with. Do Thinkpad docks differ from this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
