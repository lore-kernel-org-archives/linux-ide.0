From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk,
 take #3
Date: Thu, 14 Feb 2008 11:29:28 -0500
Message-ID: <47B46C68.6050904@rtr.ca>
References: <12028937731333-git-send-email-htejun@gmail.com> <20080213155701.48871761.akpm@linux-foundation.org> <47B38E13.1060503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3374 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbYBNQ33 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 11:29:29 -0500
In-Reply-To: <47B38E13.1060503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, jeff@garzik.org, linux-ide@vger.kernel.org, jengelh@computergmbh.de, matthew@wil.cx, randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, linux-kernel@vger.kernel.org

Tejun Heo wrote:
>..
> * For timeouts, result TF isn't available and thus res printout is
> misleading.  res shouldn't be printed after timeouts.  This would
> require allocating yest another temp buf and separating out res printing
> into separate snprintf.
..

And snprintf() is buggy, by the way.  It does not always seem to return
the correct character fill counts.  I've given up trying to use it here
for anything in kernelspace that *must* work.

Someday I'll go back and try to figure out where it's screwing up.
I think it is doing so in the cases where it runs out of space in the buffer.

-ml
