From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata-acpi: don't call _GTF for disabled drive
Date: Thu, 17 Apr 2008 15:57:00 -0400
Message-ID: <4807AB8C.70303@pobox.com>
References: <1206435045.23794.13.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1206435045.23794.13.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-ide@vger.kernel.org

Shaohua Li wrote:
> I got below log after a S3 resume in a ASUS A6VC laptop. The system has
> only one IDE drive. It appears there is no reason calling _GTF for
> disabled drive.
> 
> ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV0._GTF] (Node df822bd0), AE_AML_OPERAND_VALUE
> ata2.00: _GTF evaluation failed (AE 0x3006)
> ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV1._GTF] (Node df822b94), AE_AML_OPERAND_VALUE
> ata2.01: _GTF evaluation failed (AE 0x3006)
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

well, no comments at all from anyone, even after a solicitation.  sigh...

applied


