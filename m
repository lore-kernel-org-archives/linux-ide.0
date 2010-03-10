From: Gabor Gombas <gombasg@digikabel.hu>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 10 Mar 2010 08:09:29 +0100
Message-ID: <20100310070929.GA6188@twister.home>
References: <4B947393.2050002@kernel.org>
 <1268031640.4389.11.camel@mulgrave.site>
 <4B94ACE8.4060400@zytor.com>
 <87f94c371003091446h62e50257qf884b278c69cfbfa@mail.gmail.com>
 <4B96E25B.7050200@kernel.org>
 <3E0C3AE547FA504DA5E89EA5A24AC85803E2BD80@wdscexbe01.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3E0C3AE547FA504DA5E89EA5A24AC85803E2BD80@wdscexbe01.sc.wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Taylor <Daniel.Taylor@wdc.com>
Cc: Tejun Heo <tj@kernel.org>, Greg Freemyer <greg.freemyer@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, James Bottomley <James.Bottomley@suse.de>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, mkp@mkp.net
List-Id: linux-ide@vger.kernel.org

On Tue, Mar 09, 2010 at 04:14:30PM -0800, Daniel Taylor wrote:

> I will run some experiments to see if any of the systems on my desk can boot
> Linux from a GPT.

My desktop with a BIOS from 2005 has no problems with GPT. AFAIK a
recent Debian installer automatically chooses GPT if the disk is 2 TB or
larger.

Gabor
