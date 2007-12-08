From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.24-rc4-git5: Reported regressions from 2.6.23
Date: Sat, 08 Dec 2007 12:24:16 -0600
Message-ID: <475AE150.9050306@shaw.ca>
References: <fa.qQhD8aJpiTOFaZqjRYwoaG7YT1c@ifi.uio.no>
 <fa.yaP86AixGhz5Q7eXSu04pIQp6ho@ifi.uio.no>
 <fa.c3k8VKWAx4HIo9zXWbL5Ek0oSBw@ifi.uio.no>
 <fa.C8ACnOhs8bXB++vmugf5F34JcJg@ifi.uio.no>
 <fa.5o6E6S0UWnARbQPxLe30TvLQIiY@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <fa.5o6E6S0UWnARbQPxLe30TvLQIiY@ifi.uio.no>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Matthew Garrett wrote:
> On Sat, Dec 08, 2007 at 02:20:01AM -0800, Andrew Morton wrote:
>> On Sat, 8 Dec 2007 11:12:57 +0100 Andreas Mohr <andi@lisas.de> wrote:
>>> ACPI Exception (exoparg2-0442): AE_AML_PACKAGE_LIMIT, Index (0FFFFFFFF) is beyond end of object [20070126]
>>> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.GTF_] (Node c180b990), AE_AML_PACKAGE_LIMIT
>>> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN0.DRV1._GTF] (Node c180b888), AE_AML_PACKAGE_LIMIT
>>> ata1.01: _GTF evaluation failed (AE 0x300d)
> 
> 037f6bb79f753c014bc84bca0de9bf98bb5ab169 ought to have fixed this?
> 

I should think it should have.

I think we're too aggressive about disabling the libata ACPI support, 
even. One of my laptop's _GTF commands on resume is a DEVICE 
CONFIGURATION FREEZE LOCK command, which gets rejected by the drive 
(maybe it worked on the original Hitachi disk, but I've upgraded it to a 
  newer Samsung). I'd say if the drive returns command aborted on one of 
these, we should just ignore that command and continue to the next one 
without trying to retry or disabling the ACPI support entirely.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

