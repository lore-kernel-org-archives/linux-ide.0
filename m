From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH v3 3/5] devicetree: create a separate binding description
 for sata_highbank
Date: Fri, 09 Aug 2013 11:12:30 -0500
Message-ID: <520514EE.1060708@calxeda.com>
References: <1375890758-30265-1-git-send-email-mark.langsdorf@calxeda.com> <1375890758-30265-3-git-send-email-mark.langsdorf@calxeda.com> <20130809161015.GQ20515@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130809161015.GQ20515@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Rob Herring <rob.herring@calxeda.com>, "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>
List-Id: linux-ide@vger.kernel.org

On 08/09/2013 11:10 AM, Tejun Heo wrote:
> On Wed, Aug 07, 2013 at 10:52:36AM -0500, Mark Langsdorf wrote:
>> The Calxeda sata_highbank driver has been adding its descriptions to the
>> ahci driver. Separate them properly.
>>
>> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>
> Will wait for the update.  I suppose this doesn't need to go in to
> for-3.11-fixes?  I'd really appreciate what impact each patch has.

I'll update the description when I resubmit it to give you more detail 
on the impact.

Thanks for applying the others.

--Mark Langsdorf
Calxeda, Inc.
