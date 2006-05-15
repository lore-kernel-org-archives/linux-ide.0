From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: question about boot time drive initialization
Date: Mon, 15 May 2006 13:38:33 +0300
Message-ID: <c70ff3ad0605150338j2f9aef2j40ced2c7e95594ed@mail.gmail.com>
References: <4466DE81.2040006@gmail.com>
	 <311601c90605140929s5fe919efk69c59bd5f61fee7d@mail.gmail.com>
	 <4467DE65.7000701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:27603 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964874AbWEOKie convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 06:38:34 -0400
Received: by wr-out-0506.google.com with SMTP id i22so1031003wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 03:38:33 -0700 (PDT)
In-Reply-To: <4467DE65.7000701@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

> > Is power always active in this infrastructure, and will the host
> > respond to COMINIT with either a COMRESET or a COMWAKE?  If so, I'd
> > just wait for the FIS34.  If you don't see a FIS34 within say 10
> > seconds, I'd hit the drive with a COMRESET.

I have seen some SATA drives that sends their FIS34 only after 16 seconds.

> This problem becomes more evident with PM.  PM spec omits the 'waiting
> for the first FIS34' part in the initialization sequence because
> controllers might not be able to handle the FIS
or maybe the PM is still in Laegacy mode and the FIS34 comes from port 0.

.  Actually, when a new
> device gets plugged the port's X bit is turned on and all FIS
> transmissions are blocked.  So, there's no way for the host controller
> to tell whether the device is ready for command or not and has no other
> way than issuing SRST blindly after resuming the link.
>
> On EH case (transient link failure), this is okay as the drive can
> handle the SRST okay, but it seems to cause problems on hotplug case.
> What happens is the controller issues SRST before the drive transmits
> the first FIS34.  As said above, this is the spec-sanctioned enumeration
> sequence.
>
> I'm getting a lot of timeouts on the first reset after hotplug and still
> diddling with delays.  Any thoughts on how this should be solved?  Can
> drives handle SRST before it enters idle state after POR?
>
yes, this is quoted from the ATA-6 standard , section 9.2 (Software
reset protocol)
"If the host sets the SRST bit in the Device Control register to one
before devices have completed execution of the software reset
protocol, then the devices shall restart execution of the software
reset protocol from the beginning."

I've been dealing with Sata drives for along time, and alwasy I sent
sw reset immediatly after OOB sequence (in order to detect PM), all
drives did ok with that, except for one single model, and that was
decalred as bug of the drive and fixed in updated firmware.

BTW, how do distenguesh between PM and ATAPI device? both of them have
the same signature?

saeed
