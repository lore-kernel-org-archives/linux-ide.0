From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-eh not reporting failed LBA correctly?
Date: Wed, 23 Apr 2008 16:23:29 -0400
Message-ID: <480F9AC1.5080108@rtr.ca>
References: <480F95EC.6090303@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2514 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752243AbYDWUX2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 16:23:28 -0400
In-Reply-To: <480F95EC.6090303@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> ...
> Looking through libata-eh, I don't see any place that explicitly
> sets the result tf.flags field anywhere, other than copying them
> from the outgoing READ_LOG_EXT taskfile.  Perhaps that's the problem ?
...

Yup, that was it.  Patch coming after retest..
