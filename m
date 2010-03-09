From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 09 Mar 2010 11:22:30 +0900
Message-ID: <4B95B0E6.2000401@kernel.org>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net> <4B955A37.2030206@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B955A37.2030206@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Karel Zak <kzak@redhat.com>, Jim Meyering <jim@meyering.net>
List-Id: linux-ide@vger.kernel.org

Hello,

On 03/09/2010 05:12 AM, H. Peter Anvin wrote:
> Please correct the following bit in C-3:
> 
> "A different partition format - GPT[6] - should be used beyond 2^32
> sectors, which could harm compatibility with older BIOSs or other
> operating systems which don't recognize the new format."
> 
> BIOS does not care about the partition table format.  There might be
> issues with > 2^32 sectors for BIOSes (e.g. truncating sector counts),
> but that would be unrelated.

Updated to,

  This might also be beneficial for operating systems which don't
  suffer from this limitation.  A different partition format - GPT[6]
  - should be used beyond 2^32 sectors, which could harm compatibility
  with other operating systems which don't recognize the new format.

Thanks.

-- 
tejun
