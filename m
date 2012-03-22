From: "ANEZAKI, Akira" <fireblade1230@yahoo.co.jp>
Subject: Re: Fwd: libata-pmp patch for 3.2.x and later for eSATA Port Multiplier
 Sil3726
Date: Thu, 22 Mar 2012 17:16:56 +0900
Message-ID: <4F6ADFF8.5000106@yahoo.co.jp>
References: <4F5ECD06.3000608@yahoo.co.jp> <4F5F7C4C.7080800@teksavvy.com> <4F662AFB.9050106@yahoo.co.jp> <CAMHSBOWg+rxxrVjf05r1tYDpW1S75XzdrLQ+U8TrjC9okRYtuA@mail.gmail.com> <4F6AAC37.7040907@yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta103.odn.ne.jp ([143.90.14.143]:34735 "EHLO cmta103.odn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398Ab2CVIQ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Mar 2012 04:16:58 -0400
Received: from smta103.odn.ne.jp by cmta103.odn.ne.jp with ESMTP
          id <20120322081657395.IWWC.1690.cmta103.odn.ne.jp@mta103.odn.ne.jp>
          for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2012 17:16:57 +0900
In-Reply-To: <4F6AAC37.7040907@yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Sorry for my poor English.
And I used wrong mail address.

(2012/03/22 13:36), ANEZAKI, Akira wrote:
> 3.2.x kernel sometimes breaks metadata and I have to fix them. I feel it
> strange and cannot understand that the kernel sometimes breaks
> metadatas/superblocks of RAIDs/file systems those don't include any HDDs
> those don't connected to any PMP.
... the kernel sometimes breaks metadata/superblock of RAID/file system.
The kernel may break them even if those don't include a HDD that is
connected to a PMP.

is correct.

Akira
