From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_sil command 0x25 timeout, stat 0x50 host_stat 0x64 (fwd)
Date: Mon, 11 Oct 2004 11:19:52 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041011151952.GA8674@havoc.gtf.org>
References: <Pine.LNX.4.53.0410111501030.854@wodka.lashout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:2516 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269048AbUJKPTz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2004 11:19:55 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0410111501030.854@wodka.lashout.net>
List-Id: linux-ide@vger.kernel.org
To: Johannes Peeters <jpeeters@lashout.net>
Cc: linux-ide@vger.kernel.org

On Mon, Oct 11, 2004 at 03:07:37PM +0000, Johannes Peeters wrote:
> Hello,
> 
> I accidentaly send this to the linux-kernel mailinlist, but i had to send
> it to the linux-ide list.
> 
> I also tried noapic acpi=off pci=biosirq, but no success. Do you have any
> idea what to do next?

You try each of those command line options individually, not together.

And did you update your card and system BIOS?

	Jeff



