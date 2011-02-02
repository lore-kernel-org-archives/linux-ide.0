From: viresh kumar <viresh.kumar@st.com>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Wed, 2 Feb 2011 11:28:54 +0530
Message-ID: <4D48F29E.3080408@st.com>
References: <4D395B74.1010705@st.com> <20110121101400.GC2832@htj.dyndns.org> <4D395FE8.8000902@st.com> <4D39752B.7000202@st.com> <20110121163906.GG2832@htj.dyndns.org> <AANLkTimw4NHmNcXiB1rrQMFMRvmwG5Ww9gj_K7_xw_j-@mail.gmail.com> <20110201175925.GA20794@bounceswoosh.org> <4D48D2F2.20907@st.com> <20110202055527.GD26790@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:34355 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752377Ab1BBF7Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2011 00:59:25 -0500
In-Reply-To: <20110202055527.GD26790@bounceswoosh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@bounceswoosh.org>
Cc: Viresh Kumar <viresh.nitj@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>

On 02/02/2011 11:25 AM, Eric D. Mudama wrote:
>> >Just to get over this doubt, i will try place a small udelay after data is transferred
>> >and before framework is communicated for successful xfer.
> That's a good thing to try, wouldn't be the first time I've heard of
> things like that being required.

I tried this, and still get same error sometimes. I took a 100ms delay.

-- 
viresh
