From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: LibPATA/ATA Errors Continue - Will there be a fix for this?
Date: Tue, 20 Jun 2006 18:22:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606201821460.17790@p34.internal.lan>
References: <Pine.LNX.4.64.0606200808250.5851@p34.internal.lan>
 <4497F1C7.2070007@rtr.ca> <449804EA.8030908@dgreaves.com> <44981800.2000807@dgreaves.com>
 <Pine.LNX.4.64.0606201146430.2601@p34.internal.lan> <449874B6.7020606@dgreaves.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([66.45.37.187]:28631 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751289AbWFTWW4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 18:22:56 -0400
In-Reply-To: <449874B6.7020606@dgreaves.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Tue, 20 Jun 2006, David Greaves wrote:

> Justin Piszcz wrote:
>> Dave, what is the make/model of the drives you get errors with by the
>> way?
>>
>> On Tue, 20 Jun 2006, David Greaves wrote:
>>> [Some email archaeology later]
>>>
>>> Back in March I was running 2.6.16 (with the opcode patch) and I sent an
>>> email with the following info:
>>>
>>> dmesg:
>>> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/04 to SCSI
>>> SK/ASC/ASCQ 0xb/00/00
>>> ata1: status=0x51 { DriveReady SeekComplete Error }
>>> ata1: error=0x04 { DriveStatusError }
> Model Family: Maxtor DiamondMax 10 family
> Device Model: Maxtor 6B200M0
> Serial Number: B4038RRH
> Firmware Version: BANC1980
>
> this is sata_sil
>
> Another machine has :
> Device Model: SAMSUNG SP2504C
> Serial Number: S09QJ10Y720963
> Firmware Version: VT100-33
> User Capacity: 250,059,350,016 bytes
>
> running through sata_via
>
> that's running 2.6.16.18 and just gives:
> ata1: PIO error
> ata1: status=0x50 { DriveReady SeekComplete }
>
>
> David
>
> -- 
>

I also use sata_sil, perhaps it is a controller-specific problem? I use a
WD WD4000KD-00N.

I also ahve that same exact samsung drive but I have it on an Intel ICH5
controller and I do not seem to get that error.

# grep PIO\ error *
#

