From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What's with libata and DVDs ?
Date: Sun, 7 Dec 2008 11:20:32 +0000
Message-ID: <20081207112032.25089ac9@lxorguk.ukuu.org.uk>
References: <493B554D.3070403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55924 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753488AbYLGLUX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 06:20:23 -0500
In-Reply-To: <493B554D.3070403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Sat, 06 Dec 2008 23:47:09 -0500
Mark Lord <liml@rtr.ca> wrote:

> Attempting to play a known-good DVD-video in MythTV-0.21
> using libata in kernel 2.6.27.7 :
> 
> sr 4:0:0:0: [sr0] unaligned transfer

Your system somehow generated a scsi request which was not 2K aligned.
The scsi mid layer then reported that and added padding - which
presumably didn't help because the command shouldn't have been misaligned
in the first place.

If you strace it do you see any misaligned requests coming from user
space - also btw is the cd layer reporting the sector size wrong
anywhere ?

Alan
