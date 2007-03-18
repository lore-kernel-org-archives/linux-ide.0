From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Sun, 18 Mar 2007 19:39:31 +0900
Message-ID: <45FD16E3.4090509@gmail.com>
References: <00e801c76948$da7f0df0$2101a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:8919 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbXCRKjh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 06:39:37 -0400
Received: by nz-out-0506.google.com with SMTP id s1so475444nze
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 03:39:36 -0700 (PDT)
In-Reply-To: <00e801c76948$da7f0df0$2101a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Paul Rolland wrote:
> Hello,
> 
>> Yeap, more than three HSM violations in ten minutes.  That's the
>> criteria for turning off NCQ.  Good to see it working.  It look like a
>> lot because libata reports all active commands (can't help as on HSM
>> failure, there's no way to determine which caused it) and the SCSI
>> prints revalidation messages, but it's still only three errors.
>>
>> Thanks for verifying that.  I wanted to verify it works in 
>> the field as expected.
> 
> Glad to help !
> 
> Anyhow, how should I consider these "errors" ? Are they real failure that
> can affect data integrity on the disk, or some kind of "protocol" errors
> with the disk, that are covered by soft (retry or so), and don't affect
> data ?

This is NCQ protocol violation on the drive's side shown on some early
drives.  No need to worry too much about it.  The drive will just get
blacklisted for NCQ and should work fine.

-- 
tejun
