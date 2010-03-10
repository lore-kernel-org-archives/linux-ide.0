From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 09 Mar 2010 21:17:08 -0800
Message-ID: <4B972B54.8050708@zytor.com>
References: <4B947393.2050002@kernel.org>	 <1268031640.4389.11.camel@mulgrave.site> <4B94ACE8.4060400@zytor.com> <87f94c371003091446h62e50257qf884b278c69cfbfa@mail.gmail.com> <4B96E25B.7050200@kernel.org> <3E0C3AE547FA504DA5E89EA5A24AC85803E2BD80@wdscexbe01.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3E0C3AE547FA504DA5E89EA5A24AC85803E2BD80@wdscexbe01.sc.wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Taylor <Daniel.Taylor@wdc.com>
Cc: Tejun Heo <tj@kernel.org>, Greg Freemyer <greg.freemyer@gmail.com>, James Bottomley <James.Bottomley@suse.de>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, mkp@mkp.net
List-Id: linux-ide@vger.kernel.org

On 03/09/2010 04:14 PM, Daniel Taylor wrote:
>
> The MBR in a GPT installation doesn't map the first GPT partition, it maps
> the entire drive
> drive after the first sector, as well as marking it type 0xEE.  The start
> LBA of the file system
> is not correctly located in the MBR.
>
> I will run some experiments to see if any of the systems on my desk can boot
> Linux from a GPT.

There is something called a "hybrid MBR", which is basically a GPT disk 
with a single partition (the current bootable partition) mapped as an 
MBR partition, instead of marking the whole disk 0xEE.

	-hpa
