From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/8] libata: adjust speed down rules
Date: Wed, 28 Nov 2007 17:30:02 +0900
Message-ID: <474D270A.6030102@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com> <11961593403415-git-send-email-htejun@gmail.com> <474C9B10.4060500@rtr.ca> <474CA31E.4000508@gmail.com> <474CA94E.9080603@rtr.ca> <474CA9C4.9040902@gmail.com> <474CC017.3040305@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.226]:33184 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbXK1Ia2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 03:30:28 -0500
Received: by qb-out-0506.google.com with SMTP id e11so1520920qbe
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 00:30:26 -0800 (PST)
In-Reply-To: <474CC017.3040305@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello, Mark.

Mark Lord wrote:
> Last question:  what about CD/DVD writers?
> 
> Are the data-out commands for those done via block, or via SG_IO ?
> (my memory fails me here).
> 
> Do they ever get speed up/down based on WRITE errors ?

That depends on how the writing commands are issued.  If the commands
are issued via SG_IO (which is the case for wodim and probably for
others too), it won't affect speed down.  If the commands are issued by
writing to /dev/sr0, it will.

Thanks.

-- 
tejun
