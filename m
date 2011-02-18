From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] pata_arasan_cf: Adding support for arasan compact flash
 host controller
Date: Fri, 18 Feb 2011 14:48:59 +0530
Message-ID: <4D5E3983.7050007@st.com>
References: <0f2a633873dd2fa187afd7feef9fd71daa545b84.1297942328.git.viresh.kumar@st.com> <20110217145235.GY19830@htj.dyndns.org> <4D5DF816.4010907@st.com> <20110218091425.GB21209@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:48768 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753393Ab1BRJUb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 04:20:31 -0500
In-Reply-To: <20110218091425.GB21209@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, amitgoel <amit.goel@st.com>, Armando VISCONTI <armando.visconti@st.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, viresh kumar <viresh.linux@gmail.com>

On 02/18/2011 02:44 PM, Tejun Heo wrote:
>> > No. It doesn't have BMDMA. I just wanted to use existing framework and
>> > routines. And i wasn't sure if just overriding qc_issue alone will be enough.
>> > Should i keep it as it is or modify?
> I see.  Yeah, if the hardware doesn't really behave like a BMDMA
> controller (and the fact that you need to override every bmdma ops is
> a good indication of that), it usually is much cleaner to inherit from
> sff and implement DMA part in the driver proper.  There are several
> drivers like that in the tree.
> 
> 
>> > Why do these header 
> 
> files
>>>  needed?  Unless the driver is gonna be put
>>> > > in multiple .c files, there's no reason to separate out header files.
>>> > > 
>> > 
>> > Ok. include/linux/pata_arasan_cf_data.h is surely required as it will be
>> > used by platforms also. I kept register macros in a separate file to keep .c
>> > clean. I will merge drivers/ata/pata_arasan_cf.h in .c, if you want me to.
> Yes, please.

Ok.

-- 
viresh
