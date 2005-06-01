From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] PCI: amd74xx patch for new NVIDIA device IDs
Date: Wed, 1 Jun 2005 11:50:14 +0200
Message-ID: <58cb370e05060102504fa06c4c@mail.gmail.com>
References: <111760252426@kroah.com> <429D647F.5020701@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.194]:49064 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261151AbVFAJuO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Jun 2005 05:50:14 -0400
Received: by wproxy.gmail.com with SMTP id 68so417788wra
        for <linux-ide@vger.kernel.org>; Wed, 01 Jun 2005 02:50:14 -0700 (PDT)
In-Reply-To: <429D647F.5020701@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, acurrid@nvidia.com

On 6/1/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Greg KH wrote:
> > [PATCH] PCI: amd74xx patch for new NVIDIA device IDs
> >
> > Here's the 2.6 amd74xx patch for NVIDIA MCP51.
> >
> > Signed-off-by: Andy Currid <acurrid@nvidia.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >
> > ---
> > commit af00f9811e0ccbd3db84ddc4cffb0da942653393
> > tree 5a9c3b7f7d61d96d3624ad130b173a761cb7dac2
> > parent 2ac2610b26c9da72820443328ff2c56c7b8c87b8
> > author Andy Currid <acurrid@nvidia.com> Mon, 23 May 2005 08:55:45 -0700
> > committer Greg KH <gregkh@suse.de> Tue, 31 May 2005 14:26:38 -0700
> >
> >  drivers/ide/pci/amd74xx.c |    3 +++
> >  include/linux/pci_ids.h   |    6 ++++++
> 
> 
> This is hardly a PCI patch.
> 
> Has Bart, the IDE maintainer, acked this?
> 
>         Jeff
> 

Thanks Jeff.

Ack.
