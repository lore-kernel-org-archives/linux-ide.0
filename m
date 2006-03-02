From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: Re: sx8 driver
Date: Thu, 2 Mar 2006 16:40:45 +0200
Message-ID: <5d96567b0603020640w4a93a67bt7c5c8c3aaeb2c637@mail.gmail.com>
References: <5d96567b0603020622v5c846b0br6b634188bc14e68b@mail.gmail.com>
	 <440702BB.2000707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:62559 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750956AbWCBOkz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Mar 2006 09:40:55 -0500
Received: by wproxy.gmail.com with SMTP id i30so415759wra
        for <linux-ide@vger.kernel.org>; Thu, 02 Mar 2006 06:40:54 -0800 (PST)
In-Reply-To: <440702BB.2000707@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

it is in the promise we site. just google for it.
http://www.promise.com/support/download/download2_eng.asp?productID=125&category=all&os=100

On 3/2/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Raz Ben-Jehuda(caro) wrote:
> > had anyone here managed to compile sx8 ( carmel ) driver ?
> > i am failing to do so in  2.6.15 .
> >
> > make  -C /usr/kernels/linux-2.6.15 SUBDIRS=`pwd` modules
> >
> >
> > /usr/kernels/linux-2.6.15/drivers/scsi/hosts.h:1:2: warning: #warning
> > "This file is obsolete, please use <scsi/scsi_host.h> instead"
> > /usr/download/cml26x20050104_1.1.0.18/carmel.c:255: error: syntax
> > error before '*' token
>
> This driver does not exist in the kernel tree.  Where did you find it?
>
> You are looking for drivers/block/sx8.c which compiles just fine.
>
>         Jeff
>
>
>
>


--
Raz
