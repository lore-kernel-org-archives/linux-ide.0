From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/14] libata: improve ATAPI draining
Date: Fri, 30 Nov 2007 01:09:27 +0900
Message-ID: <474EE437.4040103@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468192463-git-send-email-htejun@gmail.com> <20071129155956.4004ca89@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:25076 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbXK2QJj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:09:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1589648rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 08:09:38 -0800 (PST)
In-Reply-To: <20071129155956.4004ca89@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Albert Lee <albertcc@tw.ibm.com>

Alan Cox wrote:
>> * Limit the amount of draining to ATAPI_MAX_DRAIN (16k currently).
> 
> Why 16 not 64K ?
> 
> Please add a comment to note that the drivers assume
> - drain is only ever done on a stuck PIO xfer

No.  ATAPI draining is to accommodate buggy software and hardware and
it's for all misc ATAPI commands whether PIO or DMA.

> - drain occurs before any controller error/reset handling is done

This is part of normal command processing, not really related to EH.

Thanks.

-- 
tejun
