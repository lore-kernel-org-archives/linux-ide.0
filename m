From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [RFT] hpt366: reset DMA state machine on timeouts
Date: Fri, 22 Jun 2007 11:36:47 -0500
Message-ID: <20070622163646.GG8840@austin.ibm.com>
References: <200706212154.47398.sshtylyov@ru.mvista.com> <20070622151359.GD8840@austin.ibm.com> <467BEB9C.1070407@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:57334 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757416AbXFVQgs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 12:36:48 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l5MGVwin004530
	for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 12:31:58 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5MGalq5268058
	for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 10:36:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5MGalDL001121
	for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 10:36:47 -0600
Content-Disposition: inline
In-Reply-To: <467BEB9C.1070407@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Fri, Jun 22, 2007 at 07:32:44PM +0400, Sergei Shtylyov wrote:
> 
> >>Reset HPT36x's DMA state machine on a DMA timeout the way it's done for 
> >>HPT370.
> >>drivers/ide/pci/hpt366.c |   24 +++++++++++++++++++++++-
> 
> >This worked great!  
>
>    I hope you meant those messages were preceeded by DMA timeouts 
>    (otherwise this code wouldn't come into action).

Oops, I was wrong ... 

Scads of 
Jun 21 20:22:30 localhost kernel: [  434.574301] hdc: task_out_intr:
status=0x50 { DriveReady SeekComplete }
Jun 21 20:22:30 localhost kernel: [  434.574318] ide: failed opcode was:
unknown

> >from it (I put in a printk to verify this).
> 
>    You mean into my ide_dma_timeout() method?

Ooops, I lied. I have so many printk's in there, that I got confused.
No, in fact, it looks like I did NOT see your handler run. 

Per Alan Cox, I have to go back and see if dropping the
UDMA speeds and/or replacing the cable will help.

>    What's strange is that it never seemed to be necessary before your great 
> new drive... ;-)

At $70 for 320GB, how can one say "no"?  Frye's had a mound of them,
shoulder-high.

 MAXTOR STM3320620A

>    So, providing its data certainly wouldn't hurt -- perhaps we just should 
> blacklist it instead -- maybe there's a UDMA speed at which this wouldn't 
> happen, and we could just limit the drive to it.

I'll experiment with the UDMA settings.

>    In fact, it should be turned off after 3 DMA errors (causing PIO 
>    retries).

I'd like to see this turned into a rate. If the system gets one error
a month, and has been up for 3 months, the third error should not shut
things down. The room that this is in is hot; the machine might be
occasionally bumped. A low error rate is acceptable; its more acceptable
than a mysterious slow-down of performance after 3 months. 

--linas
