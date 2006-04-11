From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] libata: prefix sata register print outs with 0x
Date: Tue, 11 Apr 2006 13:24:04 -0400
Message-ID: <443BE634.7060406@pobox.com>
References: <1144761989558-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:24965 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751041AbWDKRYM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 13:24:12 -0400
In-Reply-To: <1144761989558-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Prefix SStatus and SControl values with 0x as they are hex.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

NAK, libata always prints out device id, register, etc. values in hex. 
Basically anything other than things like sectors or bytes is printed in 
hex.  Therefore, the "0x" is largely redundant.

The prefix/base is implicit in the context.

	Jeff



