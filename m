From: "Artem S. Tashkinov" <t.artem@lycos.com>
Subject: Re: IO errors after "block: remove =?UTF-8?Q?bio=5Fget=5Fnr=5Fvec?=
 =?UTF-8?Q?s=28=29=22?=
Date: Mon, 21 Dec 2015 04:36:38 +0500
Message-ID: <ffff6df0111515810aa2f8bad7214705@lycos.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151220181801.GA12402@lst.de>
 <CA+55aFzVEUnfVNwSUtW3xsSOC6GDvGvE-scUasejA0G5BTi1AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0113.b.hostedemail.com ([64.98.42.113]:50670 "EHLO
	smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750791AbbLTXgk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 18:36:40 -0500
In-Reply-To: <CA+55aFzVEUnfVNwSUtW3xsSOC6GDvGvE-scUasejA0G5BTi1AA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Kent Overstreet <kent.overstreet@gmail.com>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linus971@gmail.com

On 2015-12-20 23:41, Linus Torvalds wrote:
> On Sun, Dec 20, 2015 at 10:18 AM, Christoph Hellwig wrote:
>> 
>> Artem,
>> 
>> can you re-check the commits around this series again?  I would be
>> extremtly surprised if it's really this particular commit and not
>> one just before it causing the problem - it just allocates bios
>> to the biggest possible instead of only allocating up to what
>> bio_add_page would accept.
> 
> Judging by Artem's bisect log, the last commit he tested before the
> bad one was the commit before: commit 6cf66b4caf9c ("fs: use helper
> bio_add_page() instead of open coding on bi_io_vec") and he marked
> that one good.
> 
> Sadly, without CONFIG_LOCALVERSION_AUTO, there's no way to match up
> the dmesg files (in the same bisection tar-file as the bisection log)
> with the actual versions. Also, Artem's bisect.log isn't actually the
> .git/BISECT_LOG file that contains the full information about what was
> marked good and bad, so it's a bit hard to read (ie I can tell that
> Artem had to mark commit 6cf66b4caf9c as "good" not because his log
> says so, but because that explains the next commit to be tested).
> 
> Of course, it's fairly easy to make a mistake while bisecting (just
> doing a thinko), but usually bisection miistakes end up causing you to
> go into some "all good" or "all bad" region of commits, and the fact
> that Artem seems to have marked the previous commit good and the final
> commit bad does seem to imply the bisection was successful.
> 
> But yes, it is always nice to double-check the bisection results. The
> best way to do it is generally to try to revert the bad commit and
> verify that things work after that, but that commit doesn't revert
> cleanly on top of 4.3 due to other changes.
> 
> Attached is a *COMPLETELY*UNTESTED* revertish patch for 4.3. It's
> basically a revert of b54ffb73cadc, but with a few fixups to make the
> revert work on top of 4.3.
> 
> So Artem, if you can test whether 4.3 works with that revert, and/or
> double-check booting that b54ffb73cadc again (to verify that it's
> really bad), and its parent (to double-check that it's really good),
> that would be a good way to verify that yes, it is really that *one*
> commit that breaks things for you.
> 

After reverting (applying) this patch on top of 4.3.3 everything is back 
to normal. It's indeed a guilty commit.

