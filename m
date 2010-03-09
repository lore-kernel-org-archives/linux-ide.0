From: Michal Soltys <soltys@ziu.info>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 09 Mar 2010 11:06:07 +0100
Message-ID: <4B961D8F.3010500@ziu.info>
References: <4B947393.2050002@kernel.org> <alpine.DEB.1.10.1003090733330.9819@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.1.10.1003090733330.9819@uplift.swm.pp.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Abrahamsson <swmike@swm.pp.se>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

Mikael Abrahamsson wrote:
> On Mon, 8 Mar 2010, Tejun Heo wrote:
> 
>>  http://ata.wiki.kernel.org/index.php/ATA_4_KiB_sector_issues
> 
> Excellent summary.
> 
>> C-2. Windows XP depends on the traditional partition layout.
> 
> Is this really true? WD ships their EARS drives with an alignment tool 
> that as far as I can understand, moves the partition so
> it's aligned to 4KiB:
> 

XP SP2 (or later) can boot from any place, including logical partitions 
(tested that recently). Most important thing is "hidden sectors" (recent 
chain.c32 can set that automatically through ntldr and/or sethidden 
options). No idea about pre-SP2 ; Win 2000 will not boot from "misaligned" 
(with reference to cylinder boundary) partition.
