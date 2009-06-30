From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/1] ide: memory overrun in ide_get_identity_ioctl() on
 big endian machines using ioctl HDIO_OBSOLETE_IDENTITY
Date: Mon, 29 Jun 2009 19:31:58 -0700 (PDT)
Message-ID: <20090629.193158.199209522.davem@davemloft.net>
References: <20090619084105.4cdf78be@frequentis.com>
	<20090621000423.30c462d9@frequentis.com>
	<200906221149.15575.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:52583
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753184AbZF3Cbw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jun 2009 22:31:52 -0400
In-Reply-To: <200906221149.15575.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: christian.engelmayer@frequentis.com, hancockrwd@gmail.com, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 22 Jun 2009 11:49:14 +0200

> On Sunday 21 June 2009 00:04:23 Christian Engelmayer wrote:
>> From: Christian Engelmayer <christian.engelmayer@frequentis.com>
>> 
>> This patch fixes a memory overrun in function ide_get_identity_ioctl() which
>> chooses the size of a memory buffer depending on the ioctl command that led
>> to the function call, however, passes that buffer to a function which needs the
>> buffer size to be always chosen unconditionally.
>> 
>> Due to conditional compilation the memory overrun can only happen on big endian
>> machines. The error can be triggered using ioctl HDIO_OBSOLETE_IDENTITY. Usage
>> of ioctl HDIO_GET_IDENTITY is safe.
>> 
>> Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied, thanks everyone.
