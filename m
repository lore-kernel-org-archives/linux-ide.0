From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 14/29] ide: remove NULL checking in ide_error()
Date: Thu, 3 Feb 2005 02:14:35 +0100
Message-ID: <58cb370e050202171465143ce7@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025728.GO621@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.192]:1851 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262833AbVBCBOl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2005 20:14:41 -0500
Received: by wproxy.gmail.com with SMTP id 67so173498wri
        for <linux-ide@vger.kernel.org>; Wed, 02 Feb 2005 17:14:35 -0800 (PST)
In-Reply-To: <20050202025728.GO621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 2 Feb 2005 11:57:28 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 14_ide_error_remove_NULL_test.patch
> >
> >       In ide_error(), drive cannot be NULL.  ide_dump_status() can't
> >       handle NULL drive.

applied, you missed Signed-off-by line
