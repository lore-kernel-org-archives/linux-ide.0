From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: sata_via - too slow
Date: Mon, 02 Aug 2004 16:55:47 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <410EC673.1090506@clanhk.org>
References: <410E2E9C.8020606@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.hardcore-gaming.net ([69.93.101.157]:32993 "EHLO
	mail.hardcore-gaming.net") by vger.kernel.org with ESMTP
	id S264147AbUHBVzy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Aug 2004 17:55:54 -0400
In-Reply-To: <410E2E9C.8020606@scssoft.com>
List-Id: linux-ide@vger.kernel.org
To: Petr Sebor <petr@scssoft.com>
Cc: linux-ide@vger.kernel.org

Petr Sebor wrote:

> and it is being worse, I can see frequently, that the 'wait' gets 
> frequently over 90%.
> I have tried the kernel both in SMP or UP, with noacpi, iommu=off, 
> preemptible kernel or not
> without difference....

Which 86_64.org patches are you using?

>
> From what I have understood, these drives are SATA with PATA bridge on 
> them.
> The problems described happen on both. No difference.
>
> Interesting is, that
> root@opteron:$ hdparm -t /dev/sda
>
> /dev/sda:
> Timing buffered disk reads:  144 MB in  3.03 seconds =  47.45 MB/sec
>
> So it is not _that_ slow... 

I highly doubt it's related to libata or sata_via at all.  A high wait 
indicates your processors handle data a lot faster than your harddrives 
can deliver and processes are blocked waiting on I/O, it would otherwise 
be counted as idle time in the 2.4 line; this is normal AFAIK.  Your 
performance is nominal, the problem is most likely elsewhere.

What motherboard is this?  The MSI FAR2 whatever?

-ryan
