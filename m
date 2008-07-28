From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_it821x: Driver updates and reworking
Date: Mon, 28 Jul 2008 18:12:19 +0200
Message-ID: <200807281812.19435.bzolnier@gmail.com>
References: <20080724171606.1c2a677c@lxorguk.ukuu.org.uk> <200807281658.54380.bzolnier@gmail.com> <20080728164749.215acf35@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:47183 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbYG1QPW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 12:15:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3456984fkq.5
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 09:15:20 -0700 (PDT)
In-Reply-To: <20080728164749.215acf35@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Monday 28 July 2008, Alan Cox wrote:
> > > Signed-off-by: Alan Cox <alan@redhat.com>
> > 
> > Looks interesting, do you plan on porting it to ide/pci/it821x later?
> 
> SiS have already provided a patch (ugly) for the RDC for the old drivers.

I haven't seen it on the mailing list.

Did they put it on their website or was it send in private mail?

[ Either way please post it to linux-ide@ if you have it. ]

> > PS a bit of shame that this is not splitted on patches with smaller
> > granularity (would make review/merging work far more effective)
> 
> Its all pretty trivial stuff.

For _you_. :)

Thanks,
Bart
