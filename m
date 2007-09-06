From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Fri, 07 Sep 2007 02:59:23 +0900
Message-ID: <46E03FFB.8020901@gmail.com>
References: <46D2595B.1030409@sauce.co.nz> <46D2792B.401@vc.cvut.cz> <46DBCCE9.9080806@gmail.com> <46DBDA84.3050505@vc.cvut.cz> <46DC030E.9070704@gmail.com> <46DCB709.902@vc.cvut.cz> <46DE9C20.9030007@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:3690 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177AbXIFSAs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 14:00:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so205196rvb
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 11:00:47 -0700 (PDT)
In-Reply-To: <46DE9C20.9030007@vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Richard Scobie <richard@sauce.co.nz>, linux-ide@vger.kernel.org

Petr Vandrovec wrote:
>>> Hmmmm.... Weird.  Is the different still there if you take PMP out of
>>> the picture?
>>
>> Will do tomorrow.  I need physical access to the box to do that.
> 
> Yes, no difference.  3512 is consistently about 1MBps faster than 3132
> when talking to single Hitachi 1TB drive.

Thanks for testing.  Don't have much idea why.  Maybe it's something
inherent to the 3132 hardware.  :-(

-- 
tejun
