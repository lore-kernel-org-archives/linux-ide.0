From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (2.6.20-rc4-mm1) pdc202xx_old: fix PIO mode setup
Date: Fri, 02 Feb 2007 22:16:30 +0100
Message-ID: <45C3AA2E.4000508@gmail.com>
References: <200701192337.52502.sshtylyov@ru.mvista.com> <58cb370e0702021216r7e475673i1cdcd6809a1fa451@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:3508 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946086AbXBBVLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 16:11:40 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1365181nfa
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 13:11:39 -0800 (PST)
In-Reply-To: <58cb370e0702021216r7e475673i1cdcd6809a1fa451@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, akpm@osdl.org
Cc: linux-ide@vger.kernel.org


Sergei Shtylyov wrote:
> Fix the driver's tuneproc() method to always set the PIO mode requested and not
> pick the best possible one, rename it to pdc202xx_tune_drive(), and change the
> calls to it accordingly; remove the preceding comment which has nothing to do
> with the code.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied

