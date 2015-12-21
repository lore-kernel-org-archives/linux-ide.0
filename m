From: "Artem S. Tashkinov" <t.artem@lycos.com>
Subject: Re: IO errors after "block: remove =?UTF-8?Q?bio=5Fget=5Fnr=5Fvec?=
 =?UTF-8?Q?s=28=29=22?=
Date: Mon, 21 Dec 2015 06:50:21 +0500
Message-ID: <20aa515947cdc15799f520f904ad99a2@lycos.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0129.b.hostedemail.com ([64.98.42.129]:32981 "EHLO
	smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750847AbbLUBuX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 20:50:23 -0500
In-Reply-To: <CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2015-12-21 06:38, Ming Lei wrote:
> On Mon, Dec 21, 2015 at 1:51 AM, Linus Torvalds wrote:
>> Kent, Jens, Christoph et al,
>>  please see this bugzilla:
>> 
>>   https://bugzilla.kernel.org/show_bug.cgi?id=109661
>> 
>> where Artem Tashkinov bisected his problems with 4.3 down to commit
>> b54ffb73cadc ("block: remove bio_get_nr_vecs()") that you've all
>> signed off on.
>> 
>> (Also Tejun - maybe you can see what's up - maybe that error message
>> tells you something)
>> 
>> I'm not sure what's up with his machine, the disk doesn't seem to be
>> anyuthing particularly unusual, it looks like a 1TB Seagate Barracuda:
>> 
>>   ata1.00: ATA-8: ST1000DM003-1CH162, CC44, max UDMA/133
>> 
>> which doesn't strike me as odd.
>> 
>> Looking at the dmesg, it also looks like it's a pretty normal
>> Sandybridge setup with Intel chipset. Artem, can you confirm? The PCI
>> ID for the AHCI chip seems to be (INTEL, 0x1c02).
>> 
>> Any ideas? Anybody?
> 
> BTW, I have posted very similar issue in the link:
> 
> http://marc.info/?l=linux-ide&m=145066119623811&w=2
> 
> Artem, I noticed from bugzillar that the hardware is i386, just
> wondering if PAE is enabled?  If yes, I am more confident
> that both the two kinds of report are similar or same.
> 

Yes, I'm on i686 with PAE (16GB of RAM here) - it's specifically 
mentioned in the corresponding bug report.

P.S. I know Linus doesn't condone PAE but I still find it more 
preferrable than running a mixed environment with almost zero benefit in 
regard to performance and quite obvious performance regressions related 
to an increased number of libraries being loaded (i686 + x86_64) and 
slightly bloated code which sometimes cannot fit in the CPU cache. Call 
me old fashioned but I won't upgrade to x86_64 until most of the things 
that I run locally are available for x86_64 and that won't happen any 
time soon.
