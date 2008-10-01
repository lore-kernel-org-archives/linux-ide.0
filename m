From: John Clark <clarkjc@runbox.com>
Subject: Re: Interoperability problem with Quantum CD72SH SATA tape drive
 and libata
Date: Wed, 01 Oct 2008 19:13:25 -0400
Message-ID: <48E40415.7050607@runbox.com>
References: <48DE96AF.6090301@runbox.com> <48E2ECA8.8060808@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aibo.runbox.com ([193.71.199.94]:40235 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbYJAXNx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Oct 2008 19:13:53 -0400
In-Reply-To: <48E2ECA8.8060808@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> John Clark wrote:
>   
>> Hello,
>>
>> I've discovered an issue with the Quantum CD72SH SATA tape drive.  I set
>> it to variable block size, try to write a 5317 byte block with an ATAPI
>> issued WRITE(6), and it hangs.  The drive is connected to an Intel ICH9R
>> in AHCI mode.
>>
>> My debugging efforts have determined that it's a problem with the
>> drive's firmware.  It does not like ATAPI CDBs with odd (& 1) transfer
>> lengths with PIO.  If I let it use DMA, even if it's not a multiple of
>> 16 bytes, then it seems to work:
>>
>> --- libata-core.c.orig    2008-09-27 16:12:46.000000000 -0400
>> +++ libata-core.c    2008-09-27 16:11:29.000000000 -0400
>> @@ -4669,8 +4669,8 @@
>>     /* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
>>      * few ATAPI devices choke on such DMA requests.
>>      */
>> -    if (unlikely(qc->nbytes & 15))
>> -        return 1;
>> +    // if (unlikely(qc->nbytes & 15))
>> +    //     return 1;
>>
>>     if (ap->ops->check_atapi_dma)
>>         return ap->ops->check_atapi_dma(qc);
>>
>>
>>
>> This is an acceptable solution for my limited use, but I'd like to see
>> it work out of the box.  It seems frightening that there are ATAPI
>> devices out there that choke on PIO requests.  What would you like to do?
>>     
>
> We can create a HORKAGE for it.  Can you please post the result of
> "hdparm -I" of the device?
>
>   
Tejun,

Here it is:

/dev/nst0:

ATAPI Sequential-access device, with removable media
    Model Number:       QUANTUM DAT    DAT72-000               
    Serial Number:      JR001H1            
    Firmware Revision:  VC090000
Standards:
    Used: ATA/ATAPI-7 T13 1532D revision 4a
    Supported: 7 6 5 4
Configuration:
    DRQ response: 50us.
    Packet size: 12 bytes
Capabilities:
    LBA, IORDY(can be disabled)
    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
         Cycle time: min=120ns recommended=120ns
    PIO: pio0 pio1 pio2 pio3 pio4
         Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
    Enabled    Supported:
       *    Power Management feature set
       *    PACKET command feature set
       *    DEVICE_RESET command
       *    NOP cmd
       *    SATA-I signaling speed (1.5Gb/s)
Integrity word not set (found 0x0000, expected 0x6da5)

Thank you.

- John
