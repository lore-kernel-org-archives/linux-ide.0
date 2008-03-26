From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] libata: assume no device is attached
 if both IDENTIFYs are aborted
Date: Wed, 26 Mar 2008 10:05:48 -0400
Message-ID: <47EA583C.8070501@rtr.ca>
References: <47E5F5D5.6050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4476 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbYCZOFu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Mar 2008 10:05:50 -0400
In-Reply-To: <47E5F5D5.6050203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, jb.faq@gmx.de, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
..
> Modify EH such that it assumes no device is attached if both flavors
> of IDENTIFY are aborted by the device.  There really isn't much point
> in retrying when the device actively aborts the commands.
..

And thus dies support for the few very early IDE drives that lacked IDENTIFY.

R.I.P.  :)

(not that they would have worked with libata in the first place)

Acked-by: Mark Lord <mlord@pobox.com>
