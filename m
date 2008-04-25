From: "Zhao, Richard" <Richard.Zhao@amd.com>
Subject: RE: Add BIOS/OS handoff feature to AHCI
Date: Fri, 25 Apr 2008 09:58:33 +0800
Message-ID: <206C6845C72CAE439DC3D9D413C571A4DC3F2B@ssuzexmb3.amd.com>
References: <206C6845C72CAE439DC3D9D413C571A4CE9863@ssuzexmb3.amd.com> <48084DF1.8000902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:64651 "EHLO
	WA4EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755308AbYDYB6w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Apr 2008 21:58:52 -0400
Content-Class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Zhao, Richard" <Richard.Zhao@amd.com>, Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Adding linux-ide ......

Richard
-----Original Message-----
From: Zhao, Richard 
Sent: Friday, April 18, 2008 3:37 PM
To: 'Jeff Garzik'
Subject: RE: Add BIOS/OS handoff feature to AHCI

You may find it in AHCI spec revision 1.2, section 10.6 .
Can you find it?

Thanks
Richard

-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org] 
Sent: Friday, April 18, 2008 3:30 PM
To: Zhao, Richard
Subject: Re: Add BIOS/OS handoff feature to AHCI

Zhao, Richard wrote:
> Hi Jeff,
> 
>  
> 
> AMD's AHCI controller will have the BIOS/OS handoff feature. I'm 
> considering to add it to ahci driver.
> 
>  
> 
> EHCI also have the feature, and EHCI driver add it in 
> drivers/usb/host/pci-quirks.c, it uses pci fixup final.
> 
>  
> 
> There're two places to add the AHCI handoff support:
> 
>    1. pci quirk.    drivers/pci/quirks.c
> 
> All ahci drivers will need to do nothing. But BOHC register is in
memory 
> mapped space, we must map it temporally. EHCI pci quirk has temp
mapping 
> too.
> 
>    2. ahci driver
> 
> Every ahci drivers will have to implement it in probe function. I'm
not 
> very sure we can put it here. Perhaps PCI general driver has done too 
> much modification of ahci controller.
> 
>  
> 
> What's your opinion?

I am unfamiliar with the specific needs of BIOS hand-off in this case...

  where may I find that information?

	Jeff





