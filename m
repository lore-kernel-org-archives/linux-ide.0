From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [GIT PULL] async scsi resume for 3.15
Date: Fri, 11 Apr 2014 11:20:50 -0700
Message-ID: <1397240450.2626.37.camel@dabdike.int.hansenpartnership.com>
References: <1397179458.4303.23.camel@dwillia2-mobl2.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1397179458.4303.23.camel@dwillia2-mobl2.amr.corp.intel.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Todd E Brandt <todd.e.brandt@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, "Brown, Len" <len.brown@intel.com>, Phillip Susi <psusi@ubuntu.com>
List-Id: linux-ide@vger.kernel.org

On Thu, 2014-04-10 at 18:24 -0700, Dan Williams wrote:
> Hi Linus,
> 
> James might still be in the process of sending this your way.  However,
> given the proximity to -rc1, my reasoning for sending this directly is:
> 
> 1/ It provides a tangible speed up for a non-esoteric use case (laptop
> resume):
> 
>   https://01.org/suspendresume/blogs/tebrandt/2013/hard-disk-resume-optimization-simpler-approach
> 
> 2/ You already pulled the first half of this enabling from Tejun.
> Quoting Tejun's ATA pull request:
> 
>   "Dan finishes the patchset to make libata PM operations
>    asynchronous.  Combined with one patch being routed through scsi,
>    this should speed resume measurably."
> 
> 3/ As far as I can tell it is acceptable to James:
> 
>   http://marc.info/?l=linux-scsi&m=139499409510791&w=2
>   http://marc.info/?l=linux-scsi&m=139508044602605&w=2
>   http://marc.info/?l=linux-scsi&m=139536062515216&w=2
> 
> 4/ I promised Todd I would get it upstream before he returns from
> vacation.
> 
> Please pull, thank you.

OK, so this missed the SCSI cutoff window because the series wasn't
finalised until 17 March and, originally, I thought Linus would cut us
off at -rc7 which was 16 March.  In reality we got an extra week, but I
spent that ironing out a few late arriving bugs in the tree itself
rather than integrating features.

For drivers, I'm willing to buck the release protocols a bit because
they're self contained, but for core features, they are supposed to be
all finalised by -rc5.  Plus Linus bites me every time I do it even for
drivers, so I was actually letting the scars heal a bit.

I also don't see this in linux-next, unless I'm not looking in the right
place, so it would be a bit of a risk adding it just before -rc1.

James


