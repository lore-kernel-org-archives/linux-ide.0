From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_it821x: Driver updates and reworking
Date: Mon, 28 Jul 2008 19:42:39 +0200
Message-ID: <200807281942.39465.bzolnier@gmail.com>
References: <20080724171606.1c2a677c@lxorguk.ukuu.org.uk> <20080728171153.33a09b4b@lxorguk.ukuu.org.uk> <20080728172050.37f9a18f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:56615 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYG1Rpc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 13:45:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3488052fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 10:45:30 -0700 (PDT)
In-Reply-To: <20080728172050.37f9a18f@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Monday 28 July 2008, Alan Cox wrote:
> On Mon, 28 Jul 2008 17:11:53 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> 
> > On Mon, 28 Jul 2008 18:12:19 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > On Monday 28 July 2008, Alan Cox wrote:
> > > > > > Signed-off-by: Alan Cox <alan@redhat.com>
> > > > > 
> > > > > Looks interesting, do you plan on porting it to ide/pci/it821x later?
> > > > 
> > > > SiS have already provided a patch (ugly) for the RDC for the old drivers.
> > > 
> > > I haven't seen it on the mailing list.
> > > 
> > > Did they put it on their website or was it send in private mail?
> > 
> > On the website. I'm not sure I bookmarked it all.
> > 
> > Its pretty simple - set it up as an IT8211 without UDMA > 33
> 
> Found it:
> 
> http://www.vortex86sx.com/patch-2.6.18-DMP.gz

Thanks, unfortunately it is for 2.6.18 so it is easier
to just port your patch (it is much cleaner anyway).
