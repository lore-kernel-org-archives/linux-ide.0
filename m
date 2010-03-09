From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 09 Mar 2010 11:53:55 +0900
Message-ID: <4B95B843.6030900@kernel.org>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net> <170fa0d21003081134g491034e5v4aad4d43853e48ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <170fa0d21003081134g491034e5v4aad4d43853e48ec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Snitzer <snitzer@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Karel Zak <kzak@redhat.com>, Jim Meyering <jim@meyering.net>
List-Id: linux-ide@vger.kernel.org

Hello,

On 03/09/2010 04:34 AM, Mike Snitzer wrote:
> I've been keeping track of all the pieces in play, have coordinated
> with kzak and jim, and have a summary that offers some amount of macro
> detail (at the end I touch on parted and fdisk):
> 
> http://people.redhat.com/msnitzer/docs/io-limits.txt

Ah... this is great.  I'll link the doc and shamelessly steal parts of
it if that's okay with you.

Thanks.

-- 
tejun
