From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 7/9] libata: stop overloading port_info->private_data
Date: Sat, 09 Feb 2008 11:07:20 +0900
Message-ID: <47AD0AD8.3020402@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com>	<1201685344817-git-send-email-htejun@gmail.com> <20080204142658.00314213@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:65174 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbYBICHl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 21:07:41 -0500
Received: by wa-out-1112.google.com with SMTP id v27so772243wah.23
        for <linux-ide@vger.kernel.org>; Fri, 08 Feb 2008 18:07:27 -0800 (PST)
In-Reply-To: <20080204142658.00314213@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Alan Cox wrote:
> On Wed, 30 Jan 2008 18:29:01 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> port_info->private_data is currently used for two purposes - to record
>> private data about the port_info or to specify host->private_data to
>> use when allocating ata_host.
> 
> Sensible point, horrible implementation - I'd NAK this strongly in favour
> of switching to:
> 
> ata_pci_init_one(....., private_ptr);
>
> otherwise when that glue changes we are going to keep having to fix six
> or more drivers.

That alloc-init-register sequence is now the standard initialization
sequence used by all drivers which either aren't SFF or need extra stuff
on top of SFF.  ata_pci_init_one() being pretty simple at this point, I
thought the converted ones could just follow the suit instead of
updating every ata_pci_init_one() call.

Oh well, you deal with most SFF drivers anyway.  I'll add "void
*host_priv" to ata_pci_init_one().

Thanks.

-- 
tejun
