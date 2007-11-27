From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 6/8] libata: adjust speed down rules
Date: Tue, 27 Nov 2007 18:33:34 -0500
Message-ID: <474CA94E.9080603@rtr.ca>
References: <11961593392491-git-send-email-htejun@gmail.com> <11961593403415-git-send-email-htejun@gmail.com> <474C9B10.4060500@rtr.ca> <474CA31E.4000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2865 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbXK0Xdf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 18:33:35 -0500
In-Reply-To: <474CA31E.4000508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

Hi Tejun,

Tejun Heo wrote:
> Mark Lord wrote:
..
>> -- deliberate (or otherwise) errors via SG_IO will cause inappropriate
>> speed-downs.
> 
> No, only device errors issued via block layer are considered for speed
> down (ATA_QCFLAG_IO).  SG_IO commands will never trigger speed down
> unless the error is HSM or timeout.
..

Mmmm... what category is "device rejected the command" (ABRT) ?
Is that HSM ?

Cheers!
