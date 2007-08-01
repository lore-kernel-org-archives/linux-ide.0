From: Tejun Heo <htejun@gmail.com>
Subject: Re: errors on shutdown with PMP
Date: Wed, 01 Aug 2007 12:46:37 +0900
Message-ID: <46B0021D.1080801@gmail.com>
References: <200707272153.l6RLrE5r007622@outgoing-alum.mit.edu> <46AAF12F.9020301@gmail.com> <200707310341.l6V3ex5r011162@outgoing-alum.mit.edu> <46AEBB71.9040003@gmail.com> <200707311623.l6VGNR5t017783@outgoing-alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:64967 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbXHADrs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 23:47:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so79009wah
        for <linux-ide@vger.kernel.org>; Tue, 31 Jul 2007 20:47:48 -0700 (PDT)
In-Reply-To: <200707311623.l6VGNR5t017783@outgoing-alum.mit.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bejarano <beej@alum.mit.edu>
Cc: linux-ide@vger.kernel.org

Hello,

Marc Bejarano wrote:
>>Counters don't look too friendly.  Do you happen to have another drive
>>of the same model?
> 
> about 100 or so of them ;)

Cool.

>>If so, can you post smartctl -a of the drive?
> 
> here are the other two drives in the unhappy lv:
[--snip--]
>   5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always
>      -       15
> 198 Offline_Uncorrectable   0x0010   100   100   000    Old_age  
> Offline      -       0
[--snip--]
>   5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always
>      -       0
> 198 Offline_Uncorrectable   0x0010   100   100   000    Old_age  
> Offline      -       0

Offline uncorrectable is zero on both drives.  I think it's likely that
the not-responding drive is faulty.  Note that write command usually
complete right after it fills the buffer, so write errors often show up
on cache flush.  Also, write failure usually means that even
reallocation failed and the drive is in pretty bad shape.

Thanks.

-- 
tejun
