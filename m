From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BK PATCHES] ide-dev-2.6 update
Date: Sat, 22 Jan 2005 00:00:35 +0100
Message-ID: <58cb370e05012115003865ce18@mail.gmail.com>
References: <58cb370e0501211202372c9b1b@mail.gmail.com>
	 <20050121221308.GA3321@kroah.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:9081 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262561AbVAUXAh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2005 18:00:37 -0500
Received: by wproxy.gmail.com with SMTP id 58so52547wri
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2005 15:00:35 -0800 (PST)
In-Reply-To: <20050121221308.GA3321@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Fri, 21 Jan 2005 14:13:08 -0800, Greg KH <greg@kroah.com> wrote:
> On Fri, Jan 21, 2005 at 09:02:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > ide-dev-2.6 tree has been resurrected.  It now contains first bunch
> > of fixes needed for converting IDE device drivers to driver-model.
> 
> Yeah!
> 
> > NOTE: If you have a local copy of the tree please re-clone it, thanks.
> >
> > BK users:
> >
> >       bk pull bk://bart.bkbits.net/ide-dev-2.6
> 
> Hm, have a patch anywhere that people can look at?

I sent patches to linux-ide (since they are highly IDE specific and I
don't want to
spam LKML too much) some time ago but since they are not that big I will resend
them here...

[ I don't make patch versions of ide-dev because it is pulled into -mm ]

Bartlomiej
