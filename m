From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 31244 & sata_vsc & PPC
Date: Wed, 16 Feb 2005 14:08:21 -0500
Message-ID: <20050216190821.GA19150@havoc.gtf.org>
References: <4213996C.4060301@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:19103 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261526AbVBPTIa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 14:08:30 -0500
Content-Disposition: inline
In-Reply-To: <4213996C.4060301@motorola.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ajit Prem <Ajit.Prem@motorola.com>
Cc: linux-ide@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>

On Wed, Feb 16, 2005 at 12:05:16PM -0700, Ajit Prem wrote:
> The email archives indicate that sata_vsc worked
> on a 31244 in a Dell Powervault once the
> kernel included the following configuration:
> 
> Processor type and features -> Local APIC support on uniprocessors
> Processor type and features -> IO-APIC support on uniprocessors
> General setup -> Power Management support -> ACPI Support
> 
> Trying to use sata_vsc on a 31244 in a PPC board
> results in the same problem as other users had on
> an X86 board configured without ACPI support - interrupts
> come in too early to vsc_sata_interrupt, the interrupt
> doesn't get cleared, and the kernel finally disables the irq.
> What should one do to get sata_vsc/libata to work on a PPC board?

Ultimately I wonder if sata_vsc is masking/clearing all interrupt
conditions during startup.

There might also be a problem with PIO polling.

	Jeff



