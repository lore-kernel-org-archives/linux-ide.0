From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [usb-storage] [Merging ATA passthru] on integrating SMART/ATA-Security
 in usb-storage driver
Date: Wed, 02 Nov 2005 20:12:11 +0100
Message-ID: <43690F8B.5000605@gmx.de>
References: <Pine.LNX.4.44L0.0511021104020.4928-100000@iolanthe.rowland.org>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:42406 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965177AbVKBTMR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 14:12:17 -0500
In-Reply-To: <Pine.LNX.4.44L0.0511021104020.4928-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: usb-storage@lists.one-eyed-alien.net, linux-ide@vger.kernel.org

Alan Stern wrote:
> On Wed, 2 Nov 2005, thomas schorpp wrote:
> 
> 
>>hi,
>>
>>i'll try integrating SMART/ATA-Security in usb-storage driver for usb2
>>ide disks.
>>
>>other people working on it yet? ive read something on SMART efforts for
>>SATA.
>>
>>i think of using the passthrough code (libata?) or module in
>>usb-storage.ko like the SATA driver for ATA-Security.
>>
>>comments?
> 
> 
> Is there any standard way to pass ATA commands over a USB transport?  I've 
> never heard of one.
> 
> Alan Stern
> 
> 

yes, ive read on the smartmontools page theres none, at present.

since therere rw-commands issued, why not possible to issue other, too?
and sata is short of smart support. both use scsi-emu(?).

i dont think theres a hardware problem.

i'll look at sata/libata/smartctl code and trial'n'error.

maybe i find a way and you can propose it as standard then :)
why wait for it?

tom schorpp




