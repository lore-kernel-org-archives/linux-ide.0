From: Brian King <brking@us.ibm.com>
Subject: Re: RFC: moving drivers to a new drivers/ata directory
Date: Fri, 15 Oct 2004 10:00:38 -0500
Sender: linux-scsi-owner@vger.kernel.org
Message-ID: <416FE616.8060100@us.ibm.com>
References: <416F5757.8000306@pobox.com> <416F8C39.6010804@torque.net>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <416F8C39.6010804@torque.net>
To: dougg@torque.net
Cc: Jeff Garzik <jgarzik@pobox.com>, SCSI Mailing List <linux-scsi@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

Douglas Gilbert wrote:
> Jeff Garzik wrote:
> 
>>
>> Eventually I would like to move libata, and a few non-libata driver 
>> like 3ware, to drivers/ata.  It would appear in the makefile (and link 
>> order) _after_ drivers/ide and drivers/scsi.
>>
>> Comments/objections?
> 
> 
> A comment: if SAS HBAs ever get installed on motherboards then
> it won't be obvious to the average user which susbsystem they
> should configure (i.e. ATA/SATA or SCSI/SAS). In both cases an
> internal SATA disk could be connected via a SATA cable to a
> plug on the motherboard.

I don't think it matters if the HBA is on the motherboard or not. Since
SAS can support attaching SATA and SATA/ATAPI devices via STP, we could
certainly end up with HBAs that support both SAS and SATA devices. Where
would such a driver exist? If libata moves into the ata directory, it seems
like it would be more difficult for a single LLD to support both SAS and SATA.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

