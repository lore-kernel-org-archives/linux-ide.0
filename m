From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] AHCI PCI MSI support, update 1
Date: Wed, 1 Jun 2005 07:52:52 +0200
Message-ID: <20050601055251.GC1441@suse.de>
References: <429C8978.4060601@pobox.com> <20050601054422.GA1441@suse.de> <429D4BB3.6080903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:8661 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261249AbVFAFvv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jun 2005 01:51:51 -0400
Content-Disposition: inline
In-Reply-To: <429D4BB3.6080903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Wed, Jun 01 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >System boots and works fine (typing this message here), MSI is enabled.
> >I double checked with an added printk :-)
> 
> Any chance you could post a full /proc/interrupts output for this box?

Sure:

           CPU0       CPU1
  0:     349415     330112    IO-APIC-edge  timer
  4:         10          0    IO-APIC-edge  serial
  8:          0          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:          2          0    IO-APIC-edge  ide0
169:          0          0   IO-APIC-level  uhci_hcd:usb4
177:       2565          0   IO-APIC-level  eth0
185:       6932       7195   IO-APIC-level  uhci_hcd:usb3
201:       8991       5154         PCI-MSI  libata
209:          3          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
217:          0          0   IO-APIC-level  uhci_hcd:usb5
225:        345         51   IO-APIC-level  HDA Intel
NMI:        150         83
LOC:     671016     671636
ERR:          1
MIS:          0


-- 
Jens Axboe

