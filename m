From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 09 Mar 2010 23:57:21 -0500
Message-ID: <yq1mxyg7ozy.fsf@sermon.lab.mkp.net>
References: <4B947393.2050002@kernel.org> <yq1zl2ic058.fsf@sermon.lab.mkp.net>
	<170fa0d21003081134g491034e5v4aad4d43853e48ec@mail.gmail.com>
	<4B95F071.3070400@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:33211 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296Ab0CJE67 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2010 23:58:59 -0500
In-Reply-To: <4B95F071.3070400@msgid.tls.msk.ru> (Michael Tokarev's message of
	"Tue, 09 Mar 2010 09:53:37 +0300")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Mike Snitzer <snitzer@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de, Karel Zak <kzak@redhat.com>, Jim Meyering <jim@meyering.net>, Neil Brown <neilb@suse.de>

>>>>> "Michael" == Michael Tokarev <mjt@tls.msk.ru> writes:

[MD I/O topology support]

Michael> But apparently it does not implement anything of this sort.
Michael> Adding Neilb to the Cc list.......

git show 8f6c2e4b

-- 
Martin K. Petersen	Oracle Linux Engineering
