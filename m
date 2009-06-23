From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Sata link_power_management_policy questions
Date: Mon, 22 Jun 2009 23:12:27 -0600
Message-ID: <4A40643B.7090805@gmail.com>
References: <4A3FD261.7060903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:40145 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbZFWFLv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 01:11:51 -0400
In-Reply-To: <4A3FD261.7060903@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Voegeli Olivera <patrick.voegeli@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, ide <linux-ide@vger.kernel.org>

On 06/22/2009 12:50 PM, Patrick Voegeli Olivera wrote:
> Hi there,
>
> I have a laptop with Sata set to native mode and ahci enabled in the
> bios. In ubuntu, I can see
> /sys/class/scsi_host/host0/link_power_management_policy for host0, host1
> and host2, but if I read any of those using cat they always will return
> max_performance, even if I echo min_power or medium_power and it gives
> no errors:
>
> root@patrick-laptop:~# cat
> /sys/class/scsi_host/host0/link_power_management_policy
> max_performance
> root@patrick-laptop:~# echo min_power >
> /sys/class/scsi_host/host0/link_power_management_policy
> root@patrick-laptop:~# cat
> /sys/class/scsi_host/host0/link_power_management_policy
> max_performance
>
> I've tried to look around for a solution, but I haven't found anything
> useful. Is this a feature that depends on the HDD? Does the hard drive
> need to be sata 2/300 or should it also work with sata 1/150? Is it just
> that my laptop doesn't support it?
>
> Since my HDD is sata150, I've tried with another HDD and I had the same
> problem. I don't know if it was sata2 compliant, though.
>
> My laptop has intel chipsets. Namely, the 965gm (with x3100 graphics)
> northbridge and I think it has a ich8 southbridge.
>
> Any ideas on what to try?

Please post your dmesg output and hdparm -I output for the drive. Also 
cc-ing linux-ide.
