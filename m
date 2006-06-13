From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 18:00:19 +0900
Message-ID: <448E7EA3.8070707@gmail.com>
References: <11501274293403-git-send-email-htejun@gmail.com> <1150186634.7132.34.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:20784 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750801AbWFMJAZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 05:00:25 -0400
Received: by py-out-1112.google.com with SMTP id x31so57193pye
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 02:00:25 -0700 (PDT)
In-Reply-To: <1150186634.7132.34.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Is it possible to add a callback in ata_pci_device_suspend() to do
> controller-level operation before calling pci_save_state()......?
> One possible solution is to put this callback into a structure together
> with host_set.
> Otherwise user-defined ahci_pci_device_suspend() will duplicate most
> code of ata_pci_device_suspend().

If a LLD wants to do controller specific things, define its own 
device_suspend/resume() routines and call ata_pci_device_*() from those 
functions after doing controller-specific stuff.  Please read how 
sil_pci_device_resume() and sil24_pci_device_resume() are defined later 
in this patchset.

If ata_pci_device_suspend/resume() do things incorrect for a 
controller(), export ata_host_set_suspend/resume() and call those from 
LLD's suspend/resume() routines.

-- 
tejun
