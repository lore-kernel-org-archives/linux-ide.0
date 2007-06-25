From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [RFT] hpt366: reset DMA state machine on timeouts
Date: Mon, 25 Jun 2007 16:44:34 -0500
Message-ID: <20070625214434.GA4482@austin.ibm.com>
References: <200706212154.47398.sshtylyov@ru.mvista.com> <20070622151359.GD8840@austin.ibm.com> <467BEB9C.1070407@ru.mvista.com> <20070622163646.GG8840@austin.ibm.com> <467D621A.80406@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:44141 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbXFYVsG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 17:48:06 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5PLm2Im010196
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 17:48:02 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5PLkF01241370
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 15:48:02 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5PLiZDc006207
	for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 15:44:36 -0600
Content-Disposition: inline
In-Reply-To: <467D621A.80406@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Sat, Jun 23, 2007 at 10:10:34PM +0400, Sergei Shtylyov wrote:
> 
>    Now I'm confused too -- did you get any DMA timeouts this time?

No. And yes, this is confusing, as the initial hang that I was seeing 
was preceeded by DMA timeout messages on the screen (as posted in the
initial email). Now, with the patched kernel, I'm not seeing any
DMA timeouts; and, instead, I'm seeing lots of hdc: task_out_intr:
status=0x50 { DriveReady SeekComplete } I don't know why.

However, I have now learned how to make all of my problems go
away: lower the UDMA level.  So its seems that this has been
a humbling experience in (re-)learning about bus glitches.

I'm currently doing an /sbin/hdparm -X 67 /dev/hdc to drop
the udma mode to mode3 == 44 MHz (-X udma_mode + 64) from
the default of mode4 for this controller (the hard drive itself is
supposedly udma100 capable, according to the box).  This has cured 
all of the ide driver problems.

The disk that caused all the problems was: 
Device Model:     MAXTOR STM3320620A

A quick look through ide-dma.c shows that there is no way to
blacklist a drive to the "highest suported" level; the blacklist
is UDMA on or UDMA off.

===============
I have not yet tried playing any udma mode games with libata yet,
to see if I could get that working.
===============

I'd like to propose that, for a system is seeing a fair number of 
drive errors, that, perhaps it should automatically lower the mode, 
in the hope of clearing up the problem. 

--linas
