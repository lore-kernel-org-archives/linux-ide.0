From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Sun, 18 Mar 2007 05:02:05 +0900
Message-ID: <45FC493D.1060006@gmail.com>
References: <00b801c768cd$172dcb50$2101a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:26201 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbXCQUCK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 16:02:10 -0400
Received: by py-out-1112.google.com with SMTP id a29so172498pyi
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 13:02:10 -0700 (PDT)
In-Reply-To: <00b801c768cd$172dcb50$2101a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Paul Rolland wrote:
>> If you leave it alone, does libata turn off NCQ and boot continues?
> 
> boot continues, but I can't tell anything about libata turning of NCQ...
> I've had a bunch of them at some while while compiling some kernel, so it
> was quite some time after booting.
> 
> Is there a message I can check for that would indicate NCQ being turned
> off ?

The kernel says that NCQ is turned off due to excessive errors.  If your
HSM violation is intermittent, it might not trigger tho.

-- 
tejun
