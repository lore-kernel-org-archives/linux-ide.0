From: Mark Lord <liml@rtr.ca>
Subject: Re: SATA150TX4 atat1:command timeout
Date: Thu, 13 Oct 2005 17:04:03 -0400
Message-ID: <434ECBC3.3020802@rtr.ca>
References: <VA.00001a56.00ccc058@foxhill.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:60369 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964805AbVJMVEA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Oct 2005 17:04:00 -0400
Received: from [10.0.0.14] (silvy.localnet [10.0.0.14])
	by mail.rtr.ca (Postfix) with ESMTP id 44D0C8302C8
	for <linux-ide@vger.kernel.org>; Thu, 13 Oct 2005 17:03:59 -0400 (EDT)
In-Reply-To: <VA.00001a56.00ccc058@foxhill.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ian Oliver wrote:
>
> For the record, this is with Ubuntu 5.04 (Hoary) with all repo updates 
> as of last weekend.

The Ubuntu-5.04 kernels have the libata EH bug, whereby the entire
machine locks up at random once in a blue-moon when EH is running.

On the machines here, this bug is most often triggered by simply
having an empty CD/DVD reader that is managed by libata -- polling for
disc insertion triggers the EH code every couple of seconds, leading
to random lockups.

Bug no longer present in newer kernels, but the Ubuntu-5.04 stock
kernels still have it.

Cheers
