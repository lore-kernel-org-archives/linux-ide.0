From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: add softreset
Date: Tue, 28 Feb 2006 13:12:38 -0500
Message-ID: <44049296.10006@pobox.com>
References: <11396427632078-git-send-email-htejun@gmail.com> <43EE72D5.1050005@pobox.com> <20060215063659.GB9621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:13457 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932350AbWB1SMo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 13:12:44 -0500
In-Reply-To: <20060215063659.GB9621@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Now that libata is smart enought to handle both soft and hard resets,
> add softreset method.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, finally

(though I am dropping all your other pending patches as requested)


> +	/* spec says at least 5us, but be generous and sleep for 1ms */
> +	msleep(1);

FWIW msleep simply guarantees a minimum delay.  Depending on the 
scheduler tick granularity, msleep(1) may delay 10-100ms.

This FWIW may or may not warrant updating the above comment, I leave it 
up to you.

	Jeff


