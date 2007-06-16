From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Disk errors reported on boot - kernel 2.6.18
Date: Sat, 16 Jun 2007 18:30:29 +0100
Message-ID: <20070616183029.715c3662@the-village.bc.nu>
References: <002101c7b028$38bab8d0$0901a8c0@medalha>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38150 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751090AbXFPRZT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jun 2007 13:25:19 -0400
In-Reply-To: <002101c7b028$38bab8d0$0901a8c0@medalha>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Miguel Medalha <miguelmedalha@sapo.pt>
Cc: linux-ide@vger.kernel.org

> I recently installed a new disk on the same computer. This one is a Hitchi 
> HDS721616PLAT80.
> 
> When this disk is connected to the ICH5 controller, the following error 
> lines appear on boot:
> 
> -------------------------------------------------------------------
> hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hda: drive_cmd: error=0x04 { DriveStatusError }
> ide: failed opcode was: 0xb0

Your new drive rejected a SMART command. It was asked (by user space I
suspect - ie smartd) to do some kind of smart operation and reported
51/04 - which is basically 'I do not know/support the command you have
asked me to perform) - amd opcode 0xB0 is smart.

> The drive is working perfectly. I even verified it with a tool provided by 
> the manufacturer. SMART also does not report any error .
> The same disk gives no error whatsoever when connected to a ITE8212 IDE 
> Controler present on the same computer.

The IT8212 with raid firmware doesn't support SMART so any smart
configuration funnies would be hidden

Alan
