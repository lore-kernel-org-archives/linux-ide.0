From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: new tool:  blktool
Date: Sun, 15 Aug 2004 19:44:40 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <411FF568.8030202@pobox.com>
References: <411FD744.2090308@pobox.com> <411FF170.9070700@rtr.ca> <411FF2FA.4000602@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40845 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267259AbUHOXo5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Aug 2004 19:44:57 -0400
In-Reply-To: <411FF2FA.4000602@rtr.ca>
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Supplementary or Alternatively, all of the ATA device commands issued by 
> hdparm
> can be supported in a driver by simply implementing the HDIO_DRIVE_CMD
> ioctl -- This is only a few lines of code in a typical SATA/SCSI driver,
> and I could easily supply a patch to implement it in libata.
> 
> Sure it's old, looks clunky, but it is simple code that works
> and is used by many more tools than just hdparm today.


True but I'm wrestling with one of its design flaws...  it doesn't 
provide the taskfile protocol.

I really really want to know before the command is submitted whether I 
am going to be receiving data, sending data, or neither.  The current 
IDE driver "guesses" by virtue of DRQ flag behavior, but such a guess is 
impossible on modern SATA controllers.

You either have to provide a lookup table (command opcode -> protocol), 
or specify it through the userland API.  HDIO_DRIVE_TASKFILE does this 
via 'data_phase'.

On a more general note, though, I certainly welcome libata patches from 
any and all sources.  Hack away!

	Jeff


