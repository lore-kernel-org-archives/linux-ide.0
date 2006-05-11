From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: ata_piix failure on ich6m
Date: Thu, 11 May 2006 08:45:41 -0700
Message-ID: <20060511084541.90d4e071.rdunlap@xenotime.net>
References: <20060510235650.GA20206@srcf.ucam.org>
	<44629E68.3020302@gmail.com>
	<20060511081140.GA21594@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:19377 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030283AbWEKPnT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 May 2006 11:43:19 -0400
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:43:13 -0700
In-Reply-To: <20060511081140.GA21594@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com

On Thu, 11 May 2006 09:11:40 +0100 Matthew Garrett wrote:

> On Thu, May 11, 2006 at 11:16:08AM +0900, Tejun Heo wrote:
> 
> > I'm not very sure but it might be historical.  ahci got implemented 
> > after ata_piix and in the meantime ata_piix must have handled all it 
> > could.  Can you verify whether modifying the code to return -ENODEV work 
> > for your machine?  If so, that could be the correct solution but I'm a 
> > bit worried because it could change probing order or fail to enable 
> > devices it used to.  Maybe we need a hack to return -ENODEV iff ahci is 
> > there to handle the device.
> 
> I can verify that just loading ahci before ata_piix is successful, and 
> udev will load both of them since the PCI IDs match. So just having 
> ata_piix refuse to bind would solve the problem. Unfortunately I can't 
> see a way of doing this only if ahci is present if they're modular...

Does the 'combined_mode' kernel parameter help any?

---
~Randy
