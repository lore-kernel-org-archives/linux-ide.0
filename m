From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA tape drive STT3401A needs DRQ HSM workaround too
Date: Mon, 22 Oct 2007 10:31:57 +0100
Message-ID: <20071022103157.5ec97ad6@the-village.bc.nu>
References: <471C6C44.2030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46238 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751108AbXJVJ3d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2007 05:29:33 -0400
In-Reply-To: <471C6C44.2030607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Albert Lee <albertcc@tw.ibm.com>

On Mon, 22 Oct 2007 18:24:20 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Hello, all.
> 
> There was a bug report involving ATA tape drive STT3401A and the drive
> also sets DRQ with device error and works correctly if the check is
> ignored.  I saw patch implementing needed horkage.  What's the plan
> here?  Blacklist all tape drives or individual ones as they come up?

After discussion with Jeff the horkage patch is going back into the
bitbucket and the state machine will be changed to consider the DRQ|ERR
case simply a device error. I sent a patch for that to Andrew just before
I left on holiday

Alan
