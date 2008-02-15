From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata: fix sparse warning in libata.h
Date: Sat, 16 Feb 2008 07:18:54 +0900
Message-ID: <47B60FCE.80303@gmail.com>
References: <1203016578.2748.69.camel@brick>	 <20080215223250.0f229dbe@weinigel.se> <1203111692.15275.50.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:24809 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbYBOWTD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 17:19:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so607537rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 14:19:02 -0800 (PST)
In-Reply-To: <1203111692.15275.50.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Christer Weinigel <christer@weinigel.se>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
> Avoids lots of these, also is more readable.
> include/linux/libata.h:1210:13: warning: potentially expensive pointer subtraction
> 
> Change the subtraction to addition on the other side of the comparison.
> 
> Thanks to Christer Weinigel for the suggestion.
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
