From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/10] ide: use pci_dev->revision
Date: Thu, 30 Aug 2007 00:09:39 +0200
Message-ID: <200708300009.39138.bzolnier@gmail.com>
References: <200708292316.38779.bzolnier@gmail.com> <46D5E77B.5030800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:38271 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbXH2WIX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Aug 2007 18:08:23 -0400
Received: by nf-out-0910.google.com with SMTP id g13so302907nfb
        for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 15:08:21 -0700 (PDT)
In-Reply-To: <46D5E77B.5030800@intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Kok, Auke" <auke-jan.h.kok@intel.com>
Cc: linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

On Wednesday 29 August 2007, Kok, Auke wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Some places were using PCI_CLASS_REVISION instead of PCI_REVISION_ID so
> > they were not converted by commit 44c10138fd4bbc4b6d6bff0873c24902f2a9da65.
> 
> 
> that's actually another effort that I'm working on atm. You can either hold off 

Great.

> on your patch or we'll see how my patches bounce against yours ;)

I don't envision problems here - my patch is limited to drivers/ide/
and will just get dumped if the more complete patch shows up. :)

Thanks,
Bart
