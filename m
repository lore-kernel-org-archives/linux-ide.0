From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 08 Mar 2010 22:11:32 -0500
Message-ID: <yq1iq9689zv.fsf@sermon.lab.mkp.net>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net>
	<20100308195847.GC18077@nb.net.home> <4B95B39C.70402@kernel.org>
	<4B95B5AC.8050101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B95B5AC.8050101@gmail.com> (Tejun Heo's message of "Tue, 09 Mar
	2010 11:42:52 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Jim Meyering <jim@meyering.net>
List-Id: linux-ide@vger.kernel.org

>>>>> "Tejun" == Tejun Heo <htejun@gmail.com> writes:

>> This will result in incorrect alignment for drives which lie about
>> the physical sector size to work around BIOS/drivers issues (C-1).
>> It would probably be best to align to at least 1MiB.

Tejun> I misread it.  C-1 would be disks w/o alignment information which
Tejun> will be aligned to optimal_io_size which again would be 0 and
Tejun> thus 1MiB alignment.  So, this should work, right?

Correct.  ATA only provides physical block size whereas SCSI has the
extra knobs in the block limits VPD.  And consequently ATA block devices
have min_io = physical block size and optimal_io = 0.

So we'll align to 1 MB by default.

-- 
Martin K. Petersen	Oracle Linux Engineering
