From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: 2.6.23.1 - sata_mv (7042) hang with large file operations
Date: Thu, 15 Nov 2007 10:43:24 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010AAE9007@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com> <45ED682A.9040408@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010A7E1B45@EMPBEDEX.empirix.com> <4728A816.8020608@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010AAE852F@EMPBEDEX.empirix.com> <473B36D7.8000205@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE8585@EMPBEDEX.empirix.com> <473B44CB.6010209@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE89CA@EMPBEDEX.empirix.com> <473B76E0.7010500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:7258 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757901AbXKOPnb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 10:43:31 -0500
Content-class: urn:content-classes:message
In-Reply-To: <473B76E0.7010500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I have a console - and have booted with 

	"pci=nomsi" and the behavior is 
	~the same or even a little worse 
	in some case (but not by much)...

I will send kernel log & the .config file separately to you...
(quite long)...

Further, you should note that my arch/ppc does NOT have MSI
Capability (CONFIG_PCI_MSI) - thus I think this might be

Is there any debugging I can turn on in the proc or sysfs?
that might give more clues (e.g.: /proc/sys/dev/scsi/logging_level)?

t






-----Original Message-----
From: Mark Lord [mailto:liml@rtr.ca] 
Sent: Wednesday, November 14, 2007 5:30 PM
To: Morrison, Tom
Cc: Jeff Garzik; linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: 2.6.23.1 - sata_mv (7042) hang with large file operations

Morrison, Tom wrote:
> I have gotten it to boot from those hard-drives and it 
> has the same behavior:
> 
>   	Copying a large file to the same partition (>150MEG) 
>   	causes the system to hang (no I/O - no input/output - 
>   	nothing - complete freeze - like a primary resource 
>   	is locked up or interrupts got completely & totally 
>   	turned off in an ISR and its pending for something?
> 
> Only way to get out of this is to power-cycle the box!
..

Okay, a couple of things:

Do this from a text console, not a GUI.
And preferably without ever starting klogd/syslogd during init.

That way you've a much better chance of seeing some kernel diagnostic
messages when it locks up.

Can you boot with "nomsi" kernel parameter?
And I guess we'll need to see the entire kernel .config as well.

This is a tricky one.  The driver behaves fine for me
here with a 7042 rev.2 on PCIe in my x86-32 box.

Cheers
