From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Mon, 19 Mar 2007 16:55:25 +0900
Message-ID: <45FE41ED.20100@gmail.com>
References: <005501c769fa$ee402470$4b00a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:10570 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965790AbXCSHzc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 03:55:32 -0400
Received: by nz-out-0506.google.com with SMTP id s1so578329nze
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 00:55:31 -0700 (PDT)
In-Reply-To: <005501c769fa$ee402470$4b00a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Paul Rolland wrote:
>> Oh... that's just weird.  It seems you'll have to continue 
>> boot with the
>> timeouts for the time being.  Sorry about that.
> 
> Would you agree to a patch to add a kernel boot parameter to skip some
> ata ports ?
> I found some archives refering to some "ataX=noprobe", but it seems
> to have no effect, and I'd like to resurrect it for libata, at least to
> help me support my configuration ?
> If no, I'll just cook it for me, without posting it...

Why not cook it and share it?  :-)

-- 
tejun
