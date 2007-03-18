From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Sun, 18 Mar 2007 13:52:05 +0900
Message-ID: <45FCC575.4080902@gmail.com>
References: <00b901c768cf$fc359f00$2101a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:27538 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbXCREwM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 00:52:12 -0400
Received: by nz-out-0506.google.com with SMTP id s1so452619nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 21:52:11 -0700 (PDT)
In-Reply-To: <00b901c768cf$fc359f00$2101a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Paul Rolland wrote:
> Hello,
> 
>> The kernel says that NCQ is turned off due to excessive 
>> errors.  If your
>> HSM violation is intermittent, it might not trigger tho.
> 
> I've just grep'ed thru all my messages, and I can't find anything 
> stating that NCQ is being turned off...

Can you put the harddisk under high load and see what happens?  How
often do those errors occur?  Care to post full dmesg?

-- 
tejun
