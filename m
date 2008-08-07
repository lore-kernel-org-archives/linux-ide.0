From: the4hoffmans@earthlink.net
Subject: Re: Issue with AHCI driver
Date: Thu, 7 Aug 2008 16:51:08 -0400 (EDT)
Message-ID: <28378004.1218142268823.JavaMail.root@elwamui-karabash.atl.sa.earthlink.net>
Reply-To: the4hoffmans@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:46160 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752858AbYHGUvR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Aug 2008 16:51:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com

Tejun -

2 questions:

1) We're currently attempting to get Fedora 2.6.25-14 build running.  Is that going to have the class code matching?  If not, then when we get it going we'll update to 2.6.26.2

2) Why didn't 2.6.19 work when we added our vendor/device id to ahci.c?  Is there somewhere else that the id needs to be added?

thank you!

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

