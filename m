From: Mark Lord <liml@rtr.ca>
Subject: Re: [RFC] libata: add MODE_SENSE(6) emulation?
Date: Mon, 16 May 2005 09:21:34 -0400
Message-ID: <42889E5E.8020003@rtr.ca>
References: <425393DB.3010702@tw.ibm.com> <42880592.40402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:7691 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261611AbVEPNVg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 May 2005 09:21:36 -0400
In-Reply-To: <42880592.40402@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

One thing that should get added to libata
is the ability to issue READ_BUFFER_CAPACITY (5C)
during write operations to CD/DVD-RW.

That way, userland apps can show the buffer usage
and adapt data transmission to match etc..

Just like they do today with ide-scsi.

Or is this already there?

Cheers
