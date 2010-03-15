From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Sun, 14 Mar 2010 21:00:50 -0700
Message-ID: <4B9DB0F2.7060808@zytor.com>
References: <4B947393.2050002@kernel.org> <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com> <4B9D8BB2.1010507@zytor.com> <201003150326.22262.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201003150326.22262.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

On 03/14/2010 07:26 PM, Denys Vlasenko wrote:
>>
>> Yes, but it does squat for a flash disk that wants, say, 256K alignment.
> 
> 4K makes sense. 256K not so much.
> 
> 256K alignment is hard to swallow for a lot of reasons anyway.
> Unless the filesystem packs small files into blocks a-la reiserfs,
> 256K block filesystems will be very inefficient for a typical
> storage scenarios.
> 

Noone has talked about using 256K filesystem blocks.  The fact of the
matter, though, is that both flash and RAID have much larger alignment
requirements than a mere 4K for optimal performance.

You might not like it, but that's the way it is.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
