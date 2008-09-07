From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Fix pointer arithmetic in hpt3xx driver code (3rd try)
Date: Sun, 7 Sep 2008 20:10:03 +0200
Message-ID: <200809072010.04122.bzolnier@gmail.com>
References: <20080906171850.GF26371@google.com> <48C39D2F.4010701@ru.mvista.com> <48C3B909.3030405@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:41294 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbYIGS1a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 14:27:30 -0400
Received: by nf-out-0910.google.com with SMTP id d3so223023nfc.21
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 11:27:21 -0700 (PDT)
In-Reply-To: <48C3B909.3030405@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Masoud Sharbiani <masouds@google.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

Masoud/Sergei: sorry for the bug and thanks for fixing it.

On Sunday 07 September 2008, Sergei Shtylyov wrote:
> Hello, I wrote:
> >> diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
> >> index eb107ee..4eae284 100644
> >> --- a/drivers/ide/pci/hpt366.c
> >> +++ b/drivers/ide/pci/hpt366.c
> >> @@ -613,6 +613,14 @@ static int check_in_drive_list(ide_drive_t 
> >> *drive, const char **list)
> >>      return 0;
> >>  }
> >>  
> >> +static struct hpt_info *hpt3xx_get_info(struct device *dev)
> >> +{
> >> +    struct ide_host *host    = pci_get_drvdata(to_pci_dev(pci_dev));
> >>   
> >
> >   Oops, this just won't compile. :-/
> 
>    BTW, there's no need to invoke to_pci_dev() at all since 
> pci_get_drvdata(dev) boils down to dev_get_drvdata(&dev->dev) call. So, 
> in order not to waste time on useless pointer tricks, we should just 
> invoke the latter here.

I corrected this and applied the patch.
