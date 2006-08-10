From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 10 Aug 2006 02:13:51 -0400
Message-ID: <44DACE9F.3090909@garzik.org>
References: <1155144599.5729.226.camel@localhost.localdomain> <44DA4288.6020806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:14801 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161063AbWHJGN5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 02:13:57 -0400
In-Reply-To: <44DA4288.6020806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Mark Lord wrote:
> This will also allow time for things like "udev" to perhaps think about
> an option to someday provide /dev/hd* symlinks for PATA devices when
> libata is used instead of IDE (?).  That might be a possible migration
> path in the far future.

Unfortunately a symlink won't work because of compatibility issues. 
/dev/hd supports more partitions, and a different set of ioctls.

	Jeff


