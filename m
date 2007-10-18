From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/3] ide: Fix use of paired device
Date: Thu, 18 Oct 2007 22:29:02 +0200
Message-ID: <200710182229.03294.bzolnier@gmail.com>
References: <1192668978.21882.719539599813.qpush@grosgo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:4700 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbXJRWuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 18:50:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so285704nfb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 15:50:22 -0700 (PDT)
In-Reply-To: <1192668978.21882.719539599813.qpush@grosgo>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On Thursday 18 October 2007, Benjamin Herrenschmidt wrote:
> At least 2 drivers (siimage and cs5535) have a bug where they use
> the construct:
> 
> 	ide_drive_t *pair	= &hwif->drives[drive->dn ^ 1];
> 
> To access the other drive in a master/slave pair. This is bogus
> because drive->dn is not the unit number, but the global drive
> number, thus can be 2 & 3 for ide1, 4 & 5 for ide2 etc...
> 
> This causes the driver to access beyond the drive array into lalaland
> for any other interface than ide0 and in some case, actually crash :-)
> 
> These 3 patches fix those by introducing a ide_get_paired_drive()
> helper that does the right thing and then using it.
> 
> Please apply to 2.6.24 if no objection.

Thanks for debugging and fixing this!

All three patches applied.

Bart
