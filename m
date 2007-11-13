From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] cmd64x: don't clear the other channels interrupt
Date: Tue, 13 Nov 2007 21:58:36 +0100
Message-ID: <200711132158.36205.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200711091407.01369.sshtylyov@ru.mvista.com> <200711112252.58538.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:21942 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758493AbXKMVHd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 16:07:33 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1936016mue
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 13:07:31 -0800 (PST)
In-Reply-To: <200711112252.58538.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, marogge@onlinehome.de, milon@wq.cz

On Sunday 11 November 2007, Bartlomiej Zolnierkiewicz wrote:
> On Friday 09 November 2007, Sergei Shtylyov wrote:
> > Make sure to not clear the other IDE channel's interrupt when clearing an IDE
> > interrupt via the MRDMODE register.
> > 
> > Thanks to Bart for finding a coding mistake.
> 
> Could you resend with "Signed-off-by:" and "Tested-by:" tags?
> 
> [ A reference to the problematic commit and crediting Martin for
>   patiently bisecting the issue would score an extra points. :) ]

Well, I dealt with it myself and just added "From:" (together
with "Tested-by:"-s and an enhanced patch description)...

For the future please always run your patches through
scripts/checkpatch.pl before posting, this prevents missing
"Signed-off-by:" (and few other issues :).

Thanks,
Bart
