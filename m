From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V3 resend 2/2] pata_arasan_cf: Adding support for
 arasan compact flash host controller
Date: Tue, 22 Feb 2011 11:43:20 +0100
Message-ID: <20110222104320.GZ31267@htj.dyndns.org>
References: <f9a8bb8c5bcba1b9e5f84f8cfcfbc4a0f338151f.1298369157.git.viresh.kumar@st.com>
 <3f8cc4d5b94214f4746f55427e43ca4cd6df6a27.1298369157.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55970 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab1BVKnZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2011 05:43:25 -0500
Received: by mail-fx0-f46.google.com with SMTP id 17so2592605fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 22 Feb 2011 02:43:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3f8cc4d5b94214f4746f55427e43ca4cd6df6a27.1298369157.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, shiraz.hashim@st.com, amit.goel@st.com, armando.visconti@st.com, viresh.linux@gmail.com

On Tue, Feb 22, 2011 at 03:46:07PM +0530, Viresh Kumar wrote:
> The Arasan CompactFlash Device Controller has three basic modes of
> operation: PC card ATA using I/O mode, PC card ATA using memory mode, PC card
> ATA using true IDE modes.
> 
> Currently driver supports only True IDE mode.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Alright, looks good to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
