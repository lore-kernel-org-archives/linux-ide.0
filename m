From: the4hoffmans@earthlink.net
Subject: Re: Issue with AHCI driver
Date: Wed, 6 Aug 2008 12:59:14 -0400 (EDT)
Message-ID: <12755613.1218041955162.JavaMail.root@elwamui-darkeyed.atl.sa.earthlink.net>
Reply-To: the4hoffmans@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:34309 "EHLO
	elasmtp-banded.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752869AbYHFQ7q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 12:59:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com

which would you recommend?  We tried 2.6.24.7 and saw problems...

-----Original Message-----
>From: Tejun Heo <tj@kernel.org>
>Sent: Aug 5, 2008 7:10 PM
>To: the4hoffmans@earthlink.net
>Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com
>Subject: Re: Issue with AHCI driver
>
>the4hoffmans@earthlink.net wrote:
>> Here's a file with more data...
>
>Eeek... the kernel is 2.6.19 which didn't contain the AHCI class code
>matching.  Can you please try newer one?  For 2.6.19, you'll need to add
>your PCI ID.
>
>-- 
>tejun

