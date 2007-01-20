From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv HighPoint 2310 support (88SX7042)
Date: Fri, 19 Jan 2007 19:24:10 -0500
Message-ID: <45B1612A.40109@pobox.com>
References: <20070119003959.GA23298@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53830 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932810AbXATAYN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 19:24:13 -0500
In-Reply-To: <20070119003959.GA23298@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Olof Johansson wrote:
> Hi,
> 
> With the following patch, my HighPoint 2310 with a Marvell 88SX7042 on
> it seems to work OK.
> 
> The controller only has 4 ports, with MV_FLAG_DUAL_HC it seems to init 8
> ports and fails miserably at probe time. There are no other devices mapped
> to that chip, maybe it was just incorrectly specified in the first place?
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

The docs say 8-port.

Nonetheless, I will apply your patch, since working-in-the-field proof 
trumps docs on occasion (including this occasion).

We'll revisit if someone complains that their 7042 only sees 4 of 8 ports.

	Jeff



