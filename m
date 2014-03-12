From: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Subject: Re: [PATCH] libata: end the r-word
Date: Wed, 12 Mar 2014 10:19:18 +0000
Message-ID: <532034A6.8070705@mrc-lmb.cam.ac.uk>
References: <20140306032706.9641.99151.stgit@viggo.jf.intel.com>	<20140307214049.78931def@alan.etchedpixels.co.uk> <CAA9_cmfbS1kZyLampjva8sh=ynqLYY3HLDRDy0oM6teeihAjmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46312 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbaCLKs0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2014 06:48:26 -0400
In-Reply-To: <CAA9_cmfbS1kZyLampjva8sh=ynqLYY3HLDRDy0oM6teeihAjmg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Dan Williams wrote:
> On Fri, Mar 7, 2014 at 1:40 PM, One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk> wrote:
>> On Wed, 05 Mar 2014 19:33:04 -0800
>> Dan Williams <dan.j.williams@intel.com> wrote:
>>
>>> We want our contributors to spend their anger, resentment, and
>>> frustration emotional resources on finding and fixing broken code.  We
>>> do not want those valuable resources wasted on unfortunately worded
>>> comments.
>> The comment appears to be very accurately worded in this case. To retard
>> is to slow down. We allow 30 seconds of idleness for very slow devices.
> 
> Right, as a verb, if the comment had said "some devices retard the
> reset recovery process" that would be pedantic word choice but more in
> line with a specific technical meaning of the word.
> 
>> Now I can see why you might want to remove the word in some other context
>> such as if we had /* Linus is such a retard */ but this context appears
>> to be correct, and in fact a rather clever bit of wordplay (intended or
>> otherwise)
> 
> Actually, no, int this case I'm specifically concerned with adjective
> usage "retarded devices".  Where the implication is there is something
> wrong with the device.  Unfortunately in the US it has become a slur
> and slang term to classify the "worst of things".  I suspect that
> usage has not made it to the UK?

I think what hasn't made it to the UK is an undue emphasis on political
correctness. 'Retarded' at least implies slowness whereas 'outlier' is a
meaningless noise word. Furthermore, it's actually a noun rather than an
adjective, so the proposed change makes the comment ungrammatical. The
word you're looking for is 'outlying' though I would prefer a meaningful
description such as 'extremely slow devices' if obsequiousness to
political correctness is deemed necessary.
