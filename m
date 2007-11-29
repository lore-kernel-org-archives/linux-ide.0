From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/14] libata: make ->data_xfer return the number of
 consumed bytes
Date: Thu, 29 Nov 2007 15:55:46 +0000
Message-ID: <20071129155546.694c6c45@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468181417-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40394 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756740AbXK2QAc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:00:32 -0500
In-Reply-To: <11963468181417-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>

On Thu, 29 Nov 2007 23:33:28 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Depending on how many bytes are transferred as a unit, PIO data
> tranasfer may consume more bytes than requested.  Knowing how much
> data is consumed is necessary to determine how much is left for
> draining.  This patch update ->data_xfer such that it returns the
> number of consumed bytes.

Why do we care ? 

If the drive and controller disagree or the drive has gone off its
trolley all we actually care about is when the thing stops saying there
is data. In addition all our methods transfer the entire block they are
asked to each time.


Alan
