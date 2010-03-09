From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 09 Mar 2010 11:42:52 +0900
Message-ID: <4B95B5AC.8050101@gmail.com>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net> <20100308195847.GC18077@nb.net.home> <4B95B39C.70402@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B95B39C.70402@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Karel Zak <kzak@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Jim Meyering <jim@meyering.net>
List-Id: linux-ide@vger.kernel.org

Hello, again.

On 03/09/2010 11:34 AM, Tejun Heo wrote:
>>  - parted uses 1MiB alignment for disks with unknown topology, disks
>>    with topology information are aligned to optimal (or minimum) I/O
>>    size (parted >= 2.1)
> 
> This will result in incorrect alignment for drives which lie about the
> physical sector size to work around BIOS/drivers issues (C-1).  It
> would probably be best to align to at least 1MiB.

I misread it.  C-1 would be disks w/o alignment information which will
be aligned to optimal_io_size which again would be 0 and thus 1MiB
alignment.  So, this should work, right?

Thanks.

-- 
tejun
