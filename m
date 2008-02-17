From: Joris <joris@v5.be>
Subject: Re: ICH7: ata_piix twice as fast as ahci?
Date: Sun, 17 Feb 2008 17:39:41 +0100
Message-ID: <6b9952490802170839m4456353ejfd5a68d0aaccdf88@mail.gmail.com>
References: <6b9952490802170741h1de9be53nefccea3775f7de00@mail.gmail.com>
	 <20080217161033.3bb420fd@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:10429 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571AbYBQQjl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 11:39:41 -0500
Received: by an-out-0708.google.com with SMTP id d31so309110and.103
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 08:39:41 -0800 (PST)
In-Reply-To: <20080217161033.3bb420fd@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE <linux-ide@vger.kernel.org>

2008/2/17, Alan Cox <alan@lxorguk.ukuu.org.uk>:
> On Sun, 17 Feb 2008 16:41:42 +0100
> Joris <joris@v5.be> wrote:
>
> > Hello List,
> >
> > Odd problem on my machines: the sata disks appear to be a lot slower
> > when used via ata_piix vs the ahci driver.
>
> I would expect that. AHCI allows the use of NCQ and unloads a ton of work
> from the processor. It also means you pretty much avoid the inter command
> latency that limits standard IDE performance.

Alan,

>From your response I'm not sure if I made clear that ata_piix was
faster, and ahci slower?

Am I interpreting this correctly as having to choose between fast iops
with low cpu (+ hotplug) with ahci and twice the linear read speed
with ata_piix?



Kind regards,
Joris
