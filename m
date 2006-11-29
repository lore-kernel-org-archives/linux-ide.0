From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: do not powerdown during initialization
Date: Wed, 29 Nov 2006 12:52:00 +0900
Message-ID: <456D03E0.1080805@gmail.com>
References: <20061120064236.GM2184@htj.dyndns.org> <456BFE30.2010602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:39904 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1758056AbWK2DwH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 22:52:07 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1016398nze
        for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 19:52:07 -0800 (PST)
In-Reply-To: <456BFE30.2010602@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, flyboy@gmail.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> ahci_init_controller() calls ahci_deinit_port() to make sure the
>> controller is stopped before initializing the controller.  In turn,
>> ahci_deinit_port() invokes ahci_power_down() to power down the port.
>> If the controller supports slumber mode, the link is put into it.
> 
> I would rather just pass a 'dont suspend port' flag to 
> ahci_deinit_port().  That leaves ahci_port_stop() behavior unchanged.

That behavior change is intended.  ahci_port_stop() must not call 
ahci_power_down(); otherwise, it will cause strange behaviors on some 
devices on driver unloading.

The baseline is that power up/down shouldn't be done as part of 
controller init/deinit.  Power up/down involves link power management 
operation which make some devices choke.  They should only be done when 
actual power management is required.  This is okay even for devices 
which choke on link pm because system-wide PM powers those devices down 
clearing lockup.  I dunno what should be done with partial power 
management tho.

-- 
tejun
