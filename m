From: Mark Lord <liml@rtr.ca>
Subject: Re: what is hdparm doing?
Date: Tue, 28 Feb 2006 23:18:29 -0500
Message-ID: <44052095.8070607@rtr.ca>
References: <E1FED6T-0004a4-LN@highlab.com> <4404F89C.8040008@rtr.ca> <E1FEHuv-0004mb-VL@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:15337 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751491AbWCAESe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 23:18:34 -0500
In-Reply-To: <E1FEHuv-0004mb-VL@highlab.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Kuzminsky <seb@highlab.com>
Cc: linux-ide@vger.kernel.org

Sebastian Kuzminsky wrote:
 >
> So how do I know what PIO mode the drive wants to use?
> 
> And how do I tell the HBA what PIO mode to use?
> 

You don't do either of those.
The device driver takes care of it, if needed.

In this case, they were both likely set up for PIO4.

Cheers
