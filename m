From: ejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2 2/2] pata_arasan_cf: Adding support for arasan
 compact flash host controller
Date: Fri, 18 Feb 2011 18:20:52 +0100
Message-ID: <20110218172052.GT21209@htj.dyndns.org>
References: <cover.1298029161.git.viresh.kumar@st.com>
 <e2f140271f9db752fdc05e348065b23fc4e4aa29.1298029161.git.viresh.kumar@st.com>
 <20110218143438.GK21209@htj.dyndns.org>
 <AANLkTi=bK54_OEFh=Fhx9N8TxVcFxUFYJm8XS=MKZdG2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54208 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab1BRRU5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 12:20:57 -0500
Received: by bwz15 with SMTP id 15so932104bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2011 09:20:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=bK54_OEFh=Fhx9N8TxVcFxUFYJm8XS=MKZdG2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.linux@gmail.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, shiraz.hashim@st.com, armando.visconti@st.com, amit.goel@st.com

Hello,

On Fri, Feb 18, 2011 at 10:28:51PM +0530, viresh kumar wrote:
> > Hmmm... so, now there's a work item which requeues itself.  That can't
> > be reliably stopped from freeze() as it's called with host lock held
> > without process context.  I think you should override
> > ->error_handler() which looks like the following,
> 
> actually i am disabling controller in freeze. After which we will
> surely get timeout here and
> so finally we will get an error in this work. Wouldn't that be enough?

Hmmm... libata usually invokes EH right away after freeze().  It'll
abort everything in flight and wake up the EH.  freeze()'s job is to
_try_ to quiesce the controller until reset and used when libata isn't
sure which state the port is in, so I think you would still need to
kill the work items on entry to EH.  BTW, have you tested the EH
paths?  Inducing fake failures from interrupt handler and let things
just slide so that timeout happens should do the trick.

Thanks.

-- 
tejun
