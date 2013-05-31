From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: increase retry count but shorten duration for
 Calxeda controller
Date: Fri, 31 May 2013 16:40:17 +0900
Message-ID: <20130531074017.GC16809@mtj.dyndns.org>
References: <1369923509-3246-1-git-send-email-mark.langsdorf@calxeda.com>
 <51A76197.9080708@calxeda.com>
 <51A7646B.6080203@cogentembedded.com>
 <51A848F1.3040301@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:35572 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab3EaHkV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 May 2013 03:40:21 -0400
Content-Disposition: inline
In-Reply-To: <51A848F1.3040301@ladisch.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Timur Tabi <timur.tabi@calxeda.com>, Mark Langsdorf <mark.langsdorf@calxeda.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, May 31, 2013 at 08:53:37AM +0200, Clemens Ladisch wrote:
> Sergei Shtylyov wrote:
> > On 30-05-2013 18:26, Timur Tabi wrote:
> >>> +    const unsigned long timing[] = { 5, 100, 500};
> >
> >> You'll save space and time if you also make this array "static",
> >> otherwise the compiler will build the array every time this function is
> >> called.
> >
> > No, *const* specifier is enough to not build this array every time. It will be put into the .const section.
> 
> gcc disagrees:

Doesn't really matter this or that way but let's do static const as,
more than anything else, that's what other places are doing.

Thanks.

-- 
tejun
