From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_arasan_cf: Adding support for arasan compact
 flash host controller
Date: Fri, 18 Feb 2011 10:14:25 +0100
Message-ID: <20110218091425.GB21209@htj.dyndns.org>
References: <0f2a633873dd2fa187afd7feef9fd71daa545b84.1297942328.git.viresh.kumar@st.com>
 <20110217145235.GY19830@htj.dyndns.org>
 <4D5DF816.4010907@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34938 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677Ab1BRJOq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 04:14:46 -0500
Received: by fxm20 with SMTP id 20so3553868fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2011 01:14:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5DF816.4010907@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, amitgoel <amit.goel@st.com>, Armando VISCONTI <armando.visconti@st.com>, jgarzik@pobox.com, viresh kumar <viresh.linux@gmail.com>

Hello,

On Fri, Feb 18, 2011 at 10:09:50AM +0530, viresh kumar wrote:
> > Hmm... the controller doesn't really have BMDMA, right?  Is there any
> > reason to emulate BMDMA behavior?  Why not just override qc_issue?  Do
> > some parts behave like standard BMDMA?
> > 
> 
> No. It doesn't have BMDMA. I just wanted to use existing framework and
> routines. And i wasn't sure if just overriding qc_issue alone will be enough.
> Should i keep it as it is or modify?

I see.  Yeah, if the hardware doesn't really behave like a BMDMA
controller (and the fact that you need to override every bmdma ops is
a good indication of that), it usually is much cleaner to inherit from
sff and implement DMA part in the driver proper.  There are several
drivers like that in the tree.

> > It might be better to create a wrapper at the top so that you don't
> > have to do #ifdeffery many times?
> > 
> 
> Actually there are different routines to call, clk_enable, clk_disable, clk_get, 
> clk_put, struct clk *clk.
> 
> And i am not getting how to create a single macro to suit all these routines.

I see.  I was suggesting something like,

#ifdef CONFIG_BLAHBLAH
# define arasan_clk_enable(...)	clk_enable(...)
...
#else
# define arasan_clk_enable(...) do {} while (0)
...
#endif

which usually is preferred over scattering #ifdef across the source
file but if there are many different routines it might not be worth
it.

> >> diff --git a/drivers/ata/pata_arasan_cf.h b/drivers/ata/pata_arasan_cf.h
> >> diff --git a/include/linux/pata_arasan_cf_data.h b/include/linux/pata_arasan_cf_data.h
> > 
> > Why do these header files needed?  Unless the driver is gonna be put
> > in multiple .c files, there's no reason to separate out header files.
> > 
> 
> Ok. include/linux/pata_arasan_cf_data.h is surely required as it will be
> used by platforms also. I kept register macros in a separate file to keep .c
> clean. I will merge drivers/ata/pata_arasan_cf.h in .c, if you want me to.

Yes, please.

Thank you.

-- 
tejun
