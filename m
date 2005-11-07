From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: BUG: spinlock recursion on CPU#0, scsi_eh_3/737
Date: Mon, 07 Nov 2005 03:24:37 -0500
Message-ID: <436F0F45.5010907@pobox.com>
References: <20051107025428.GA2611@cs.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3789 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751313AbVKGIYq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2005 03:24:46 -0500
In-Reply-To: <20051107025428.GA2611@cs.utoronto.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Studholme <cvs@cs.utoronto.ca>
Cc: linux-ide@vger.kernel.org

Chris Studholme wrote:
> Hi,
> 
> I'm having the fillowing problem.
> 
> 
> [1.] One line summary of the problem:
> 
> BUG: spinlock recursion on CPU#0, scsi_eh_3/737

Can you verify that 2.6.14-git5+ fixes it?

	Jeff



