From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Wed, 10 Mar 2010 08:56:27 +0900
Message-ID: <4B96E02B.7060200@kernel.org>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net>	<20100308195847.GC18077@nb.net.home> <878wa20xb7.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41198 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab0CIX5Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Mar 2010 18:57:25 -0500
In-Reply-To: <878wa20xb7.fsf@meyering.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
Cc: Karel Zak <kzak@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

Hello,

On 03/09/2010 04:27 PM, Jim Meyering wrote:
> Related information, prompted by my recent encounter with a
> tool that refused to let me use a GPT partition table.
> 
> Partition table formats: prefer GUID/GPT:
> 
>   Having spent more than my share of time looking at partition table
>   formats recently, I am now strongly biased against DOS partition
>   tables, and for GUID/GPT ones.  In addition to allowing for >2GiB
>   partition offsets and lengths, GPT tables provide for better
>   protection in case of corruption (checksums, backup table at end
>   of disk) and don't have the anachronistic distinction of primary
>   and extended/logical partitions (all partitions are "primary").
>   You can even give each partition a name.  The only reason to use a
>   DOS partition table on a new installation is if you're stuck with
>   a requirement of using an OS like XP on bare metal.
> 
> Please consider encouraging the use of GPT partition tables...
> or at least do not *dis*courage their use.

I'll surely include it.

Thanks.

-- 
tejun
