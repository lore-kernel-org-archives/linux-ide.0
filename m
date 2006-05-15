From: Tejun Heo <htejun@gmail.com>
Subject: Re: question about boot time drive initialization
Date: Mon, 15 May 2006 20:08:14 +0900
Message-ID: <4468611E.1000907@gmail.com>
References: <4466DE81.2040006@gmail.com>	 <311601c90605140929s5fe919efk69c59bd5f61fee7d@mail.gmail.com>	 <4467DE65.7000701@gmail.com> <c70ff3ad0605150338j2f9aef2j40ced2c7e95594ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:9454 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964882AbWEOLIW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 07:08:22 -0400
Received: by wr-out-0506.google.com with SMTP id i22so1035029wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 04:08:21 -0700 (PDT)
In-Reply-To: <c70ff3ad0605150338j2f9aef2j40ced2c7e95594ed@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

saeed bishara wrote:
>> > Is power always active in this infrastructure, and will the host
>> > respond to COMINIT with either a COMRESET or a COMWAKE?  If so, I'd
>> > just wait for the FIS34.  If you don't see a FIS34 within say 10
>> > seconds, I'd hit the drive with a COMRESET.
> 
> I have seen some SATA drives that sends their FIS34 only after 16 seconds.

I heard that some external storage products which emulate SATA interface 
take pretty long time to get ready after power-on.

[--snip--]
>> I'm getting a lot of timeouts on the first reset after hotplug and still
>> diddling with delays.  Any thoughts on how this should be solved?  Can
>> drives handle SRST before it enters idle state after POR?
>>
> yes, this is quoted from the ATA-6 standard , section 9.2 (Software
> reset protocol)
> "If the host sets the SRST bit in the Device Control register to one
> before devices have completed execution of the software reset
> protocol, then the devices shall restart execution of the software
> reset protocol from the beginning."

Yes, I've checked that clause too, but it only applies to SRST - if SRST 
is issued before the previous SRST isn't finished, honor the second SRST.

And the same document says, in section 9.1 (Power-on and hardware reset 
protocol).

"The host should not set the SRST bit to one in the Device Control 
register or issue a DEVICE RESET command while the BSY bit is set to one 
in either Device Status register as a result of executing the power-on 
or hardware reset protocol.  If the host sets the SRST bit in the Device 
Control register to one or issues a DEVICE RESET command before devices 
have completed execution of the power-on or hardware reset protocol, 
then the devices shall ignore the software reset or DEVICE RESET command."

So, the standard specifically forbids it.  The second half is a bit 
comforting though.

> 
> I've been dealing with Sata drives for along time, and alwasy I sent
> sw reset immediatly after OOB sequence (in order to detect PM), all
> drives did ok with that, except for one single model, and that was
> decalred as bug of the drive and fixed in updated firmware.

Hmmm.. weird.  That's not what I'm seeing.  AHCI reports command issue 
failure if something goes wrong while transmitting D2H fis for a command 
(probably when it sees R_ERR).  If I issue SRST shortly after power-on, 
AHCI fails SRST due to command issue failure.  So, it seems that the 
device rejects SRST before it transmits the first FIS34.

If I put the same device on sil3124/32 and perform HRST then SRST in a 
few secs, about the same thing seems to happen but sil3124/32 times out 
rather than reporting error immediately.

> BTW, how do distenguesh between PM and ATAPI device? both of them have
> the same signature?

This is the relevant comment.

	/* Apple's open source Darwin code hints that some devices only
	 * put a proper signature into the LBA mid/high registers,
	 * So, we only check those.  It's sufficient for uniqueness.
	 *
	 * ATA/ATAPI-7 (d1532v1r1: Feb. 19, 2003) specified separate
	 * signatures for ATA and ATAPI devices attached on SerialATA,
	 * 0x3c/0xc3 and 0x69/0x96 respectively.  However, SerialATA
	 * spec has never mentioned about using different signatures
	 * for ATA/ATAPI devices.  Then, Serial ATA II: Port
	 * Multiplier specification began to use 0x69/0x96 to identify
	 * port multpliers.  ATA/ATAPI-7 dropped descriptions about
	 * 0x3c/0xc3 and 0x69/0x96 shortly and described them as
	 * reserved for SerialATA.
	 *
	 * We follow the current spec and consider that 0x69/0x96
	 * identifies a port multiplier.  If there is an ATAPI device
	 * which returns 0x69/0x96 as its signature, we'll have to
	 * implement 'try PM, then try ATAPI' logic.
	 */

-- 
tejun
