From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Sat, 4 Apr 2009 11:45:59 -0700
Message-ID: <20090404114559.ce20eb9c.akpm@linux-foundation.org>
References: <bug-13001-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46092 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268AbZDDStn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Apr 2009 14:49:43 -0400
In-Reply-To: <bug-13001-10286@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, optimusgd@gmail.com, x86@kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Fri, 3 Apr 2009 09:30:19 GMT bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13001
> 
>            Summary: PCI-DMA: Out of IOMMU space
>            Product: Platform Specific/Hardware
>            Version: 2.5
>     Kernel Version: 2.6.29-gentoo
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: x86-64
>         AssignedTo: platform_x86_64@kernel-bugs.osdl.org
>         ReportedBy: optimusgd@gmail.com
>         Regression: Yes
> 
> 
> Created an attachment (id=20789)
>  --> (http://bugzilla.kernel.org/attachment.cgi?id=20789)
> hwreport generated info
> 
> After some IO activity the "PCI-DMA: Out of IOMMU space" message appear.
> 2.6.28-gentoo-r4 work ok, so it is regression.

It is indeed a regression.

> Dmesg fragments:
> 
> 
> Apr  3 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: Out of IOMMU space for
> 4096 bytes
> Apr  3 13:38:46 rngmhpamd sata_nv 0000:00:05.0: PCI-DMA: Out of IOMMU space for
> 4096 bytes
> Apr  3 13:38:46 rngmhpamd ata1: EH in SWNCQ mode,QC:qc_active 0x1 sactive 0x1
> Apr  3 13:38:46 rngmhpamd ata1: SWNCQ:qc_active 0x0 defer_bits 0x0
> last_issue_tag 0xfafbfcfd
> Apr  3 13:38:46 rngmhpamd dhfis 0x0 dmafis 0x0 sdbfis 0x0
> Apr  3 13:38:46 rngmhpamd ata1: ATA_REG 0x50 ERR_REG 0x0
> Apr  3 13:38:46 rngmhpamd ata1: tag : dhfis dmafis sdbfis sacitve
> Apr  3 13:38:46 rngmhpamd ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action
> 0x6
> Apr  3 13:38:46 rngmhpamd ata1.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag
> 0 ncq 4096 in
> Apr  3 13:38:46 rngmhpamd res 50/00:00:00:00:00/00:45:00:00:00/a0 Emask 0x40
> (internal error)
> Apr  3 13:38:46 rngmhpamd ata1.00: status: { DRDY }
> Apr  3 13:38:46 rngmhpamd ata1: hard resetting link

Are these scary-looking messages also present in 2.6.28?

If so, perhaps the ata code is leaking DMA memory on the error-handling path?

> Apr  3 13:38:47 rngmhpamd ata1: SATA link up 3.0 Gbps (SStatus 123 SControl
> 300)
> Apr  3 13:38:47 rngmhpamd ata1.00: configured for UDMA/100
> Apr  3 13:38:47 rngmhpamd ata1: EH complete
> Apr  3 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] 488397168 512-byte hardware
> sectors: (250 GB/232 GiB)
> Apr  3 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write Protect is off
> Apr  3 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> Apr  3 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> Apr  3 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] 488397168 512-byte hardware
> sectors: (250 GB/232 GiB)
> Apr  3 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write Protect is off
> Apr  3 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> Apr  3 13:38:47 rngmhpamd sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> 
> And
> 
> Mar 31 20:56:18 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 4608 bytes
> Mar 31 20:56:18 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 69632 bytes
> Mar 31 20:56:48 rngmhpamd usb 1-4: reset high speed USB device using ehci_hcd
> and address 8
> Mar 31 20:56:48 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 11776 bytes
> Mar 31 20:56:48 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 69632 bytes
> Mar 31 20:57:19 rngmhpamd usb 1-4: reset high speed USB device using ehci_hcd
> and address 8
> Mar 31 20:57:19 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 11776 bytes
> Mar 31 20:57:19 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 69632 bytes
> Mar 31 20:57:50 rngmhpamd usb 1-4: reset high speed USB device using ehci_hcd
> and address 8
> Mar 31 20:57:50 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 11776 bytes
> Mar 31 20:57:50 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 69632 bytes
> Mar 31 20:58:21 rngmhpamd usb 1-4: reset high speed USB device using ehci_hcd
> and address 8
> Mar 31 20:58:21 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 11776 bytes
> Mar 31 20:58:21 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 69632 bytes
> Mar 31 20:58:52 rngmhpamd usb 1-4: reset high speed USB device using ehci_hcd
> and address 8
> Mar 31 20:58:52 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 11776 bytes
> Mar 31 20:58:52 rngmhpamd ehci_hcd 0000:00:02.1: PCI-DMA: Out of IOMMU space
> for 69632 bytes
> Mar 31 20:59:01 rngmhpamd sd 8:0:0:0: [sdc] Unhandled error code
> Mar 31 20:59:01 rngmhpamd sd 8:0:0:0: [sdc] Result: hostbyte=0x07
> driverbyte=0x00
> Mar 31 20:59:01 rngmhpamd end_request: I/O error, dev sdc, sector 1137
> Mar 31 20:59:01 rngmhpamd __ratelimit: 246 callbacks suppressed

Do we have any debugging option for dumping the current PCI DMA
allocations, find out where it has all gone?

