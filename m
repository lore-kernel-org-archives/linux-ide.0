From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 09 Mar 2010 11:44:51 +0900
Message-ID: <4B95B623.9040705@kernel.org>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yq1zl2ic058.fsf@sermon.lab.mkp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Karel Zak <kzak@redhat.com>, Jim Meyering <jim@meyering.net>
List-Id: linux-ide@vger.kernel.org

Hello,

On 03/09/2010 12:18 AM, Martin K. Petersen wrote:
>>>>>> "Tejun" == Tejun Heo <tj@kernel.org> writes:
> Tejun> Please note that hdparm is misreporting the alignment offset.  It
> Tejun> should be reporting 512 instead of 256 for offset-by-one drives.
> 
> Already fixed.  Your hdparm must be old.

Yeah, I know Mark fixed it but couldn't find where the tree was.  SF
only had old releases, so...

(other stuff replied further down the thread)

Thanks.

-- 
tejun
