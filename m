From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement HDIO_GET_IDENTITY
Date: Wed, 03 Jan 2007 02:59:29 +0900
Message-ID: <459A9D81.8040904@gmail.com>
References: <20070102111849.GD10987@htj.dyndns.org> <20070102111940.GE10987@htj.dyndns.org> <20070102112007.GF10987@htj.dyndns.org> <459A9AA8.5060808@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:34394 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899AbXABR7l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 12:59:41 -0500
Received: by wx-out-0506.google.com with SMTP id h27so6152604wxd
        for <linux-ide@vger.kernel.org>; Tue, 02 Jan 2007 09:59:40 -0800 (PST)
In-Reply-To: <459A9AA8.5060808@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> 'hdparm -I' doesn't work with ATAPI devices and sg_sat is not widely
>> spread yet leaving no easy way to access ATAPI IDENTIFY data.
>> Implement HDIO_GET_IDENTITY such that at least 'hdparm -i' works.
> 
> Mmm.. I still think this old ioctl is ugly, and I'd rather
> have things fixed so that "hdparm -I" works instead.

Me agrees.  Please drop HDIO_GET_IDENTITY patch.

> Unless having access to the libata cached ID block is useful
> beyond just getting ATAPI drives to work with -I.
> Is it?  I suppose it might be useful to be able to look at it.

No, it's just to allow access to ATAPI IDENTIFY block.  libata does
pretty good job of keeping ID block in sync via revalidating, so they
should be the same.

> hdparm *does* try to issue the PACKET IDENTIFY whenever
> a regular IDENTIFY fails.  Currently these all go through
> the HDIO_DRIVE_CMD ioctl().  I don't have a system set up
> here that has any ATAPI over libata to test with.
> Could you perhaps try and see where that ioctl() is failing?

Ah.. Okay, so that's the second HDIO_DRIVE_CMD.  I'll test why the
second one is failing tomorrow.

-- 
tejun
