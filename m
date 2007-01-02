From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: implement HDIO_GET_IDENTITY
Date: Tue, 02 Jan 2007 12:47:20 -0500
Message-ID: <459A9AA8.5060808@rtr.ca>
References: <20070102111849.GD10987@htj.dyndns.org> <20070102111940.GE10987@htj.dyndns.org> <20070102112007.GF10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1871 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753662AbXABRrX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 12:47:23 -0500
In-Reply-To: <20070102112007.GF10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 'hdparm -I' doesn't work with ATAPI devices and sg_sat is not widely
> spread yet leaving no easy way to access ATAPI IDENTIFY data.
> Implement HDIO_GET_IDENTITY such that at least 'hdparm -i' works.

Mmm.. I still think this old ioctl is ugly, and I'd rather
have things fixed so that "hdparm -I" works instead.

Unless having access to the libata cached ID block is useful
beyond just getting ATAPI drives to work with -I.
Is it?  I suppose it might be useful to be able to look at it.

hdparm *does* try to issue the PACKET IDENTIFY whenever
a regular IDENTIFY fails.  Currently these all go through
the HDIO_DRIVE_CMD ioctl().  I don't have a system set up
here that has any ATAPI over libata to test with.
Could you perhaps try and see where that ioctl() is failing?

Thanks
