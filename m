From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: reorganize configuration and implement revalidation
Date: Fri, 27 Jan 2006 00:39:11 +0900
Message-ID: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:61520 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932367AbWAZPjV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:39:21 -0500
Received: by zproxy.gmail.com with SMTP id 34so372373nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:39:17 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: htejun@gmail.com

Hello, again.

This patchset is against

upstream-2.6.17 (7db74a4780cf9cc6b2ea97582cdc8031d5f22ccd)
 + various fixes related to EH patchset [1]
 + three AHCI updates [2][3][4]
 + new reset mechanism patchset [5]
 + fixes regarding configuration patchset [6]

This patchset is consisted of 16 patches and can be categorized into
the following three parts.

#01-07		: prepare for ata_dev_identify() reorganization
#08-12		: reorganize ata_dev_identify() into ata_dev_read_id()
		  and ata_dev_configure()
#13-16		: implement and use revalidation using ata_dev_read_id()
		  and ata_dev_configure()

Also, please pay attention to the following.  It's taken from #08's
description.

  This function is probably the place to set transfer mode to PIO0
  before IDENTIFY.  However, reset -> identify -> init_dev_params
  order should be kept for pre-ATA4 devices so we cannot set transfer
  mode before IDENTIFY for them.  How do we know if a device is
  post-ATA4 before IDENTIFY?

How should we do this?  Ignore pre-ATA4 devices?

Thanks.

--
tejun

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=113798939526779&w=2
[2] http://marc.theaimsgroup.com/?l=linux-ide&m=113800194919594&w=2
[3] http://marc.theaimsgroup.com/?l=linux-ide&m=113800459922438&w=2
[4] http://marc.theaimsgroup.com/?l=linux-ide&m=113804195925385&w=2
[5] http://marc.theaimsgroup.com/?l=linux-ide&m=113809002924734&w=2
[6] http://marc.theaimsgroup.com/?l=linux-ide&m=113828912301267&w=2


