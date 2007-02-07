From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) piix/slc90e66: more tuneproc() fixing
Date: Wed, 7 Feb 2007 02:47:22 +0100
Message-ID: <58cb370e0702061747u2bf64993ic5feab867f13d628@mail.gmail.com>
References: <200702062214.28136.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:4567 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965608AbXBGBrY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 20:47:24 -0500
Received: by nf-out-0910.google.com with SMTP id o25so365343nfa
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2007 17:47:23 -0800 (PST)
In-Reply-To: <200702062214.28136.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 2/6/07, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> The tuneproc() method in both these drivers failed to set the drive's own speed.
> Fix this by renaming the function and "wrapping around it" the new tuneproc()
> method.  While at it, convert the rest of the PIO setup code into proper C. :-)
>
> Warning: this has only been compile tested (but we are in the merge window
> already anyway :-).

I tested it quickly on ICH4.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
