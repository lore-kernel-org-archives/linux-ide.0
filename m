From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Wed, 27 Oct 2004 18:29:38 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e041027092943037ab4@mail.gmail.com>
References: <200410271213_MC3-1-8D44-F2D8@compuserve.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.207]:45614 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262512AbUJ0Q3m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Oct 2004 12:29:42 -0400
Received: by wproxy.gmail.com with SMTP id 64so344199wri
        for <linux-ide@vger.kernel.org>; Wed, 27 Oct 2004 09:29:39 -0700 (PDT)
In-Reply-To: <200410271213_MC3-1-8D44-F2D8@compuserve.com>
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Wed, 27 Oct 2004 12:10:50 -0400, Chuck Ebbert
<76306.1226@compuserve.com> wrote:
> On Wed, 27 Oct 2004 at 15:07:14 +0200 Bartlomiej Zolnierkiewicz wrote:
> 
> >@@ -585,7 +564,8 @@
> >       struct pci_dev *dev = hwif->pci_dev;
> >
> >       /* PDC20265 has problems with large LBA48 requests */
> >-      if (dev->device == PCI_DEVICE_ID_PROMISE_20265)
> >+      if ((dev->device == PCI_DEVICE_ID_PROMISE_20267) ||
> >+          (dev->device == PCI_DEVICE_ID_PROMISE_20265))
> >               hwif->rqsize = 256;
> >
> >       hwif->autodma = 0;
> 
> 
>    You forgot to update the comment...

ah, care to send a patch?

>    I added this and the smart_thresholds() fix to my 2.6.9-base patches.
> 
>    Now I have these ide fixes:
> 
>         - smart_thresholds() fix
>         - pdc202xx_old LBA48 fix
>         - accept bad Maxtor drive serial number
>         - allow drive that reports no geometry
> 
>    Should anything more really be in there?

Nope, looks like you've all critical stuff.
