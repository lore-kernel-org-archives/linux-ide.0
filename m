From: Mark Lord <liml@rtr.ca>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 10:09:53 -0400
Message-ID: <4299CD31.8020805@rtr.ca>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:46861 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261324AbVE2OJz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 May 2005 10:09:55 -0400
In-Reply-To: <4299BD23.6010004@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

My basic hdparm timing test shouldn't show much of a difference
with NCQ tests, becase hdparm just does a single request at a time,
and waits for the results before issuing another.  Now, kernel read-ahead
may result in some command overlap and a slight throughput increase, but..

Something like dbench and/or bonnie++ are more appropriate here.

Cheers
