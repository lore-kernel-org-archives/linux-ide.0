From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libata: end the r-word
Date: Wed, 12 Mar 2014 05:12:21 -0700
Message-ID: <CAPcyv4hnMdo7cfuoxmd2Y-wzDzpoxPpupGVC-UR3gyQDn-Nsaw@mail.gmail.com>
References: <20140306032706.9641.99151.stgit@viggo.jf.intel.com>
	<20140307214049.78931def@alan.etchedpixels.co.uk>
	<CAA9_cmfbS1kZyLampjva8sh=ynqLYY3HLDRDy0oM6teeihAjmg@mail.gmail.com>
	<532034A6.8070705@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:60368 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbaCLMMW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2014 08:12:22 -0400
Received: by mail-vc0-f169.google.com with SMTP id ik5so2115209vcb.28
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2014 05:12:22 -0700 (PDT)
In-Reply-To: <532034A6.8070705@mrc-lmb.cam.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Mar 12, 2014 at 3:19 AM, Dave Howorth
<dhoworth@mrc-lmb.cam.ac.uk> wrote:
> Dan Williams wrote:
>> On Fri, Mar 7, 2014 at 1:40 PM, One Thousand Gnomes
>> <gnomes@lxorguk.ukuu.org.uk> wrote:
>>> On Wed, 05 Mar 2014 19:33:04 -0800
>>> Dan Williams <dan.j.williams@intel.com> wrote:
>>>
>>>> We want our contributors to spend their anger, resentment, and
>>>> frustration emotional resources on finding and fixing broken code.  We
>>>> do not want those valuable resources wasted on unfortunately worded
>>>> comments.
>>> The comment appears to be very accurately worded in this case. To retard
>>> is to slow down. We allow 30 seconds of idleness for very slow devices.
>>
>> Right, as a verb, if the comment had said "some devices retard the
>> reset recovery process" that would be pedantic word choice but more in
>> line with a specific technical meaning of the word.
>>
>>> Now I can see why you might want to remove the word in some other context
>>> such as if we had /* Linus is such a retard */ but this context appears
>>> to be correct, and in fact a rather clever bit of wordplay (intended or
>>> otherwise)
>>
>> Actually, no, int this case I'm specifically concerned with adjective
>> usage "retarded devices".  Where the implication is there is something
>> wrong with the device.  Unfortunately in the US it has become a slur
>> and slang term to classify the "worst of things".  I suspect that
>> usage has not made it to the UK?
>
> I think what hasn't made it to the UK is an undue emphasis on political
> correctness. 'Retarded' at least implies slowness

...among other things.

> whereas 'outlier' is a meaningless noise word.

"An outlier is an observation point that is distant from other
observations", and the comments clarify that the specific observation
in this case is prolonged recovery time.  Rhetorical question, are
"slow" devices fast in other areas?  The comments are now constrained
to the attribute of recovery latency relative to other devices.

> Furthermore, it's actually a noun rather than an
> adjective, so the proposed change makes the comment ungrammatical.

See "attributive noun".

> The word you're looking for is 'outlying' though I would prefer a meaningful
> description such as 'extremely slow devices' if obsequiousness to
> political correctness is deemed necessary.

No, it isn't, but thank you for compliment.  I have no problem being
deferential to people deserving of empathy.
