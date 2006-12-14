From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] ata_piix: use piix_host_stop() in ich_pata_ops
Date: Thu, 14 Dec 2006 23:42:47 +0000
Message-ID: <b0943d9e0612141542s558d3768h57a7bb9b5440a246@mail.gmail.com>
References: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
	 <20061211132625.GA18947@htj.dyndns.org>
	 <b0943d9e0612130241k3363a2c9kd464d33122e6147f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:37714 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbWLNXms (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Dec 2006 18:42:48 -0500
Received: by nz-out-0506.google.com with SMTP id s1so342939nze
        for <linux-ide@vger.kernel.org>; Thu, 14 Dec 2006 15:42:47 -0800 (PST)
In-Reply-To: <b0943d9e0612130241k3363a2c9kd464d33122e6147f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 13/12/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 11/12/06, Tejun Heo <htejun@gmail.com> wrote:
> > piix_init_one() allocates host private data which should be freed by
> > piix_host_stop().  ich_pata_ops wasn't converted to piix_host_stop()
> > while merging, leaking 4 bytes on driver detach.  Fix it.
>
> I tried your patch last night but the leak is still reported. I need
> to investigate further and put some printk's in the piix_host_stop
> function to check whether the freeing really takes place.

The piix_host_stop() isn't actually called on my machine, so this is
not the cause of the leak.

What causes the leak seem to be the error returned by
ata_pci_init_one() called from piix_init_one(). These are the related
kernel messages:

ata_piix 0000:00:1f.1: version 2.00ac7
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 18
PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.1
ata_piix: probe of 0000:00:1f.1 failed with error -16

I think the call to ata_pci_init_one() should be followed by some
clean-up in case it fails. There is also another return without
clean-up in piix_init_one() after the call to piix_disable_ahci(). I
don't have time to try this now.

-- 
Catalin
