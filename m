From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 08 Mar 2010 21:42:42 -0500
Message-ID: <4B95B5A2.2090902@garzik.org>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net> <20100308195847.GC18077@nb.net.home> <4B95B39C.70402@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B95B39C.70402@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Karel Zak <kzak@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Jim Meyering <jim@meyering.net>
List-Id: linux-ide@vger.kernel.org

On 03/08/2010 09:34 PM, Tejun Heo wrote:
> libata is broken for logical 4KiB ATA devices tho.  I'll fix it up.

Does libata-dev.git#sectsize miss any details?

	Jeff
