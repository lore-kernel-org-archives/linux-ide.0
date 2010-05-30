From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: via 8237 sata errors
Date: Sun, 30 May 2010 13:40:49 -0600
Message-ID: <AANLkTilSg8KZc2ZNobxQUnU105ADOeyxTAvJ3vFvbqEC@mail.gmail.com>
References: <201005292046.06344.tfjellstrom@strangesoft.net>
	<4C02B104.4010900@gmail.com>
	<201005301257.31839.tfjellstrom@strangesoft.net>
	<201005301333.51149.tfjellstrom@strangesoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51561 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab0E3Tku convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 May 2010 15:40:50 -0400
In-Reply-To: <201005301333.51149.tfjellstrom@strangesoft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Fjellstrom <tfjellstrom@strangesoft.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, May 30, 2010 at 1:33 PM, Thomas Fjellstrom
<tfjellstrom@strangesoft.net> wrote:
> On May 30, 2010, Thomas Fjellstrom wrote:
>> On May 30, 2010, Robert Hancock wrote:
>> > On 05/29/2010 08:46 PM, Thomas Fjellstrom wrote:
>> > > I'm getting a rather nasty set of messages from dmesg when tryin=
g to
>> > > use a couple SATA II WD 2TB Green drives with an older system (v=
ia
>> > > 8237 based). They seem to work fine on a newer p35 based system.
>> >
>> > ..
>> >
>> > > [ =A0283.308963] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 =
action
>> > > 0x0 [ =A0283.309007] ata2.00: BMDMA stat 0x4
>> > > [ =A0283.309045] ata2.00: failed command: READ DMA
>> > > [ =A0283.309089] ata2.00: cmd c8/00:08:08:08:30/00:00:00:00:00/e=
0 tag 0
>> > > dma 4096 in [ =A0283.309091] =A0 =A0 =A0 =A0 =A0res
>> > > 41/04:00:08:08:30/00:00:00:00:00/e0 Emask 0x1 (device error) [
>> > > 283.309171] ata2.00: status: { DRDY ERR }
>> > > [ =A0283.309207] ata2.00: error: { ABRT }
>> > > [ =A0283.324886] ata2.00: configured for UDMA/133
>> > > [ =A0283.324904] ata2: EH complete
>> >
>> > It's not really clear why the drive is returning command aborted o=
n a
>> > read, there's no other error bits to indicate an uncorrectable err=
or or
>> > a CRC error. Is it only the one drive that's giving the errors?
>>
>> I'm not entirely sure if its the same drive each time. I can make su=
re
>> today. The fun part is it works fine in a different machine. Where a=
s it
>> will start erroring out like that almost right away in the via based
>> machine. When its doing that, its also making some fairly scary (for=
 a
>> hard drive) noises, but since it doesn't do that in the p35 machine =
I'm
>> really hoping it isn't the drive.
>
> I've started up a dd on each drive, just for kicks, and reading from =
both of
> them at the same time seems to work fine on the via chipset. Given th=
is
> little tid-bit, it seems its only once md-raid is setup on the drives=
 does
> one of them freak out.

If the problem happens mostly when both drives are in use then it
could be a power supply issue. Some drives are rather sensitive to
power fluctuations. You could try and move the drives to separate
power cables if they're on the same one, or maybe the power supply's
just not up to snuff.
