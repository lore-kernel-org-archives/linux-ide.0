From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_ali patch not merged?
Date: Tue, 3 Jul 2007 13:13:35 +0100
Message-ID: <20070703131335.0d8cd6c9@the-village.bc.nu>
References: <46804C1C.9010900@redhat.com>
	<4689FF15.2050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45543 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757689AbXGCMHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 08:07:42 -0400
In-Reply-To: <4689FF15.2050003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, 03 Jul 2007 16:47:33 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Chuck Ebbert wrote:
> > This patch was found to fix some of the problems with the
> > pata_ali driver. Is it going to be merged in 2.6.22?
> > 
> > [https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=156482]
> 
> Jeff, this looks like a worthy fix for 2.6.22.

It's currently in -mm and seems to have sorted all those chipsets out so
its a good candidate to push on further.

Alan
