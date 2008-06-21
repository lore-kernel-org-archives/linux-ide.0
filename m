From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide: filter out invalid transfer mode values in set_xfer_rate()
Date: Sat, 21 Jun 2008 21:57:42 +0200
Message-ID: <200806212157.42772.bzolnier@gmail.com>
References: <200806212120.41514.bzolnier@gmail.com> <485D589B.5030105@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:27964 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYFUT4P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Jun 2008 15:56:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6240339rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 21 Jun 2008 12:56:14 -0700 (PDT)
In-Reply-To: <485D589B.5030105@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 21 June 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> > Filter out invalid transfer mode values (0x02-0x07) in write handler
> > for obsoleted /proc/ide/hd?/settings:current_speed setting.
> >
> > While at it:
> >
> > * Use XFER_UDMA_6 define.
> >
> > Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > Sergei, IIRC that it is what you were suggesting some time ago.
> >   
> 
>    Maybe I did. :-) But I don't see what that gives to us now...

One free IDE_HFLAG_ host flag (in patch #4/4)!! :)

[ I just went through backlog of lower-prio TODO items. ]
