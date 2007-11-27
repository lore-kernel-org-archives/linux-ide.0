From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/8] libata: adjust speed down rules
Date: Wed, 28 Nov 2007 08:07:10 +0900
Message-ID: <474CA31E.4000508@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com> <11961593403415-git-send-email-htejun@gmail.com> <474C9B10.4060500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.249]:47720 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759543AbXK0XHS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 18:07:18 -0500
Received: by ag-out-0708.google.com with SMTP id 35so1533193aga
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 15:07:17 -0800 (PST)
In-Reply-To: <474C9B10.4060500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello, Mark.

Mark Lord wrote:
> Tejun Heo wrote:
>> Speed down rules were too conservative.  Adjust them a bit.
>>
>> * More than 10 timeouts can't happen in 5 minutes as command timeout
>>   is 30secs.  Lower the limit for rule #1 to 6.
>>
>> * 10 timeouts is too high for rule #3 too.  Lower it to 6.
>>
>> * SATAPI can benefit from falling back to PIO too.  Allow SATAPI
>>   devices to fall back to PIO.
> ..
> 
> Mmmm...  I see two remaining problems with this:
> 
> -- bad sectors (media errors) will cause inappropriate speed-downs.

No.  Media error is category 0 error which doesn't affect speed down at all.

> -- deliberate (or otherwise) errors via SG_IO will cause inappropriate
> speed-downs.

No, only device errors issued via block layer are considered for speed
down (ATA_QCFLAG_IO).  SG_IO commands will never trigger speed down
unless the error is HSM or timeout.

Thanks.

-- 
tejun
