From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Wed, 06 Aug 2008 00:57:09 +0200
Message-ID: <871w13xe7u.fsf@denkblock.local>
References: <fa.nx0yFPJm+aNXPHgykUrOzZXvvIs@ifi.uio.no>
	<fa.NfEr7Ik6e8oextyWICW/jR5emeE@ifi.uio.no>
	<fa.zGvATZImeUo0tHJe4hzlk5+mTiM@ifi.uio.no>
	<fa.SRVleMItV5QEF7/tgCjSHz0ScJA@ifi.uio.no>
	<fa.YKbhgq8XUxH/Qg1ArE+73YsDlpE@ifi.uio.no> <4897D16F.3000504@shaw.ca>
	<20080805131417.GC8569@mit.edu> <20080805195912.GE7939@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:49294 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbYHEXCj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Aug 2008 19:02:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Theodore Tso <tytso@mit.edu>, Robert Hancock <hancockr@shaw.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Gabor Gombas <gombasg@sztaki.hu>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

[Resending because gmane cut off the To: header in Pavel's email, sorry.]

Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
[...]
>> So there's a reason why the anti-shock protection is set at a rather

[+]
>> sensitive level...    
>> 
>> The real right answer though is to buy one of the laptop drives (such
>> as the Seagate Momentus 7200.2 or 7200.3) which has the anti-shock
>> detection built directly into the hard drive.  That way you don't have
>> to have a daemon that sits in the OS waking up the CPU some 20 to 30
>> times a second and burning up your battery even when the laptop is
>> idle.
>
> Hmm, when the laptop is idle, "right thing" is to spin the disk down,
> and at that point you no longer need to poll the accelerometer...

Not quite, I'm afraid. Even if the disk isn't spinning, we still have to
make sure that it won't spin up in a precarious situation. Of course, if
it wasn't user space but some kernel routine that consults the
accelerometer and decides when to stop I/O, then we could indeed stop
querying the accelerometer while the disk is in standby mode and delay a
subsequent spin up for the time required to gather the necessary
accelerometer data. However, as I have explained before, it is not quite
trivial to implement all this in kernel space and I'd like to get head
unloading merged first.

Regards,

Elias
