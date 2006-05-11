From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ata_piix failure on ich6m
Date: Thu, 11 May 2006 09:11:40 +0100
Message-ID: <20060511081140.GA21594@srcf.ucam.org>
References: <20060510235650.GA20206@srcf.ucam.org> <44629E68.3020302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:55257 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965206AbWEKILs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 04:11:48 -0400
Content-Disposition: inline
In-Reply-To: <44629E68.3020302@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com

On Thu, May 11, 2006 at 11:16:08AM +0900, Tejun Heo wrote:

> I'm not very sure but it might be historical.  ahci got implemented 
> after ata_piix and in the meantime ata_piix must have handled all it 
> could.  Can you verify whether modifying the code to return -ENODEV work 
> for your machine?  If so, that could be the correct solution but I'm a 
> bit worried because it could change probing order or fail to enable 
> devices it used to.  Maybe we need a hack to return -ENODEV iff ahci is 
> there to handle the device.

I can verify that just loading ahci before ata_piix is successful, and 
udev will load both of them since the PCI IDs match. So just having 
ata_piix refuse to bind would solve the problem. Unfortunately I can't 
see a way of doing this only if ahci is present if they're modular...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
