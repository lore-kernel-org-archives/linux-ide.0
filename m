From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 10/29] ide: __ide_do_rw_disk() return value fix
Date: Thu, 3 Feb 2005 01:36:47 +0100
Message-ID: <58cb370e050202163644e934d0@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025248.GK621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.207]:42566 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262818AbVBCAgs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 19:36:48 -0500
Received: by wproxy.gmail.com with SMTP id 67so167905wri
        for <linux-ide@vger.kernel.org>; Wed, 02 Feb 2005 16:36:47 -0800 (PST)
In-Reply-To: <20050202025248.GK621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:52:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 10_ide_do_rw_disk_pre_task_out_intr_return_fix.patch
> >
> >       In __ide_do_rw_disk(), ide_started used to be returned blindly
> >       after issusing PIO write.  This can cause hang if
> >       pre_task_out_intr() returns ide_stopped due to failed
> >       ide_wait_stat() test.  Fixed to pass the return value of
> >       pre_task_out_intr().
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
