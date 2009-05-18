From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/6] drivers/ide Convert printk(KERN_<foo> to pr_<foo>(
Date: Mon, 18 May 2009 14:21:48 -0700
Message-ID: <1242681709.1572.135.camel@Joe-Laptop.home>
References: <cover.1242609803.git.joe@perches.com>
	 <200905181612.43632.bzolnier@gmail.com>
	 <1242661288.1572.82.camel@Joe-Laptop.home>
	 <1242662198.6347.14.camel@mulgrave.int.hansenpartnership.com>
	 <1242680389.1572.127.camel@Joe-Laptop.home>
	 <1242681328.6347.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:2051 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbZERVVw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 17:21:52 -0400
In-Reply-To: <1242681328.6347.38.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Mon, 2009-05-18 at 21:15 +0000, James Bottomley wrote:
> it's not good for the stability of the code base and
> it can cause problems with subsidiary committers by generating
> unnecessary patch rejections due to code churn.

Bart can decide, coordinate and mitigate.
He's the one that asked for it.
http://lkml.org/lkml/2009/5/17/127

cheers, Joe

