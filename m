From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Intel ICH8 errata for ata_piix.c
Date: Mon, 01 Mar 2010 17:51:30 -0600
Message-ID: <4B8C5302.1070203@gmail.com>
References: <ba87a861003011031o5fd78d25n492cddf7a2bdeb2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59173 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab0CAXvd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Mar 2010 18:51:33 -0500
Received: by gyh20 with SMTP id 20so1427658gyh.19
        for <linux-ide@vger.kernel.org>; Mon, 01 Mar 2010 15:51:33 -0800 (PST)
In-Reply-To: <ba87a861003011031o5fd78d25n492cddf7a2bdeb2c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Nilsson <gnuffel@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 03/01/2010 12:31 PM, Daniel Nilsson wrote:
> Hi,
>
> I have a laptop running Linux 2.6.33 with the following SATA chip:
> "Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) IDE Controller (rev
> 03)", and I am experiencing random loss of data and a bouncing SATA
> link.
>
> The problem seems to be described by other people in
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/297058 . After
> investigating for a while, I found the errata
> http://www.intel.com/Assets/PDF/specupdate/313057.pdf , see especially
> errata #19 which handles MSI. Is this something that is handled in the
> driver?
>
> I have disabled MSI interrupts by using "pci=nomsi" on the kernel boot
> line for now, and will see if it fixes anything - hopefully it does.

If the controller's not in AHCI mode (and it's not, if ata_piix is in 
use) then MSI is never used, so that won't do anything.

It doesn't look like that errata should apply to AHCI on Linux either, 
since the HBA reset is only used on initialization or resume, when the 
interrupt wouldn't even be enabled.

I think your problem is something else. Unfortunately that Launchpad bug 
report seems to have the usual problem of multiple, most likely 
unrelated problems (including totally different hardware/controllers) 
that have been put into the same report. The initial report seems to be 
saying they're having problems with a SATA drive but the dmesg output 
indicates that a PATA drive is timing out. I think we need some more 
coherent info.

Can you post your full dmesg output from bootup that illustrates the 
problem?
