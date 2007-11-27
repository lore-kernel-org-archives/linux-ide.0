From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 6/8] libata: adjust speed down rules
Date: Wed, 28 Nov 2007 08:35:32 +0900
Message-ID: <474CA9C4.9040902@gmail.com>
References: <11961593392491-git-send-email-htejun@gmail.com> <11961593403415-git-send-email-htejun@gmail.com> <474C9B10.4060500@rtr.ca> <474CA31E.4000508@gmail.com> <474CA94E.9080603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.178]:33720 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757637AbXK0Xfk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 18:35:40 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2073776roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 15:35:38 -0800 (PST)
In-Reply-To: <474CA94E.9080603@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

Mark Lord wrote:
> Hi Tejun,
> 
> Tejun Heo wrote:
>> Mark Lord wrote:
> ..
>>> -- deliberate (or otherwise) errors via SG_IO will cause inappropriate
>>> speed-downs.
>>
>> No, only device errors issued via block layer are considered for speed
>> down (ATA_QCFLAG_IO).  SG_IO commands will never trigger speed down
>> unless the error is HSM or timeout.
> ..
> 
> Mmmm... what category is "device rejected the command" (ABRT) ?
> Is that HSM ?

Nope, that's UNK_DEV if the command is IO (came from block layer) and
cat-0 (don't care) if it has come from SG_IO.

-- 
tejun
