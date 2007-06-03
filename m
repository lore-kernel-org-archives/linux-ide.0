From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA hotswap and write caches
Date: Sun, 03 Jun 2007 10:24:38 -0400
Message-ID: <4662CF26.6060902@garzik.org>
References: <20070603104334.GH18680@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37830 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbXFCOYl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jun 2007 10:24:41 -0400
In-Reply-To: <20070603104334.GH18680@zoy.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michel Lespinasse <walken@zoy.org>
Cc: linux-ide@vger.kernel.org

Michel Lespinasse wrote:
> * Is there anything one needs to know before hot-removing a drive ?

Make sure all data is flushed to the drive before removing it.


> * Does the kernel issue such cache flushing commands when executing
>   sync() or umount() operations ?

No.  (it should, IMO...)

	Jeff


