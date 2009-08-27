From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: MD/RAID: what's wrong with sector 1953519935?
Date: Wed, 26 Aug 2009 20:33:40 -0600
Message-ID: <4A95F084.6020509@gmail.com>
References: <004e01ca25e4$c11a54e0$434efea0$@ca>    <9cfb6af689a7010df166fdebb1ef516b.squirrel@neil.brown.name>    <4A948A82.4080901@redhat.com> <b585ed9f13649050bbc984869d081315.squirrel@neil.brown.name> <4A94905F.7050705@redhat.com> <005101ca25f4$09006830$1b013890$@ca> <4A94A0E6.4020401@redhat.com> <005401ca25ff$9ac91cc0$d05b5640$@ca> <4A950FA6.4020408@redhat.com> <92cb16daad8278b0aa98125b9e1d057a@localhost> <4A95573A.6090404@redhat.com> <1571f45804875514762f60c0097171e6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f205.google.com ([209.85.217.205]:59903 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882AbZH0Cdo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2009 22:33:44 -0400
In-Reply-To: <1571f45804875514762f60c0097171e6@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Tanas <andrei@tanas.ca>
Cc: Ric Wheeler <rwheeler@redhat.com>, NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 08/26/2009 12:12 PM, Andrei Tanas wrote:
> The relevant portions of the log file are below (two independent events,
> there is nothing related to ata before the "exception" message):
>
> [901292.247428] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> frozen
> [901292.247492] ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
> [901292.247494]          res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask 0x4
> (timeout)
> [901292.247500] ata2.00: status: { DRDY }
> [901292.247512] ata2: hard resetting link
> [901294.090746] ata2: SRST failed (errno=-19)
> [901294.101922] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [901294.101938] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
> [901294.101943] ata2.00: revalidation failed (errno=-5)
> [901299.100347] ata2: hard resetting link
> [901299.974103] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [901300.105734] ata2.00: configured for UDMA/133
> [901300.105776] ata2: EH complete
> [901300.137059] end_request: I/O error, dev sdb, sector 1953519935
> [901300.137069] md: super_written gets error=-5, uptodate=0
> [901300.137077] raid1: Disk failure on sdb1, disabling device.
> [901300.137079] raid1: Operation continuing on 1 devices.
>
> [90307.328266] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> frozen
> [90307.328275] ata2.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
> [90307.328277]          res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask 0x4
> (timeout)
> [90307.328280] ata2.00: status: { DRDY }
> [90307.328288] ata2: hard resetting link
> [90313.218511] ata2: link is slow to respond, please be patient (ready=0)
> [90317.377711] ata2: SRST failed (errno=-16)
> [90317.377720] ata2: hard resetting link
> [90318.251720] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [90318.338026] ata2.00: configured for UDMA/133
> [90318.338062] ata2: EH complete
> [90318.370625] end_request: I/O error, dev sdb, sector 1953519935
> [90318.370632] md: super_written gets error=-5, uptodate=0
> [90318.370636] raid1: Disk failure on sdb1, disabling device.
> [90318.370637] raid1: Operation continuing on 1 devices.
>
> And here's the story for linux-ide from the earlier messages:
>> I'm using two ST31000528AS drives in RAID1 array using MD. I've had
> several
>> failures occur over a period of few months (see logs below). I've RMA'd
> the
>> drive, but then got curious why an otherwise normal drive locks up while
>> trying to write the same sector once a month or so, but does not report
>> having bad sectors, doesn't fail any tests, and does just fine if I do
>> dd if=/dev/urandom of=/dev/sdb bs=512 seek=1953519935 count=1
>> however many times I try.
>> I then tried Googling for this number (1953519935) and found that it
> comes
>> up quite a few times and most of the time (or always) in context of
>> md/raid.

This looks more like some kind of drive communication problem than a 
media problem. It looks like not only did the request time out but it 
didn't respond to the first hard reset either. I'd lean towards 
something like a bad cable, or a power supply that's marginal for the 
number of drives, etc. in the machine.
