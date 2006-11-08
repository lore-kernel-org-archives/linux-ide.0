From: "Andrei Tanas" <andrei@tanas.ca>
Subject: RE: pata_amd.c version 0.2.4
Date: Wed, 8 Nov 2006 12:16:48 -0500
Message-ID: <005801c70359$b5f01010$21d03030$@ca>
References: <006501c70286$6e562100$4b026300$@ca> <20061107161322.GA25397@devserv.devel.redhat.com> <008c01c702a5$e4482060$acd86120$@ca> <20061107221507.GA21232@devserv.devel.redhat.com> <00ea01c70343$225582b0$67008810$@ca> <20061108160725.GA24966@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 206-248-136-31.dsl.teksavvy.com ([206.248.136.31]:52457 "EHLO
	mail.unchanged.net") by vger.kernel.org with ESMTP id S1753271AbWKHRRF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Nov 2006 12:17:05 -0500
In-Reply-To: <20061108160725.GA24966@devserv.devel.redhat.com>
Content-Language: en-ca
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Alan Cox' <alan@redhat.com>, 'Jeff Garzik' <jgarzik@pobox.com>, 'Tejun Heo' <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun, Jeff,
In an attempt to enable suspend-to-ram (and correct resume) for NVidia MCP51
PATA device, I added
.suspend		= ata_pci_device_suspend,
.resume		= ata_pci_device_resume,
To amd_pci_driver struct. With this, first attempt to suspend results in an
error (-16 "device is still active"), and second attempt leads to oops. Do
you want to see console output and lspci for this?

Leaving .suspend = NULL and adding only
.resume		= ata_pci_device_resume,
seems to reset the device properly and work fine.
Before this was enabled, the box would suspend/resume fine than hang
silently about 30 seconds after resume.


-----Original Message-----
From: Alan Cox [mailto:alan@redhat.com] 
Sent: November 8, 2006 11:07 AM
To: Andrei Tanas
Cc: 'Alan Cox'
Subject: Re: pata_amd.c version 0.2.4

On Wed, Nov 08, 2006 at 09:35:20AM -0500, Andrei Tanas wrote:
> Adding .resume helped - the controller (MCP51) resets properly. Trying to
> add .suspend resulted in an error (-16, "device is still active"), with
> subsequent oops on the next suspend attempt. Let me know if you want
console
> output and lspci for this.

I don't really have time to look at it this year, Tejun and Jeff may well
be interested - is that the device you were suspending too ?

