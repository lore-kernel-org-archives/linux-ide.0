From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 04/29] ide: cleanup piix
Date: Thu, 3 Feb 2005 01:20:15 +0100
Message-ID: <58cb370e050202162041f9b92@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024611.GE621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.204]:25813 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262404AbVBCAUP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 19:20:15 -0500
Received: by wproxy.gmail.com with SMTP id 67so165707wri
        for <linux-ide@vger.kernel.org>; Wed, 02 Feb 2005 16:20:15 -0800 (PST)
In-Reply-To: <20050202024611.GE621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:46:11 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 04_ide_cleanup_piix.patch
> >
> >       In drivers/ide/pci/piix.[hc], init_setup_piix() is defined and
> >       used but only one init_setup function is defined and no
> >       demultiplexing is done using init_setup callback.  As other
> >       drivers call ide_setup_pci_device() directly in such cases,
> >       this patch removes init_setup_piix() and makes piix_init_one()
> >       call ide_setup_pci_device() directly.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
