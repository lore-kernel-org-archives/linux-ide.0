From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET #upstream-fixes] libata: improve flaky link handling
Date: Fri, 30 Jan 2009 08:57:00 +0900
Message-ID: <4982424C.3010709@kernel.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org> <87f94c370901290607t4cef87ack43fd456d1703d1ca@mail.gmail.com> <4981D02A.8030001@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54107 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbZA2X5S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 18:57:18 -0500
In-Reply-To: <4981D02A.8030001@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org

Hello, Mark, Greg.

Mark Lord wrote:
> Greg Freemyer wrote:
>> On Thu, Jan 29, 2009 at 6:31 AM, Tejun Heo <tj@kernel.org> wrote:
>>> So, with abundant link quality problems, the following problems have
>>> been identified.
>>
>> This looks like an important patchset for those of us that use eSata.
>> Any chance these can get into the opensuse 11.1 kernels?  Or lacking
>> that, the os factory kernels?

I do agree it's something I'd like to see deployed fast but I'm not
really sure.  Any change is dangerous and nothing sucks more than when
a machine fails to boot after a update and I did that at least once
already. :-( I'll surely get the first patch into the tree but for the
rest I think I'll wait a bit.

> Based on experience here, I'd say the problem isn't terribly widespread
> beyond the specific vendor Tejun identified.  I have several eSATA setups
> at hand here, and never see flaky link behaviour on them.

Based on my experience with PMPs and these drives, problems like these
are not really dependent on which device or controller is at the end
of the cabling but depends on the length and quality of cabling.  The
controller - device combination does have some influence, especially
on 3Gbps but I didn't find the WD drives to be exceptionally fragile
other than the shutdown-after-transmission-error problem.

I'm using about 30cm of internal cable + sata-eSATA gender + ~2M eSATA
cable and it's not too difficult to cause problem with any device with
such cabling.  The cabling is on the extreme side (may even be out of
spec) but given the bug reports I get for eSATA devices including
PMPs, I don't think this kind of cabling is unfortunately not too
uncommon.  As I wrote before, what makes it worse is the stiffness of
the eSATA cable, I can easily cause enough wiggle at the connectors by
touching the cable and it easily makes the device crap out especially
at 3Gbps.

Thanks.

-- 
tejun
