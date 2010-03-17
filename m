From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 17 Mar 2010 11:04:59 +0900
Message-ID: <4BA038CB.8050400@kernel.org>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>	 <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>	 <4B9EED55.10201@kernel.org> <1268720060.21384.10.camel@mulgrave.site>	 <4B9F2388.2030803@kernel.org> <1268745897.21384.14.camel@mulgrave.site>	 <4B9F8E1A.2020608@kernel.org> <1268749297.21384.15.camel@mulgrave.site>	 <4B9F9AAF.6080709@kernel.org> <1268751748.21384.18.camel@mulgrave.site>	 <4B9FA1C6.7090305@kernel.org> <1268752993.21384.23.camel@mulgrave.site> <4B9FA59E.1000402@kernel.org> <4B9FED32.6080400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B9FED32.6080400@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ric Wheeler <rwheeler@redhat.com>
Cc: James Bottomley <James.Bottomley@suse.de>, Denys Vlasenko <vda.linux@googlemail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de
List-Id: linux-ide@vger.kernel.org

Hello, Ric.

On 03/17/2010 05:42 AM, Ric Wheeler wrote:
> Dropping any mention of CHS seems to be the only sensible thing. Why
> waste any time to continue some myth about drives that no modern
> hardware supports (and then have the joy of explaining that to users)?
> 
> Talking about it only confuses people and in the worst case, could cause
> them to misalign their partitions by clinging to these pretend borders :-)

I don't think not mentioning it would clear up the myth.  It would
probably be a good idea to beef up the document to clear
misconceptions around disk geometry.  I'll give a shot at it.

Thanks.

-- 
tejun
