From: Mark Lord <kernel@teksavvy.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 09 Mar 2010 08:55:20 -0500
Message-ID: <4B965348.3050201@teksavvy.com>
References: <4B947393.2050002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B947393.2050002@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

On 03/07/10 22:48, Tejun Heo wrote:
..
> Please note that hdparm is misreporting the alignment offset.  It
> should be reporting 512 instead of 256 for offset-by-one drives.
..

That issue was fixed quite a while ago.
Upgrade your elderly copy of hdparm.

:)
