From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Mon, 12 Mar 2007 17:04:55 +0900
Message-ID: <45F509A7.8030705@gmail.com>
References: <001b01c7647c$921ced00$4b00a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:24911 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965309AbXCLIEz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 04:04:55 -0400
Received: by an-out-0708.google.com with SMTP id b33so1345915ana
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 01:04:55 -0700 (PDT)
In-Reply-To: <001b01c7647c$921ced00$4b00a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Paul Rolland wrote:
>> I keep forgetting about this.  I'll ask SIMG how to deal with 
>> this.  For
>> the time being, connecting a device to the PMP port should remove the
>> timeouts.
> 
> That sounds a quite expensive solution ;)

You should be able to just move the drive attached at ata1 to ata2.
Please report whether that works.

-- 
tejun
