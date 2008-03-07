From: Mark Lord <liml@rtr.ca>
Subject: Re: SATA HDD password problem
Date: Fri, 07 Mar 2008 09:45:04 -0500
Message-ID: <47D154F0.50607@rtr.ca>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA> <47CFBDB6.8040400@gmail.com> <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA> <47D0BC5A.9000208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2861 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbYCGOpH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Mar 2008 09:45:07 -0500
In-Reply-To: <47D0BC5A.9000208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Rus.
> Rus V. Brushkoff wrote:
...
>> [Hors]:root:~ # hdparm -K 1 /dev/sda
>>
>> /dev/sda:
>>  setting drive keep features to 1 (on)
>>  HDIO_DRIVE_CMD(keepsettings) failed: Input/output error
>> .....
> 
> Those two are different ones.  These are to keep software setting over
> soft resets and doesn't have much to do with SSP.  Mark, maybe we need
> to add a feature to hdparm to configure SSP?
..

MMmm..  yes, there are a bunch of newish things there, specificially for SATA.
I'll extend hdparm to give access to changing those things.
..
>> :To solve the problem, ATA added Software Setting Preservation
>> :featureset, which makes the drive remember configurations over
>> :hardresets but it's an optional feature and not all drives implement it.
>> : I think having SSP support in the drive is the only sane way to support
>> :password locking on SATA; otherwise, the drive can just go away while
>> :the system is running.  That said, it would be nice to have a parameter
>> :to force SRST or no reset at all for odd cases.
>>
>>  Hmm, if someone enable SSP in the drive after password unlock - does this 
>> mean that it will be unlocked forever ? Or drive can distinguish between 
>> power-on and hard-reset states ?
> 
> SSP by default stays on, so once unlocked it will stay unlocked as long
> as power stays applied.  On power loss, it gets locked again.  On
> reboots, the BIOS can always lock it again if it wants to.
..

The problem here, is that SSP itself gets turned-OFF after COMMRESET.
It does preserve settings over the COMMRESET, but it then has to be
renewed (re-issued by the driver) for things to survive a subsequent
COMMRESET after the first one.   This has to go into libata,
as it's not something we can control entirely from hdparm.

??
