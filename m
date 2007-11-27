From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 6/8] libata: adjust speed down rules
Date: Tue, 27 Nov 2007 17:32:48 -0500
Message-ID: <474C9B10.4060500@rtr.ca>
References: <11961593392491-git-send-email-htejun@gmail.com> <11961593403415-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3612 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760017AbXK0Wcu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 17:32:50 -0500
In-Reply-To: <11961593403415-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

Tejun Heo wrote:
> Speed down rules were too conservative.  Adjust them a bit.
> 
> * More than 10 timeouts can't happen in 5 minutes as command timeout
>   is 30secs.  Lower the limit for rule #1 to 6.
> 
> * 10 timeouts is too high for rule #3 too.  Lower it to 6.
> 
> * SATAPI can benefit from falling back to PIO too.  Allow SATAPI
>   devices to fall back to PIO.
..

Mmmm...  I see two remaining problems with this:

-- bad sectors (media errors) will cause inappropriate speed-downs.
-- deliberate (or otherwise) errors via SG_IO will cause inappropriate speed-downs.

Right?
