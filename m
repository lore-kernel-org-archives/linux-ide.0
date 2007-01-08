From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: implement HDIO_GET_IDENTITY
Date: Sun, 07 Jan 2007 21:29:02 -0500
Message-ID: <45A1AC6E.40704@pobox.com>
References: <20070102111849.GD10987@htj.dyndns.org> <20070102111940.GE10987@htj.dyndns.org> <20070102112007.GF10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51681 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030381AbXAHC3F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Jan 2007 21:29:05 -0500
In-Reply-To: <20070102112007.GF10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 'hdparm -I' doesn't work with ATAPI devices and sg_sat is not widely
> spread yet leaving no easy way to access ATAPI IDENTIFY data.
> Implement HDIO_GET_IDENTITY such that at least 'hdparm -i' works.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Are you certain this works for both big-endian and little-endian?

A quick "it works" test by somebody on sata_svw (ppc64) or another 
big-endian platform would be nice.

	Jeff



