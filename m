From: "Artem S. Tashkinov" <t.artem@lycos.com>
Subject: Re: IO errors after "block: remove =?UTF-8?Q?bio=5Fget=5Fnr=5Fvec?=
 =?UTF-8?Q?s=28=29=22?=
Date: Mon, 21 Dec 2015 04:23:01 +0500
Message-ID: <74a4e37024ed59315a9b5e8ad792cae2@lycos.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0126.b.hostedemail.com ([64.98.42.126]:35634 "EHLO
	smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750806AbbLTX3v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 18:29:51 -0500
In-Reply-To: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linus971@gmail.com

On 2015-12-20 22:51, Linus Torvalds wrote:
> Kent, Jens, Christoph et al,
>  please see this bugzilla:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=109661
> 
> where Artem Tashkinov bisected his problems with 4.3 down to commit
> b54ffb73cadc ("block: remove bio_get_nr_vecs()") that you've all
> signed off on.
> 
> (Also Tejun - maybe you can see what's up - maybe that error message
> tells you something)
> 
> I'm not sure what's up with his machine, the disk doesn't seem to be
> anyuthing particularly unusual, it looks like a 1TB Seagate Barracuda:
> 
>   ata1.00: ATA-8: ST1000DM003-1CH162, CC44, max UDMA/133
> 
> which doesn't strike me as odd.
> 
> Looking at the dmesg, it also looks like it's a pretty normal
> Sandybridge setup with Intel chipset. Artem, can you confirm? The PCI
> ID for the AHCI chip seems to be (INTEL, 0x1c02).
> 
> Any ideas? Anybody?
> 

That's correct. That's a very usual Asus P8P67 Pro motherboard (Intel 
P67 chipset) in AHCI mode and run of the mill HDD which is the one you 
identified.
