From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-dev-2.6-ncq: remove qc->tag
Date: Sun, 26 Jun 2005 13:20:32 -0400
Message-ID: <42BEE3E0.2010601@pobox.com>
References: <20050626143002.GB24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3276 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261480AbVFZRUf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 13:20:35 -0400
In-Reply-To: <20050626143002.GB24968@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff.
>  Hello, Jens.
> 
>  This is the second patch of six misc updates to ncq.
> 
>  This patch removes redundant qc->tag field.  The value can be
> calculated from qc itself easily.
> 
>  Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK - qc->tag exists precisely to avoid calculating it over and over and 
over again.

