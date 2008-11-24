From: Tejun Heo <tj@kernel.org>
Subject: Re: unexpected downspeed of AHCI controller on Intel  Seaburg 5400
Date: Mon, 24 Nov 2008 14:40:17 +0900
Message-ID: <492A3E41.7020109@kernel.org>
References: <6.2.5.6.2.20081118154009.01c8a2d0@binnacle.cx> <4923743A.2050903@shaw.ca> <6.2.5.6.2.20081118210621.01d6c680@binnacle.cx> <492A3912.3060305@kernel.org> <6.2.5.6.2.20081124002812.01ca7788@binnacle.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45485 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbYKXFkY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 00:40:24 -0500
In-Reply-To: <6.2.5.6.2.20081124002812.01ca7788@binnacle.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: starlight@binnacle.cx
Cc: linux-ide@vger.kernel.org

starlight@binnacle.cx wrote:
> Thank you for explaining how it works.  Have resigned to living 
> with 1.5G.  A reason exists to run the ES.2s at their full 
> sequential 100 Mbytes/sec (800 Mbits/sec), and I had hoped that 
> lowering the latency on the link might squeeze a bit more 
> performance.  But 1.5 is good enough.

Considering general disk operation speed and the parallel operation
achieved using NCQ, I don't think it will make any noticeable difference.

Thanks.

-- 
tejun
