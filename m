From: Anton Starikov <A.Starikov@utwente.nl>
Subject: Re: sata_promise pata connector
Date: Fri, 20 Aug 2004 06:07:53 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040820060753.5025d889@tncms14.tnw.utwente.nl>
References: <20040820031344.GB22682@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from utep.el.utwente.nl ([130.89.16.10]:32402 "EHLO
	utep.el.utwente.nl") by vger.kernel.org with ESMTP id S266905AbUHTEIZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Aug 2004 00:08:25 -0400
In-Reply-To: <20040820031344.GB22682@netnation.com>
List-Id: linux-ide@vger.kernel.org
To: Simon Kirby <sim@netnation.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I even wanted to port original driver from promise to 2.6 kernel...but
because at that time it was one of the moments when pata port "is coming
soon", I decided to not spent time for useless thing :)
Later my PATA drive which was connected  to this port has died , so I
have lost interest and migrate to 2.6 kernel without any problems :)

I don't know how it is going now, but...
I still can do it. 

Jeff, has it sense to port that damn driver finally or not?

Anton.


On Thu, 19 Aug 2004 20:13:44 -0700
Simon Kirby <sim@netnation.com> wrote:

> [ Resend as the last didn't seem to appear on the list... ]
> 
> I've seen it brought up a few times and I believe one email where you
> mention trying it -- what's involved in getting the PATA connector of
> certain Promise SATA chips working?  I'd be willing to hack, test, and
> help in general.
> 
> Thanks,
> 
> Simon-
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

On Thu, 19 Aug 2004 20:13:44 -0700
Simon Kirby <sim@netnation.com> wrote:

> [ Resend as the last didn't seem to appear on the list... ]
> 
> I've seen it brought up a few times and I believe one email where you
> mention trying it -- what's involved in getting the PATA connector of
> certain Promise SATA chips working?  I'd be willing to hack, test, and
> help in general.
> 
> Thanks,
> 
> Simon-
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
