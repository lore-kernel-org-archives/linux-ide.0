From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 6/13] sgiioc4: add ide_toggle_bounce() calls
Date: Fri, 16 Nov 2007 21:33:06 +0100
Message-ID: <200711162133.06719.bzolnier@gmail.com>
References: <200711130001.44501.bzolnier@gmail.com> <47398862.3080901@ru.mvista.com> <20071116072700.GA369631@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:7282 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811AbXKPVb1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 16:31:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so707011ugc
        for <linux-ide@vger.kernel.org>; Fri, 16 Nov 2007 13:31:25 -0800 (PST)
In-Reply-To: <20071116072700.GA369631@sgi.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Friday 16 November 2007, Jeremy Higdon wrote:
> On Tue, Nov 13, 2007 at 02:20:02PM +0300, Sergei Shtylyov wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > 
> > >Add ide_toggle_bounce() call to ->ide_dma_on/->dma_off_quietly
> > >methods so they match generic __ide_dma_on()/ide_dma_off_quietly().
> > 
> > >Cc: Jeremy Higdon <jeremy@sgi.com>
> > >Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > 
> > Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> Tested on an Altix.

Thanks!

> Acked-by: Jeremy Higdon <jeremy@sgi.com>

added to patch description
