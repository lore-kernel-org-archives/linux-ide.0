From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: Questions about SATA hotplug in linux 2.6
Date: Thu, 20 Dec 2007 18:43:07 +0800
Message-ID: <B90463BC30D2E446BA423D888DC85E500881B1@sshaexmb1.amd.com>
References: <20071025.011445.80152909.davem@davemloft.net>
 <472052C1.2050302@garzik.org>
 <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com>
 <472153D3.2020102@garzik.org> <4721575B.70706@gmail.com>
 <B90463BC30D2E446BA423D888DC85E500677BF@sshaexmb1.amd.com>
 <47679074.9000400@gmail.com>
 <B90463BC30D2E446BA423D888DC85E50087A77@sshaexmb1.amd.com>
 <476A0970.9090804@gmail.com>
 <B90463BC30D2E446BA423D888DC85E5008813C@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:40467 "EHLO
	outbound10-sin-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754328AbXLTKtw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Dec 2007 05:49:52 -0500
Content-class: urn:content-classes:message
In-Reply-To: <B90463BC30D2E446BA423D888DC85E5008813C@sshaexmb1.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

Hi Tejun:


> > That's strange.  I guess we're forgetting something when forcing the
> > controller into AHCI mode.
> 
> Yes, it's strange. This issue also exists on RedHat RHEL5.1 and
RHEL4.6
> 
> > What happens if you manually issue re-scan
> > by doing "echo - - - > /sys/class/scsi_host/hostN/scan" where hostN
is
> > the SCSI host for the ATA port you moved the drive?
> 
> "echo" helps nothing in this issue, the /dev/scd1 still can not
appear,
> Here is the log message when do "echo", ata2 is the new SATA port
connected
> to SATA HDD after hotplug under native IDE mode:

It seems that this issue has been fixed by our up to date BIOS.
I will give you more information after further confirmation when
necessary.


Thanks
Shane



