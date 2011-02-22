From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH V2 2/2] pata_arasan_cf: Adding support for arasan compact
 flash host controller
Date: Tue, 22 Feb 2011 12:33:18 +0530
Message-ID: <4D635FB6.40804@st.com>
References: <cover.1298029161.git.viresh.kumar@st.com> <e2f140271f9db752fdc05e348065b23fc4e4aa29.1298029161.git.viresh.kumar@st.com> <20110218143438.GK21209@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:32961 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752474Ab1BVHDg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2011 02:03:36 -0500
In-Reply-To: <20110218143438.GK21209@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "viresh.linux@gmail.com" <viresh.linux@gmail.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>

On 02/18/2011 08:04 PM, Tejun Heo wrote:
> Hmmm... so, now there's a work item which requeues itself.  That can't
> be reliably stopped from freeze() as it's called with host lock held
> without process context.  I think you should override
> ->error_handler() which looks like the following,
> 
> arsan_error_handler(...)
> {
> 	cancel_work_sync(...);
> 	cancel_delayed_work_sync(...);
> 
> 	return ata_sff_error_handler(xxx);
> }

Thanks for this. I implemented drivers error_handler and error cases are
working fine now.

-- 
viresh
