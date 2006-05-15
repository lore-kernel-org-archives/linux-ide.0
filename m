From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Mon, 15 May 2006 15:15:09 -0400
Message-ID: <4468D33D.3070504@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:28615 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965187AbWEOTPL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 15:15:11 -0400
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

Also, a re-reminder:

At some convenient point, I'm going to move libata core and drivers to 
new directory drivers/ata.

The other noticeable change coming down the pipe is iomap support, which 
will kill those annoying warnings you see on every build (in addition to 
shrinking the driver a bit).

Speak up now if there are complaints...

	Jeff



