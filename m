From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_promise driver and 2.6.11 on a MIPS board
Date: Mon, 06 Jun 2005 16:49:21 -0400
Message-ID: <42A4B6D1.9010402@pobox.com>
References: <4789af9e05060613394b1809c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:202 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261668AbVFFUt2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jun 2005 16:49:28 -0400
In-Reply-To: <4789af9e05060613394b1809c3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Ramsay <jim.ramsay@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Jim Ramsay wrote:
> The driver then waits via a wait_for_completion apparently waiting for
> the PCI card to throw an interrupt so it can continue.  However, I
> never see this interrupt generated, and the driver code waits forever.


This is a known bug that definitely needs fixing:

(to ATA developers)
Any time an ATA command is issued outside of the SCSI layer, we need to 
employ a timer to time out commands.

Since most commands are done within the SCSI layer, which provides a lot 
of error handling apparatus, most commands properly time out.  The ones 
during probe - IDENTIFY DEVICE, set xfer mode, etc. - do not have such a 
timer.

	Jeff


