From: "Artem S. Tashkinov" <t.artem@lycos.com>
Subject: Re: IO errors after "block: remove =?UTF-8?Q?bio=5Fget=5Fnr=5Fvec?=
 =?UTF-8?Q?s=28=29=22?=
Date: Mon, 21 Dec 2015 09:43:22 +0500
Message-ID: <3c353dc4883c60ee99caa4555c81b6a1@lycos.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <CACVXFVOZ+8AJwn=qyPOjzpAdfTu=AAa_oUGhqnWvU2WTANCzHg@mail.gmail.com>
 <20aa515947cdc15799f520f904ad99a2@lycos.com>
 <CA+55aFz+sW4NjHZJP8mdLaqR8O0A8S4jVp=hT21tTjweOb1t8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0060.b.hostedemail.com ([64.98.42.60]:44229 "EHLO
	smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750802AbbLUEnZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 23:43:25 -0500
In-Reply-To: <CA+55aFz+sW4NjHZJP8mdLaqR8O0A8S4jVp=hT21tTjweOb1t8Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ming Lei <tom.leiming@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linus971@gmail.com

On 2015-12-21 09:32, Linus Torvalds wrote:
> On Sun, Dec 20, 2015 at 5:50 PM, Artem S. Tashkinov wrote:
>> 
>> P.S. I know Linus doesn't condone PAE but I still find it more 
>> preferrable
>> than running a mixed environment with almost zero benefit in regard to
>> performance and quite obvious performance regressions related to an
>> increased number of libraries being loaded (i686 + x86_64) and 
>> slightly
>> bloated code which sometimes cannot fit in the CPU cache. Call me old
>> fashioned but I won't upgrade to x86_64 until most of the things that 
>> I run
>> locally are available for x86_64 and that won't happen any time soon.
> 
> Don't upgrade *user* land. User land doesn't use the braindamage that 
> is PAE.
> 
> Just run a 64-bit kernel. Keep all your 32-bit userland apps and 
> libraries.
> 
> Trust me, that *will* be faster. PAE works really horribly badly,
> because all your really important data structures like your inodes and
> directory cache will all be in the low 1GB even if you have 16BG of
> RAM.
> 
> Of course, I'd also like more people to run things that way just to
> get more coverage of the whole "yes, we do all the compat stuff
> correctly". So I have some other reasons to prefer people running
> 64-bit kernels with 32-bit user land. But PAE really is a disaster.
> 

In the past I happily ran an x86_64 bit kernel together with 32bit 
userland for quite some time but then I hit a wall: VirtualBox expects 
its kernel modules to have the same bitness as the application itself so 
I had to revert back to an i686 PAE setup. It's probably high time to 
try qemu however last time I looked at it a few years ago it lacked 
several crucial features I need from a VM.
