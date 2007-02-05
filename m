From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Mon, 05 Feb 2007 12:29:18 -0500
Message-ID: <45C7696E.3000907@rtr.ca>
References: <752079.2468.qm@web801.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1816 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbXBER3U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Feb 2007 12:29:20 -0500
In-Reply-To: <752079.2468.qm@web801.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Stewart <bob@evoria.net>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Bob Stewart wrote:
> By the way, 
> the drive I'm using to play with this now is only an 80GB drive.

Most newer drives are still capable of LBA48, even when they are
small enough to not require it for sector addressing.

If a large enough I/O (more than 256 sectors) is generated,
then libata may use LBA48 to complete a request on such drives.

Cheers
