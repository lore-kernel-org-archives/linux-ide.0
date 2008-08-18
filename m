From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/5] ide debugging macros
Date: Mon, 18 Aug 2008 23:08:38 +0200
Message-ID: <200808182308.38345.bzolnier@gmail.com>
References: <1218993826-4571-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:52459 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYHRVL3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Aug 2008 17:11:29 -0400
Received: by mu-out-0910.google.com with SMTP id w8so3532965mue.1
        for <linux-ide@vger.kernel.org>; Mon, 18 Aug 2008 14:11:27 -0700 (PDT)
In-Reply-To: <1218993826-4571-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Sunday 17 August 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> here's something i've been wanting to do for a long time: debugging macros. The
> reason for it is that i got tired of adding debug printk's everytime i'm testing
> something so here we go.
> 
> The debugging macro is similar to the old ones but is one for all drivers
> (currently only ide-floppy), is nice on branch prediction and is controlled by a
> drive->debug_mask switch which is a module parameter and as such can be set at
> module load time, of course. I've been thinking of adding also a sysfs attribute
> too but can't seem to find quite the justification for it so no sysfs for now :)

if you look closely you should already find it :)

[ module parameters are exported through sysfs and it uses 0644 mask ]

> In addition, one can still optimize away all the debug calls in the old manner
> and i'm sure those will be removed completely too when ide generic conversion is
> done.
> 
> Please tell me what you think, what can be changed/improved and after we've
> figured out the details I'll do the other drivers too.

Looks pretty good to me (after quick look) and I applied to pata tree.

PS I wonder whether we may also want to have global debug_mask for core code
messages ('drive' is not always available) in the longer-term.  Or maybe even
only global debug_mask for both core code and driver messages?

Thanks,
Bart
