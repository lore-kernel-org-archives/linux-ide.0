From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Wed, 10 Jun 2009 13:44:29 +0200
Message-ID: <200906101344.30057.bzolnier@gmail.com>
References: <20090425170203.74603b9c@power-debian> <200906082220.41763.bzolnier@gmail.com> <1244503587.8971.9.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:47468 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbZFJLjP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2009 07:39:15 -0400
Received: by fxm9 with SMTP id 9so679391fxm.37
        for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2009 04:39:16 -0700 (PDT)
In-Reply-To: <1244503587.8971.9.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrey Gusev <a.gusev1980@mail.ru>, linux-ide@vger.kernel.org, petkovbb@gmail.com, linuxppc-dev@ozlabs.org

On Tuesday 09 June 2009 01:26:27 Benjamin Herrenschmidt wrote:
> On Mon, 2009-06-08 at 22:20 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > > [   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> > 
> > DMA status indicates that DMA transfer is still active according to
> > the controller.  This one is really a platform/hardware specific issue.
> 
> I've partially missed that thread. Is the a bugzilla entry or

There is no bugzilla entry currently so please check mailing list
archives for previous discussion.

> something ? Is this a regression ?

At least not a recent one (it happens since at least 2.6.24).
