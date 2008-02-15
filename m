From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/4] ide: generic packet command representation
Date: Fri, 15 Feb 2008 14:24:01 +0000
Message-ID: <20080215142401.2857852d@core>
References: <1202718880-1793-1-git-send-email-petkovbb@gmail.com>
	<200802120109.24152.bzolnier@gmail.com>
	<Pine.LNX.4.64.0802151503580.30301@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45777 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756795AbYBOObz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 09:31:55 -0500
In-Reply-To: <Pine.LNX.4.64.0802151503580.30301@fbirervta.pbzchgretzou.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Borislav Petkov <petkovbb@googlemail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

> So, why is ide-scsi still in the tree? Is there some use case besides
> cdrecord? (Which can use /dev/hda already without the ide-scsi blob...)

With old IDE only ide-scsi can handle some of the more obscurely weird
devices, and some tape drives fail with ide-tape but work with  ide-scsi
+ osst/st.

Alan
