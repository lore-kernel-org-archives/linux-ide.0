From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix failure on ich6m
Date: Thu, 11 May 2006 11:16:08 +0900
Message-ID: <44629E68.3020302@gmail.com>
References: <20060510235650.GA20206@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:54976 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751524AbWEKCQO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 22:16:14 -0400
Received: by py-out-1112.google.com with SMTP id f28so90489pyf
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2006 19:16:13 -0700 (PDT)
In-Reply-To: <20060510235650.GA20206@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com

Matthew Garrett wrote:
> Hi,
> 
> We've got an ich6m system (a Toshiba Portege S100). ata_piix attempts to 
> drive the chipset, but fails - however, it doesn't bail out. As a result 
> it remains bound to the device and ahci isn't loaded.
> 
> I've attached the lspci output for the chipset. A few things to note 
> are:
> 
> 1) The AHCI BAR is set
> 2) The SCC register identifies it as an AHCI controller
> 3) Bits 2 and 0 of the PCS are set, which the spec claims indicates that 
> the port is to be controlled as an ahci device.
> 
> So, my question is effectively: why does ata_piix attempt to disable 
> ahci rather than simply letting the ahci driver bind? Points (1) and (2) 
> seem to be checked by the code, but I'm guessing that in the case of (3) 
> it should just return ENODEV and let ahci be run instead. If so, should 
> I code up a patch?
> 

I'm not very sure but it might be historical.  ahci got implemented 
after ata_piix and in the meantime ata_piix must have handled all it 
could.  Can you verify whether modifying the code to return -ENODEV work 
for your machine?  If so, that could be the correct solution but I'm a 
bit worried because it could change probing order or fail to enable 
devices it used to.  Maybe we need a hack to return -ENODEV iff ahci is 
there to handle the device.

-- 
tejun
