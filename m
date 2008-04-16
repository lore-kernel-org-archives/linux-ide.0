From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/6] scc_pata: add ->{in,out}put_data methods
Date: Thu, 17 Apr 2008 00:09:43 +0200
Message-ID: <200804170009.44039.bzolnier@gmail.com>
References: <200803302141.06106.bzolnier@gmail.com> <480638EA.2000708@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:52666 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794AbYDPW1u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:27:50 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2584416fgb.17
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:27:49 -0700 (PDT)
In-Reply-To: <480638EA.2000708@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 16 April 2008, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > There should be no functional changes caused by this patch.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/pci/scc_pata.c
> > ===================================================================
> > --- a/drivers/ide/pci/scc_pata.c
> > +++ b/drivers/ide/pci/scc_pata.c
> > @@ -574,6 +574,36 @@ static int __devinit init_setup_scc(stru
> >  	return ide_setup_pci_device(dev, d);
> >  }
> 
>     This patch in the pata-2.6 series doesn't apply anymore after the patch 
> getting rid of ide_setup_pci_device() call was merged.

I updated it in IDE tree while merging Akira's patch but it turned out
that "take 2" was needed anyway...
