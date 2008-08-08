From: the4hoffmans@earthlink.net
Subject: Re: Issue with AHCI driver
Date: Fri, 8 Aug 2008 16:41:43 -0400 (EDT)
Message-ID: <1592636.1218228104177.JavaMail.root@elwamui-wigeon.atl.sa.earthlink.net>
Reply-To: the4hoffmans@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-spurfowl.atl.sa.earthlink.net ([209.86.89.66]:39227
	"EHLO elasmtp-spurfowl.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752036AbYHHUlw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 16:41:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com

Update:

We got Fedora 2.6.25-14 build running.  It recognizes our card.  It identifies our device but at some point after that we die.  Using an analyzer we found that the problem is due to a buffer alignment issue.

Our card is a prototype and currently under development.  It currently only supports memory buffers that are quadword aligned.  We are dying because we get a buffer for a subsequent identify command that is on a dword boundary.  That is the problem we need to solve next.

We know we need to change our hardware and we will do that.  However, is there a way during driver init to specify quadword buffer alignment so we can continue our testing with Linux?

Thanks again for all your help - we really appreciate it.
Bob H.

-----Original Message-----
>From: Tejun Heo <tj@kernel.org>
>Sent: Aug 6, 2008 7:15 PM
>To: the4hoffmans@earthlink.net
>Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com
>Subject: Re: Issue with AHCI driver
>
>the4hoffmans@earthlink.net wrote:
>> which would you recommend?  We tried 2.6.24.7 and saw problems...
>
>The latest one 2.6.26.2.  Hmmm.. IIRC 2.6.24.7 should have the class
>code matching tho.  Anyways, please give a shot at 2.6.26.2.
>
>-- 
>tejun

