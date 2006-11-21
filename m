From: Tejun Heo <htejun@gmail.com>
Subject: Re: pata_amd.c version 0.2.4
Date: Tue, 21 Nov 2006 17:12:36 +0900
Message-ID: <4562B4F4.20004@gmail.com>
References: <006501c70286$6e562100$4b026300$@ca> <20061107161322.GA25397@devserv.devel.redhat.com> <008c01c702a5$e4482060$acd86120$@ca> <20061107221507.GA21232@devserv.devel.redhat.com> <00ea01c70343$225582b0$67008810$@ca> <20061108160725.GA24966@devserv.devel.redhat.com> <005801c70359$b5f01010$21d03030$@ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:48689 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S966362AbWKUIMp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 03:12:45 -0500
Received: by nf-out-0910.google.com with SMTP id o25so104804nfa
        for <linux-ide@vger.kernel.org>; Tue, 21 Nov 2006 00:12:44 -0800 (PST)
In-Reply-To: <005801c70359$b5f01010$21d03030$@ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Tanas <andrei@tanas.ca>
Cc: 'Alan Cox' <alan@redhat.com>, 'Jeff Garzik' <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Andrei Tanas wrote:
> Tejun, Jeff,
> In an attempt to enable suspend-to-ram (and correct resume) for NVidia MCP51
> PATA device, I added
> .suspend		= ata_pci_device_suspend,
> .resume		= ata_pci_device_resume,
> To amd_pci_driver struct. With this, first attempt to suspend results in an
> error (-16 "device is still active"), and second attempt leads to oops. Do
> you want to see console output and lspci for this?
> 
> Leaving .suspend = NULL and adding only
> .resume		= ata_pci_device_resume,
> seems to reset the device properly and work fine.
> Before this was enabled, the box would suspend/resume fine than hang
> silently about 30 seconds after resume.

You also need to set scsi_host_template->suspend/resume callbacks. 
Using default ata_scsi_device_suspend() and ata_scsi_device_resume() 
should be sufficient.

-- 
tejun
