From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 12/29] ide: add ide_hwgroup_t.polling
Date: Thu, 3 Feb 2005 01:42:18 +0100
Message-ID: <58cb370e05020216427757693b@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025538.GM621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.199]:12134 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262361AbVBCAmS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 19:42:18 -0500
Received: by wproxy.gmail.com with SMTP id 67so168504wri
        for <linux-ide@vger.kernel.org>; Wed, 02 Feb 2005 16:42:18 -0800 (PST)
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

Is there really a possibility of something weird?

I'm not claiming that I like this way of coding but poll_timeout
is assigned either to '0' or to 'jiffies + WAIT_WORSTCASE'.

Bartlomiej
