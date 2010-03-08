From: Mike Snitzer <snitzer@redhat.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 8 Mar 2010 14:34:08 -0500
Message-ID: <170fa0d21003081134g491034e5v4aad4d43853e48ec@mail.gmail.com>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63080 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab0CHTeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2010 14:34:10 -0500
In-Reply-To: <yq1zl2ic058.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Karel Zak <kzak@redhat.com>, Jim Meyering <jim@meyering.net>

On Mon, Mar 8, 2010 at 10:18 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Tejun" =3D=3D Tejun Heo <tj@kernel.org> writes:
>
> Tejun> The [Windows Vista/7] partitioner seems to be using 1M as the
> Tejun> basic alignment unit and offsetting from there if explicitly
> Tejun> requested by the drive
>
> Yep.
>
>
> Tejun> Please note that hdparm is misreporting the alignment offset. =
=A0It
> Tejun> should be reporting 512 instead of 256 for offset-by-one drive=
s.
>
> Already fixed. =A0Your hdparm must be old.
>
>
>
> Tejun> Partitioners maybe should only align partitions which will be
> Tejun> used by Linux and default to the traditional layout for others
> Tejun> while allowing explicit override.
>
> I don't think we take the partition type into account. =A0Karel?
>
>
> Tejun> Reportedly, commonly used partitioners aren't ready to handle
> Tejun> drives larger than 2 TiB in any configuration and alignment is=
n't
> Tejun> done properly for drives with 4 KiB physical sectors. =A04 KiB
> Tejun> logical sector support is broken in both the kernel
>
> Huh, what? =A0My homedir is on a 4KiB LBS/PBS drive and has been for =
~2
> years.
>
>
> Tejun> (need more details and probably a whole section on partitioner
> Tejun> behaviors)
>
> I'm Cc:'ing Karel Zak and Jim Meyering who have been doing all the
> alignment work for fdisk and parted respectively. =A0Karel, Jim: The =
full
> writeup is here:
>
> =A0 =A0 =A0 =A0http://ata.wiki.kernel.org/index.php/ATA_4_KiB_sector_=
issues
>
> It'd be great if you guys could share what you have been doing to the
> tooling.

I've been keeping track of all the pieces in play, have coordinated
with kzak and jim, and have a summary that offers some amount of macro
detail (at the end I touch on parted and fdisk):

http://people.redhat.com/msnitzer/docs/io-limits.txt
