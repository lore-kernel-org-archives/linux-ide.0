From: Mark Lord <liml@rtr.ca>
Subject: Re: [patch] libata: fix last_ctl caching in ata_tf_read()
Date: Mon, 16 Jul 2007 19:13:16 -0400
Message-ID: <469BFB8C.6040709@rtr.ca>
References: <469BBA76.5000901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1379 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbXGPXNR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jul 2007 19:13:17 -0400
In-Reply-To: <469BBA76.5000901@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Chuck Ebbert wrote:
> libata: fix last_ctl caching in ata_tf_read()
...
> +		ap->last_ctl = tf_ctl | ATA_HOB;

That line should be:
  +		ap->last_ctl = tf->ctl | ATA_HOB;

Chuck: please fix that line, *test-compile* it,
and submit again.

Thanks.
