From: Ajit Prem <Ajit.Prem@motorola.com>
Subject: Re: 31244 & sata_vsc & PPC
Date: Wed, 16 Feb 2005 13:51:24 -0700
Message-ID: <4213B24C.4030302@motorola.com>
References: <4213996C.4060301@motorola.com> <20050216190821.GA19150@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from motgate8.mot.com ([129.188.136.8]:4331 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S261874AbVBPUvh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2005 15:51:37 -0500
In-Reply-To: <20050216190821.GA19150@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>


Thanks for the help.

I printed the int_status register on interrupt
entry into vsc_sata_interrupt and got 0x8300.
According to the 31244 spec, this means (I have
only 1 disk connected to port 1) :

-- SATA Port 1 IDE Interrupt (0x8000)
-- SATA Port 1 PHY Ready Interrupt (0x0200)
-- SATA Port 1 Phy Change State Interrupt (0x0100)

Any patch I can try?

Thanks,

AP


Jeff Garzik wrote:

>On Wed, Feb 16, 2005 at 12:05:16PM -0700, Ajit Prem wrote:
>  
>
>>The email archives indicate that sata_vsc worked
>>on a 31244 in a Dell Powervault once the
>>kernel included the following configuration:
>>
>>Processor type and features -> Local APIC support on uniprocessors
>>Processor type and features -> IO-APIC support on uniprocessors
>>General setup -> Power Management support -> ACPI Support
>>
>>Trying to use sata_vsc on a 31244 in a PPC board
>>results in the same problem as other users had on
>>an X86 board configured without ACPI support - interrupts
>>come in too early to vsc_sata_interrupt, the interrupt
>>doesn't get cleared, and the kernel finally disables the irq.
>>What should one do to get sata_vsc/libata to work on a PPC board?
>>    
>>
>
>Ultimately I wonder if sata_vsc is masking/clearing all interrupt
>conditions during startup.
>
>There might also be a problem with PIO polling.
>
>	Jeff
>
>
>
>  
>

