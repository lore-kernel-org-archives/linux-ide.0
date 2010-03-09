From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 9 Mar 2010 07:34:41 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1003090733330.9819@uplift.swm.pp.se>
References: <4B947393.2050002@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B947393.2050002@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

On Mon, 8 Mar 2010, Tejun Heo wrote:

>  http://ata.wiki.kernel.org/index.php/ATA_4_KiB_sector_issues

Excellent summary.

> C-2. Windows XP depends on the traditional partition layout.

Is this really true? WD ships their EARS drives with an alignment tool 
that as far as I can understand, moves the partition so
it's aligned to 4KiB:

http://www.wdc.com/en/products/advancedformat/

So an XP fresh install (including letting XP partition the drive) will be 
misaligned, but if you clone xp onto a properly aligned partition (or run 
the tool and let it move the partition), it'll be ok. So saying that XP 
"depends" on traditional partition layout might be a bit of a streth?

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
