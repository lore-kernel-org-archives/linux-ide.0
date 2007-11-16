From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 6/13] sgiioc4: add ide_toggle_bounce() calls
Date: Thu, 15 Nov 2007 23:27:00 -0800
Message-ID: <20071116072700.GA369631@sgi.com>
References: <200711130001.44501.bzolnier@gmail.com> <47398862.3080901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:58601 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751675AbXKPH1E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Nov 2007 02:27:04 -0500
Content-Disposition: inline
In-Reply-To: <47398862.3080901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Tue, Nov 13, 2007 at 02:20:02PM +0300, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >Add ide_toggle_bounce() call to ->ide_dma_on/->dma_off_quietly
> >methods so they match generic __ide_dma_on()/ide_dma_off_quietly().
> 
> >Cc: Jeremy Higdon <jeremy@sgi.com>
> >Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Tested on an Altix.

Acked-by: Jeremy Higdon <jeremy@sgi.com>
