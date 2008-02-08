From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream] libata: implement libata.force module parameter
Date: Fri, 08 Feb 2008 13:18:31 +0900
Message-ID: <47ABD817.2020903@gmail.com>
References: <47A3375F.80101@gmail.com> <47A356C3.3010904@garzik.org> <20080201183621.GC14759@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932708AbYBHLCU@vger.kernel.org>
In-Reply-To: <20080201183621.GC14759@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Sam Ravnborg wrote:
> I have lost the actual patch.
> But what you see is what happens when you mix const and non-const data
> in the same section.
> 
> Look for use of __initdata for const data and replace it with __initconst.
> 
> And modpost cannot warn about it as gcc errors out before we look at the
> .o file with modpost.

OIC, thanks.  Hmmm... in init.h, I see __{dev|cpu|mem}initconst but no
__initconst.  The data structure in question is used from module init
function tagged properly with __init.  What should be done here?


-- 
tejun
