From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 20:55:04 +0300
Message-ID: <456C77F8.5020608@ru.mvista.com>
References: <20061114150454.GA11900@havoc.gtf.org> <Pine.LNX.4.64.0611280908320.4244@woody.osdl.org> <456C73D8.3050803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13700 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S935987AbWK1Rxc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 12:53:32 -0500
In-Reply-To: <456C73D8.3050803@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hello.

Mark Lord wrote:

> Bit #4, when actually implemented, is a rotational seek indicator,
> which can be used for timing purposes.

    Hm, I thought it was DSC (drive seek complete) set by the SEEK command 
completion, and it's always implemented. Didn't you mean IDX (bit 1, IIRC)?

> But when BUSY (bit #7) is set, the rest are generally nonsense.

    Indeed...

WBR, Sergei
