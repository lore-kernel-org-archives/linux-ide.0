From: Ajit Prem <Ajit.Prem@motorola.com>
Subject: Re: 31244 & sata_vsc & PPC
Date: Wed, 16 Feb 2005 14:27:59 -0700
Message-ID: <4213BADF.8000307@motorola.com>
References: <4213996C.4060301@motorola.com> <20050216190821.GA19150@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from motgate2.mot.com ([144.189.100.101]:41166 "EHLO
	motgate2.mot.com") by vger.kernel.org with ESMTP id S262087AbVBPV2V
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 16:28:21 -0500
In-Reply-To: <20050216190821.GA19150@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>


As a follow-up to my previous email where
I indicated that int_status on entry into
vsc_sata_interrupt indicates 0x8300, I
put in a crude fix in the vsc_sata_interrupt
handler to read the taskfile status register,
and to clear the appropriate bits in the
SATA SError register, and now things work
just fine.

Thank you very much for your help.

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

