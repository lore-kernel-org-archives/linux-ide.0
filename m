From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/2] pata_atiixp: update port enabledness
 test handling
Date: Mon, 02 Feb 2009 23:10:00 -0500
Message-ID: <4987C398.50709@garzik.org>
References: <497028CF.7030408@kernel.org> <4984FB99.6000704@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56033 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbZBCEKD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 23:10:03 -0500
In-Reply-To: <4984FB99.6000704@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, bugsbuggy@ymail.com

Tejun Heo wrote:
> Tejun Heo wrote:
>> Port enabledness test fits much better into init_one() instead of
>> pre_reset().  The reason why these tests are in pre_reset() is purely
>> historical at this point.  Move it to init_one().  This will help
>> further changes.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Jeff, the second one turned out to be unnecessary but this patch is
> worthy on its own.  Can you please put

You mean upstream commit 16028232bf6dc5ed7e4bd341ef335f386229ad0b ?

	Jeff



