From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH]: resubmitted: Fix erroneous rq->buffer = NULL in ide-io.c:ide_dma_timeout_retry
Date: Fri, 7 Jan 2005 03:18:57 +0100
Message-ID: <58cb370e05010618182302aa83@mail.gmail.com>
References: <41DD5794.6080804@sgi.com> <20050106155552.GQ17821@suse.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:19720 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261190AbVAGCS6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2005 21:18:58 -0500
Received: by wproxy.gmail.com with SMTP id 55so176769wri
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2005 18:18:58 -0800 (PST)
In-Reply-To: <20050106155552.GQ17821@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Prarit Bhargava <prarit@sgi.com>, linux-ide@vger.kernel.org

On Thu, 6 Jan 2005 16:55:56 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Jan 06 2005, Prarit Bhargava wrote:
> > Colleagues,
> >
> > Please see discussion related to this patch here,
> >
> > http://marc.theaimsgroup.com/?l=linux-ide&m=110485007824374&w=2
> 
> Acked-by: Jens Axboe <axboe@suse.de>

applied
