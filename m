From: Mark Lord <liml@rtr.ca>
Subject: Re: Fwd: Re: Performance figure for sx8 driver
Date: Sun, 12 Jun 2005 12:30:08 -0400
Message-ID: <42AC6310.7030809@rtr.ca>
References: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:19972 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262636AbVFLQaF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Jun 2005 12:30:05 -0400
In-Reply-To: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kallol@nucleodyne.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

kallol@nucleodyne.com wrote:
> 
> 
> Hello Jeff,
>            How did you verify that performance improved making the
> changes those
> you suggested?
> 
> hdparm does not show it.

My hdparm tool performs a single I/O at a time,
disregarding any kernel read-ahead that may be added on.

As such, it won't often show the effects of queued commands
as well as some other test might.

Cheers
