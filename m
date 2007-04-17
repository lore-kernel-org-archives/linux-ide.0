From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: HPA support
Date: Tue, 17 Apr 2007 15:15:23 -0400
Message-ID: <46251CCB.9040906@pobox.com>
References: <20070411002313.29069ca5@the-village.bc.nu> <20070417184139.GB11211@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42148 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030866AbXDQTP2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 15:15:28 -0400
In-Reply-To: <20070417184139.GB11211@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jkeating@redhat.com

Dave Jones wrote:
> On Wed, Apr 11, 2007 at 12:23:13AM +0100, Alan Cox wrote:
>  > Signed-off-by: Alan Cox <alan@redhat.com>
>  > 
>  > Add support for ignoring the BIOS HPA result (off by default) and setting
>  > the disk to the full available size unless already frozen.
>  > 
>  > Tested with various platforms/disks and confirmed to work with the
>  > Macintosh (which broke earlier) and ata_piix (breakage due to the LBA48
>  > readback that Tejun fixed).
>  > 
>  > For normal users this brings us, I believe, to feature parity with old IDE
>  > (and of course more featured in some areas too).
> 
> This is broken horribly on nvidia chipsets..

I think this is what Kyle reported?  Try booting with sata_nv module 
parameter 'adma' set to zero, does that fix the problem?

	Jeff



