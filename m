From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: 3.2.14: Marvell 88SE9123 PCIe SATA 6.0 Gb/s controller not working
Date: Sun, 22 Apr 2012 00:22:43 -0600
Message-ID: <4F93A3B3.7070400@gmail.com>
References: <4F888C09.5000408@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35632 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab2DVGWp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2012 02:22:45 -0400
Received: by iadi9 with SMTP id i9so586603iad.19
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2012 23:22:45 -0700 (PDT)
In-Reply-To: <4F888C09.5000408@fold.natur.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 04/13/2012 02:26 PM, Martin Mokrejs wrote:
> Hi,
>    I am looking for an Express Card to plug into my laptop to provide additional
> eSATA port. I just tried two cards, incidentally having same chipset. One was
> from Axago ECS-6S (1x eSATA port) and the other was Kouwell EK-113 (2x eSATA).
> Both cards have just one/two eSATA ports but kernel tries to assign many ata ports
> (see the logs). And this was probably fatal issue:
>
> DRHD: handling fault status reg 2
> DMAR:[DMA Read] Request device [11:00.1] fault addr fff00000
> DMAR:[fault reason 02] Present bit in context entry is clear

This has been reported before with these Marvell controllers. It seems 
that the chip issues DMA requests with the PCIe transactions pointing to 
the wrong PCI device/function, and this chokes in combination with DMAR 
(aka Intel IOMMU or VT-d) being enabled which validates that DMA 
transfers come from expected devices. Disabling the Intel IOMMU (using 
intel_iommu=off on the kernel command line) may work around the problem. 
There's likely something that can be done at the kernel level to avoid 
this problem, too, but I don't think anything has been done so far.

I'm not sure what the difference between 88SE9123 and 88SE9128 or 
whether they both may have this bug.

>
>    I have attached three files with lspci and dmesg output. Is this chip supported?
> I just tried the cards in a shop and returned immediately, so I cannot re-test
> them again unless I buy one of them.
>
>    Should I go rather for one of the Sil3132 eSATA cards from DeLock?
>
>
> Here are my notes of what is available (in theory):
>
> DeLock 66224: Sil3132, 1x eSATA, SATA I only
> DeLock 61957 and 61891: Marvell 88SE9128? 1xeSATA, SATA III
>                          Maybe my typo? Is is same chipset like here reported problematic
>                          88SE9123?
> Looks these also exist:
> Axago ECS-SL: JMB360, 1x eSATA, SATA II (JMicron?, I had bad luck with JM20337 and JMS539, no, thanks).
> Axago ECS-X1 (probably same is DeLock 61478): Sil3531, 1x eSATA, SATA II
>
> DeLock 61386: Sil3132, 2x eSATA, SATA II, no RAID
> DeLock 66221: Sil3132, 2x eSATA, SATA II, with RAID
>
>    I haven't anywhewre the Sil chip based cards yet to try. Is it worth the effort?
> Which would you suggest?
> Thank you very much,
> Martin

