From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Corrupt data - RAID sata_sil 3114 chip
Date: Fri, 29 Jan 2010 13:37:06 -0600
Message-ID: <4B6338E2.1040507@gmail.com>
References: <4B630914.9010503@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f201.google.com ([209.85.223.201]:37103 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab0A2ThK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2010 14:37:10 -0500
Received: by iwn39 with SMTP id 39so334024iwn.1
        for <linux-ide@vger.kernel.org>; Fri, 29 Jan 2010 11:37:09 -0800 (PST)
In-Reply-To: <4B630914.9010503@fs.ei.tum.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Ulli.Brennenstuhl" <Ulli.Brennenstuhl@fs.ei.tum.de>
Cc: linux-ide@vger.kernel.org

On 01/29/2010 10:13 AM, Ulli.Brennenstuhl wrote:
> The last message of this discussion is more than one year old, but still
> there was no solution to this problem.
>
> I recently encountered the same problem that a raid created with mdadm
> consisting of three SAMSUNG HD154UI sata harddisks had random errors and
> mdadm --examine would randomly report that checksums are wrong/correct.
>
> The sata controller with the SIL 3114 chipset runs on an old Epox 8K3A
> board with a VIA KT133 chipset. I noticed that placing the controller in
> another pci slot would change the results of mdadm --examine.
> While in one slot it was the checksums were randomly changing between
> correct and wrong in another slot it was always displayed as wrong.
>
> After deactivating every single bios option that somehow optimizes the
> pci bus the problem seems to be gone. After some more testing I could
> narrow the problem down to the option "PCI Master 0 WS Write", which
> controls if requests to the pci bus are executed immediately (with zero
> wait states) or if every write request will be delayed by one wait state.
>
> Obviously this reduces the performance. I didn't perform tests but the
> resync speed of the raid dropped from ~ 28mb/s to ~ 17mb/s.
>
> I hope this also solves the problems for other people and it would be
> interesting if any change to the driver would allow to reenable the "PCI
> Master 0 WS Write" option.

I don't imagine there's anything the driver's likely to be able to do to 
avoid it. That sounds like a definite chipset bug. The PCI interface on 
older VIA chipsets was pretty notorious for them.
