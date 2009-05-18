From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/6] drivers/ide Convert printk(KERN_<foo> to pr_<foo>(
Date: Mon, 18 May 2009 13:59:49 -0700
Message-ID: <1242680389.1572.127.camel@Joe-Laptop.home>
References: <cover.1242609803.git.joe@perches.com>
	 <200905181612.43632.bzolnier@gmail.com>
	 <1242661288.1572.82.camel@Joe-Laptop.home>
	 <1242662198.6347.14.camel@mulgrave.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:2020 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbZERU7w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 16:59:52 -0400
In-Reply-To: <1242662198.6347.14.camel@mulgrave.int.hansenpartnership.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Mon, 2009-05-18 at 15:56 +0000, James Bottomley wrote:
> What exactly is the point of a mechanical conversion from
> printk(KERN_ ...) to pr_...?
> 
> I can see the value of the pr_ macros from new code in that the
> temptation to put a comma after KERN_.. for some people is irresistible
> so it's an interface that's very easy to misuse, but given that we have
> correct uses, why convert them?

Enables easier conversion to dev_<foo> macros
Allows easier prefixing via pr_fmt
Puts back together unnecessarily chopped up format strings
Standardization is good
Just for the hell of it

cheers, Joe

