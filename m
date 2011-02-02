From: "Eric D. Mudama" <edmudama@bounceswoosh.org>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Tue, 1 Feb 2011 22:55:27 -0700
Message-ID: <20110202055527.GD26790@bounceswoosh.org>
References: <4D395B74.1010705@st.com>
 <20110121101400.GC2832@htj.dyndns.org>
 <4D395FE8.8000902@st.com>
 <4D39752B.7000202@st.com>
 <20110121163906.GG2832@htj.dyndns.org>
 <AANLkTimw4NHmNcXiB1rrQMFMRvmwG5Ww9gj_K7_xw_j-@mail.gmail.com>
 <20110201175925.GA20794@bounceswoosh.org>
 <4D48D2F2.20907@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 173-160-50-61-colorado.hfc.comcastbusiness.net ([173.160.50.61]:51472
	"EHLO cammy.bounceswoosh.org" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752302Ab1BBFzb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2011 00:55:31 -0500
Content-Disposition: inline
In-Reply-To: <4D48D2F2.20907@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: "Eric D. Mudama" <edmudama@bounceswoosh.org>, Viresh Kumar <viresh.nitj@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>

On Wed, Feb  2 at  9:13, viresh kumar wrote:
>On 02/01/2011 11:29 PM, Eric D. Mudama wrote:
>> On Tue, Feb  1 at 21:02, Viresh Kumar wrote:
>>>
>>> I debugged it further and found that after data is transferred,
>>> altstatus register is returning status 0xd0, which means ATA_BUSY.
>>>
>>> I am not sure why this must be returned by card after data is transferred?
>>
>> Did you wait for the interrupt?  Or is this polling alt status
>> immediately after completing the data transfer?
>
>I waited for this interrupt:
>
>INTRQ_Int: This is the direct assignment of the CF/CF+ Interface pin 37 (INTRQ) when the
>Interface is operating in TrueIDE Mode. This is the Interrupt from the Card.
>The Software must read the ATA Status Register to find the source of Interrupt.
>
>And i think that is sufficient enough.

Yes, should be.  Do both alt status and regular status show this signature?

Possible there's some kind of hardware race condition, though IDE is
pretty much a "known" interface.

>Just to get over this doubt, i will try place a small udelay after data is transferred
>and before framework is communicated for successful xfer.

That's a good thing to try, wouldn't be the first time I've heard of
things like that being required.

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

