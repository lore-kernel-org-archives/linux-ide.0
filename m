From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Fri, 05 Feb 2010 19:43:50 -0600
Message-ID: <4B6CC956.4080009@gmail.com>
References: <4B6B7FAC.2010901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f185.google.com ([209.85.223.185]:62150 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478Ab0BFBnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Feb 2010 20:43:53 -0500
Received: by iwn15 with SMTP id 15so1685296iwn.19
        for <linux-ide@vger.kernel.org>; Fri, 05 Feb 2010 17:43:52 -0800 (PST)
In-Reply-To: <4B6B7FAC.2010901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Ceklosky <jfceklosky@gmail.com>
Cc: linux-ide@vger.kernel.org

On 02/04/2010 08:17 PM, Joe Ceklosky wrote:
> What was the final outcome on this issue?
>
> What kernel compile options need to be enabled to allow libata to drive
> this device?
>
> Can DMA be enabled on this device?
>
> I have an ss4200 running a custom compiled kernel running Fedora Core 12.

There's no workaround at the moment. The root cause is the BIOS seems to 
be broken and incorrectly disables the PCI device for the PATA 
controller when the SATA controller is set to AHCI mode.

A PCI quirk might be doable to forcibly re-enable the PATA controller so 
that ata_piix can drive it, depending on what exactly the BIOS has done 
to switch it off..
