From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 12/29] ide: add ide_hwgroup_t.polling
Date: Thu, 3 Feb 2005 15:20:54 +0100
Message-ID: <58cb370e050203062052c5052@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025538.GM621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:50723 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263556AbVBCOWF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 09:22:05 -0500
Received: by wproxy.gmail.com with SMTP id 67so258920wri
        for <linux-ide@vger.kernel.org>; Thu, 03 Feb 2005 06:22:05 -0800 (PST)
In-Reply-To: <20050202025538.GM621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:55:38 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 12_ide_hwgroup_t_polling.patch
> >
> >       ide_hwgroup_t.polling field added.  0 in poll_timeout field
> >       used to indicate inactive polling but because 0 is a valid
> >       jiffy value, though slim, there's a chance that something
> >       weird can happen.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
