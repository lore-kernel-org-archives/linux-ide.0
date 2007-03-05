From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Tue, 06 Mar 2007 00:45:00 +0900
Message-ID: <45EC3AFC.1050101@gmail.com>
References: <00a001c75f0c$47f19750$4b00a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:8519 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbXCEPpC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Mar 2007 10:45:02 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1798187nze
        for <linux-ide@vger.kernel.org>; Mon, 05 Mar 2007 07:45:01 -0800 (PST)
In-Reply-To: <00a001c75f0c$47f19750$4b00a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Jeff Garzik' <jeff@garzik.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Linus Torvalds' <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Paul Rolland wrote:
> Hello,
> 
>> Your drive has some issues with NCQ and is scheduled to be blacklisted
>> such that it isn't enabled.  libata used to ignore the 
>> condition but now
>> considers it NCQ protocol violation and fails all pending commands.
> 
> OK, do you need an hdparm report to fully identify the disk ?

Nope, we already know.

>> libata EH should turn NCQ off automatically after a few of the above
>> errors.  I'd love to see how that actually works in the field (full
>> dmesg please).  If it doesn't, it needs fixing.
> 
> I'll get you one tonite, I don't have access to the machine right now.

Great. Thanks.

-- 
tejun
