From: the4hoffmans@earthlink.net
Subject: Re: Issue with AHCI driver
Date: Wed, 6 Aug 2008 08:17:42 -0500 (GMT-05:00)
Message-ID: <4163088.1218028662851.JavaMail.root@elwamui-darkeyed.atl.sa.earthlink.net>
Reply-To: the4hoffmans@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:43357 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753330AbYHFNRx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 09:17:53 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com

We have added our PCI ID - it didn't seem to make any difference - I'll try a later release

-----Original Message-----
>From: Tejun Heo <tj@kernel.org>
>Sent: Aug 5, 2008 6:10 PM
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

