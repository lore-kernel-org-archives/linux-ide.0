From: Jeff Garzik <jeff@garzik.org>
Subject: Re: IDE, packet commands and REQ_TYPE_SENSE?
Date: Thu, 02 Apr 2009 05:36:38 -0400
Message-ID: <49D48726.6040106@garzik.org>
References: <49D48600.2070109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35661 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761566AbZDBJgn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 05:36:43 -0400
In-Reply-To: <49D48600.2070109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> Can we get rid of REQ_TYPE_SENSE?

Strike that, I forgot about blk_sense_request()

