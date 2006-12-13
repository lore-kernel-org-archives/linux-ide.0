From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Date: Wed, 13 Dec 2006 14:53:25 +0000
Message-ID: <20061213145325.41fc4300@localhost.localdomain>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
	<20061212234145.557cb035@localhost.localdomain>
	<45800B4D.8000906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47503 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964981AbWLMOqH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Dec 2006 09:46:07 -0500
In-Reply-To: <45800B4D.8000906@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> >>+static int tc86c001_busproc(ide_drive_t *drive, int state)
> >>+{
> 
> > Waste of space having a busproc routine. The maintainer removed all the
> > usable hotplug support from old IDE so this might as well be dropped.
> 
>     Don't know what you mean, ioctl is still there...

You can turn the bus on and off but there is no ability to actually swap
drives except in RHEL4 and 2.4.x-ac kernels. Hence "waste of space"

> > "Close but no cookie": please fix the PCI quirk to match the current -mm
> > behaviour with the ATA resource tree. Otherwise - nice driver.
> 
>     Ugh, I should've expected some backstab from -mm tree...

If it is native only then there are no problems with the quirk 

Acked-by: Alan Cox <alan@redhat.com>
