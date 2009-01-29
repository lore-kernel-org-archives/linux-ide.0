From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCHSET #upstream-fixes] libata: improve flaky link handling
Date: Thu, 29 Jan 2009 10:50:02 -0500
Message-ID: <4981D02A.8030001@rtr.ca>
References: <1233228696-10562-1-git-send-email-tj@kernel.org> <87f94c370901290607t4cef87ack43fd456d1703d1ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:60049 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758405AbZA2PuE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 10:50:04 -0500
In-Reply-To: <87f94c370901290607t4cef87ack43fd456d1703d1ca@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, jeff@garzik.org, linux-ide@vger.kernel.org

Greg Freemyer wrote:
> On Thu, Jan 29, 2009 at 6:31 AM, Tejun Heo <tj@kernel.org> wrote:
>> Hello,
>>
>> This patchset is kicked off by kernel bz#9913 which reports hot
>> plugging and general detection problems with WD My Book drives.  WD
>> was kind enough to provide me with these drives and I played quite a
>> bit with a few controllers and weird cabling configurations including
>> long cables and several genders.
>>
>> It was surprisingly easy to trigger link layer problems.  eSATA ports
>> often go through extra cable and gender.  eSATA cables tend to be
>> longer than internal ones and as the cables are much stiffer touching
>> or moving the cable can easily cause enough wiggle at the connectors
>> to cause temporary transmission problems and being outside, it's much
>> more likely to be moved.
>>
>> So, with abundant link quality problems, the following problems have
>> been identified.
> Tejun,
> 
> This looks like an important patchset for those of us that use eSata.
> Any chance these can get into the opensuse 11.1 kernels?  Or lacking
> that, the os factory kernels?
..

Based on experience here, I'd say the problem isn't terribly widespread
beyond the specific vendor Tejun identified.  I have several eSATA setups
at hand here, and never see flaky link behaviour on them.

Cheers
