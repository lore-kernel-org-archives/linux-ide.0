From: Tejun Heo <tj@kernel.org>
Subject: Re: libata errors
Date: Sun, 12 Apr 2009 11:15:47 -0700
Message-ID: <49E22FD3.2010005@kernel.org>
References: <4b215b9d0904071340w16a65b5bs64f6161b6042b4f1@mail.gmail.com>	<49DBC889.3080304@pobox.com> <18908.23783.745239.601473@pilspetsen.it.uu.se> <49E0DAC0.1030901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49431 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbZDMJUA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 05:20:00 -0400
In-Reply-To: <49E0DAC0.1030901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jgarzik@pobox.com>, Matt Grice <mcjgrice@gmail.com>, linux-ide@vger.kernel.org

Hello,

Robert Hancock wrote:
> I tend to doubt that the driver is doing the wrong thing.

I've tested everything including recording and cd ripping and most of
my devices seem happy but you never know.

> I suspect it's more that ATAPI devices on SATA are about as
> standards-compliant in general as ATAPI devices on PATA (which is to
> say not very good) and some of them break if the controller does
> something slightly differently or with different timing, which is
> quite possible in AHCI mode.
> 
> Tejun was looking at some SATA analyzer traces of a few drives that were
> apparently failing consistently on AHCI. Tejun, did you get anywhere
> with this?

I need to take a deeper look at that but in general I couldn't find
anything standing out.  After a series of ATAPI changes (IIRC, the DMA
padding change was the last thing), most ATAPI bug reports got
resolved and I'm not getting many ATAPI failure bug reports other than
recent ahci ones anymore.  I'm not sure whethre it indicates that we
finally got it right or something else tho.

Jeff, what kind of failure are you seeing?

Thanks.

-- 
tejun

