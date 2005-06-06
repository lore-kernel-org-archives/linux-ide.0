From: Jim Ramsay <jim.ramsay@gmail.com>
Subject: Re: sata_promise driver and 2.6.11 on a MIPS board
Date: Mon, 6 Jun 2005 15:58:48 -0600
Message-ID: <4789af9e05060614585b319b1@mail.gmail.com>
References: <4789af9e05060613394b1809c3@mail.gmail.com>
	 <42A4B6D1.9010402@pobox.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:7893 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261737AbVFFWF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Jun 2005 18:05:29 -0400
Received: by zproxy.gmail.com with SMTP id 16so1907037nzp
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2005 15:05:28 -0700 (PDT)
In-Reply-To: <42A4B6D1.9010402@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On 6/6/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Jim Ramsay wrote:
> > The driver then waits via a wait_for_completion apparently waiting for
> > the PCI card to throw an interrupt so it can continue.  However, I
> > never see this interrupt generated, and the driver code waits forever.
> 
> 
> This is a known bug that definitely needs fixing:
> 
> (to ATA developers)
> Any time an ATA command is issued outside of the SCSI layer, we need to
> employ a timer to time out commands.
> 
> Since most commands are done within the SCSI layer, which provides a lot
> of error handling apparatus, most commands properly time out.  The ones
> during probe - IDENTIFY DEVICE, set xfer mode, etc. - do not have such a
> timer.

So is this an issue with the sata_promise.c driver, or the
libata-core.c?  Which one should implement the timeout?

What would you suggest as a workaround or a proper fix?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
