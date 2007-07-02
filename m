From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes
 passed from user-space
Date: Mon, 02 Jul 2007 15:17:15 -0400
Message-ID: <46894F3B.7050600@garzik.org>
References: <200706302110.20766.bzolnier@gmail.com> <200707022041.08350.bzolnier@gmail.com> <46894478.9070808@garzik.org> <200707022055.13683.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53838 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326AbXGBTRS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 15:17:18 -0400
In-Reply-To: <200707022055.13683.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Add the new code inside #ifdef X86, marking alim15x3 X86-only would be
> on over-kill...

Ugh.  That's not how we do Linux development.  It is better to convert 
the new code and wait for alpha/sparc users to scream, than add platform 
ifdefs.  To do so creates divergent code paths, that runs counter to 
Linux's goal of a portable driver.

	Jeff


