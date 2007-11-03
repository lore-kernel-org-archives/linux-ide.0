From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bart's efforts?
Date: Sat, 3 Nov 2007 16:19:04 +0000
Message-ID: <20071103161904.668c8ba7@the-village.bc.nu>
References: <87f94c370711030535r73846d45y2ef08a14ad94a78b@mail.gmail.com>
	<20071103141022.7a6c0209@the-village.bc.nu>
	<472C9624.104@ij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34519 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754008AbXKCQSA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Nov 2007 12:18:00 -0400
In-Reply-To: <472C9624.104@ij.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@ij.net>
Cc: linux-ide@vger.kernel.org

> > I don't think there is anything useful in old IDE that isn't in the new.
> 
> You mean besides being able to access all existing disk partitions? Google

Al Viro vetoed this support in the SCSI core. Take it up with him. The
libata layer is happy with lots of partitions but it needs a change for
sparse minors, or your distribution to use device mapper to do the work.

Alan
