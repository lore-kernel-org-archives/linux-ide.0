From: Jeppe Oland <uxorious@acon.dezign.dk>
Subject: Re: LSISAS1068E + WDC WD2002FYPS: I/O error & Sense Key
Date: Fri, 11 Sep 2009 06:20:13 +0000 (UTC)
Message-ID: <loom.20090911T081747-5@post.gmane.org>
References: <20090727060322.GB27002@lifeintegrity.com> <4A70A64A.2070605@gmail.com> <20090729200714.GA20706@lifeintegrity.com> <4A70D57B.6030301@gmail.com> <20090731184023.GT3211@lifeintegrity.com> <20090803050853.GA26430@lifeintegrity.com> <1249310093.3943.11.camel@mulgrave.site> <20090803160629.GA2011@lifeintegrity.com> <1249316158.3943.54.camel@mulgrave.site> <20090826211736.GE9339@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:34047 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbZIKGZD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Sep 2009 02:25:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MlzZA-0003FC-C9
	for linux-ide@vger.kernel.org; Fri, 11 Sep 2009 08:25:04 +0200
Received: from swrd2.unwiredltd.com ([swrd2.unwiredltd.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 11 Sep 2009 08:25:04 +0200
Received: from uxorious by swrd2.unwiredltd.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 11 Sep 2009 08:25:04 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Allan Wind <allan_wind <at> lifeintegrity.com> writes:
> I have not seen any problems since upgrading to 2.6.30.4.

I just upgraded to Debian Testing with 2.6.30-1-amd64,and now I am seeing
the same problem. Didn't have any problems with Debian 5.0 stable.

[751979.174584] sd 6:0:0:0: [sda] Sense Key : Recovered Error [current]
[descriptor]
[751979.174590] Descriptor sense data with sense descriptors (in hex):
[751979.174592]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
[751979.174597]         00 4f 00 c2 40 50
[751979.174600] sd 6:0:0:0: [sda] Add. Sense: ATA pass through information
available
[753779.392241] sd 6:0:0:0: [sda] Sense Key : Recovered Error [current]
[descriptor]
[753779.392257] Descriptor sense data with sense descriptors (in hex):
[753779.392260]         72 01 00 1d 00 00 00 0e 09 0c 00 00 00 00 00 00
[753779.392265]         00 4f 00 c2 40 50
[753779.392268] sd 6:0:0:0: [sda] Add. Sense: ATA pass through information
available
[754954.862297] REISERFS error (device dm-9): vs-13070
reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of
[42641 42810 0x0 SD]
[754954.862326] REISERFS error (device dm-9): vs-13070
reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of
[42641 42819 0x0 SD]

and lots more like that.

SMART reports no issues, and I have not noticed any data corruption (yet).

Controller is a Dell SAS RAID controller (SCSI storage controller: LSI Logic /
Symbios Logic SAS1068E PCI-Express Fusion-MPT SAS (rev 08)) with a single drive
attached to it.

Rgards,
-Jeppe

