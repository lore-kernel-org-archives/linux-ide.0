From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 08 Mar 2010 10:38:35 -0500
Message-ID: <yq1mxyibz7o.fsf@sermon.lab.mkp.net>
References: <4B947393.2050002@kernel.org>
	<1268031640.4389.11.camel@mulgrave.site>
	<yq1vdd6bzgz.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:20364 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab0CHPkm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2010 10:40:42 -0500
In-Reply-To: <yq1vdd6bzgz.fsf@sermon.lab.mkp.net> (Martin K. Petersen's
	message of "Mon, 08 Mar 2010 10:33:00 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

>>>>> "Martin" == Martin K Petersen <martin.petersen@oracle.com> writes:

Martin> There are 4 KB LBS SSDs out there but in general the industry is
Martin> sticking to ATA for local boot.

Thus implying that ATA doesn't support 4 KB LBS, just that people stick
to the tried-and-true 512.

-- 
Martin K. Petersen	Oracle Linux Engineering
