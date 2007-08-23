From: Neil Romig <neil@romig.demon.co.uk>
Subject: Re: File corruption in 2.6.18 thru 2.6.22
Date: Thu, 23 Aug 2007 20:12:31 +0000
Message-ID: <46CDEA2F.6040508@romig.demon.co.uk>
References: <46C70565.1040308@romig.demon.co.uk> <20070823001634.GC18739@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:1524 "EHLO
	anchor-post-31.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752307AbXHWTM0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2007 15:12:26 -0400
In-Reply-To: <20070823001634.GC18739@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-ide@vger.kernel.org

Dave Jones wrote:
> On Sat, Aug 18, 2007 at 02:42:45PM +0000, Neil Romig wrote:
>  
>  > Everything is O.K using kernel 2.6.17.14, but 2.6.18 and beyond all have
>  > this problem. It may take me months to sort this out on my own - any
>  > suggestions?
> 
> In most (though not all), a single bit was flipped.
> This is usually a sign of bad memory.
> Give it a going over with memtest86+ ?
> 
> 	Dave
> 

I have run memtest86+ twice without error, so I remain stumped. I can set up a loop to copy
a file and do a diff which runs OK, but when I boot 2.6.18 it drops out within a second or two.

Neil.

