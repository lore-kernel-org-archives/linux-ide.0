From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Simtec BAST (EB2410ITX) / Thorcom VR1000 driver
Date: Fri, 1 Oct 2004 16:25:03 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e0410010725454ea01f@mail.gmail.com>
References: <20040928145828.GH22627@home.fluff.org>
	 <20041001123135.GO22627@home.fluff.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.200]:19120 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269537AbUJAOZG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Oct 2004 10:25:06 -0400
Received: by mproxy.gmail.com with SMTP id 77so4195046rnk
        for <linux-ide@vger.kernel.org>; Fri, 01 Oct 2004 07:25:05 -0700 (PDT)
In-Reply-To: <20041001123135.GO22627@home.fluff.org>
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-ide@fluff.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>

On Fri, 1 Oct 2004 13:31:35 +0100, Ben Dooks <ben-ide@fluff.org> wrote:
> On Tue, Sep 28, 2004 at 03:58:28PM +0100, Ben Dooks wrote:
> > Patch to provide support for the following two boards:
> >
> >       - Simtec BAST (EB2410ITX)
> >       - Thorcom VR1000
> >
> > Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> 
> Is the correct way to get an ide driver patch submitted
> to mail linux-ide@vger.kernel.org, or do I need to copy
> in other lists/people as well?

Correct way, please also cc: me.
(I see you did it a while ago).

It is all my fault, I will push it today to Linus.
Sorry for delay.

PS I need to remove bastide_exit() for now until IDE core
      is fixed to support removal of interfaces

Thanks,
Bartlomiej
