From: Johannes Peeters <jpeeters@lashout.net>
Subject: Re: sata_sil command 0x25 timeout, stat 0x50 host_stat 0x64 (fwd)
Date: Mon, 11 Oct 2004 16:29:17 +0000 (GMT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.53.0410111626510.11673@wodka.lashout.net>
References: <Pine.LNX.4.53.0410111501030.854@wodka.lashout.net>
 <20041011151952.GA8674@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lashout.net ([213.239.130.203]:21468 "HELO lashout.net")
	by vger.kernel.org with SMTP id S269133AbUJKQ3W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Oct 2004 12:29:22 -0400
In-Reply-To: <20041011151952.GA8674@havoc.gtf.org>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Mon, 11 Oct 2004, Jeff Garzik wrote:

> On Mon, Oct 11, 2004 at 03:07:37PM +0000, Johannes Peeters wrote:
> > Hello,
> >
> > I accidentaly send this to the linux-kernel mailinlist, but i had to send
> > it to the linux-ide list.
> >
> > I also tried noapic acpi=off pci=biosirq, but no success. Do you have any
> > idea what to do next?
>
> You try each of those command line options individually, not together.
>
> And did you update your card and system BIOS?
>
> 	Jeff
>

I tried them individually, but none of them worked.
I was a bit afraid of a bios upgrade (it's an old compaq), but did it. The
cards already have the latsts firmware.
With the new bios, the problem still exists...
With the siimage driver it works fine, so i think it's not related to the
controllers/disks.

Do you need anymore information?

Thanks,
Johannes Peeters
