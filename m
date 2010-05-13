From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: T500 cdrom drive never stops spinning until mount.
Date: Wed, 12 May 2010 19:02:27 -0600
Message-ID: <4BEB4FA3.70308@gmail.com>
References: <20100512023549.GA22623@cpu18.student.cs>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:37644 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab0EMBCb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 May 2010 21:02:31 -0400
In-Reply-To: <20100512023549.GA22623@cpu18.student.cs>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nick Bowler <nbowler@elliptictech.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 05/11/2010 08:35 PM, Nick Bowler wrote:
> The ThinkPad T500 has a SATA cdrom drive attached to an Intel ICH9M/M-E
> SATA ACHI controller.  Upon inserting a disk into this drive, if sr-mod
> is loaded, the disk will never stop spinning by itself:  it will spin up
> to full speed, then start slowing down, but just before it stops, it
> will spin up to full speed, then start slowing down, ad infinitum.
>
> If sr-mod is not loaded, the disk stops spinning right after insertion.
> It is only possible to remove sr-mod when the disk is spinning at full
> speed (all other times the module is in use), and then the disk stops.
>
> Mounting the disk also causes it to stop spinning (and it remains
> stopped after unmounting it).
>
> I see this behaviour with both 2.6.32 and 2.6.34-rc7.

Is something like hal, devicekit, etc. accessing the drive in this case? 
Can you try a minimal boot with no unnecessary processes and see if the 
same thing happens?
