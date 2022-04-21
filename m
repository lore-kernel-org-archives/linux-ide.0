Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BD4C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 21 Apr 2022 05:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384576AbiDUFxd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Apr 2022 01:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384577AbiDUFxd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2022 01:53:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8662D4
        for <linux-ide@vger.kernel.org>; Wed, 20 Apr 2022 22:50:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EA0668B05; Thu, 21 Apr 2022 07:50:42 +0200 (CEST)
Date:   Thu, 21 Apr 2022 07:50:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     damien.lemoal@opensource.wdc.com, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] ahci: Add a generic 'controller2' RAID id
Message-ID: <20220421055041.GB20772@lst.de>
References: <165051164674.3740862.4706111262486927842.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165051164674.3740862.4706111262486927842.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Apr 20, 2022 at 08:27:26PM -0700, Dan Williams wrote:
> As mentioned here [1], the pain of continuing add new and different
> device-ids for RAID mode to this file [2] has been heard. Ideally this
> device-id would not matter and the class code would remain
> PCI_CLASS_STORAGE_SATA_AHCI regardless of the RAID mode, but other
> operating systems depend on the class code *not* being AHCI when the
> device is in RAID mode. That said, going forward there is little reason
> for new server RAID ids to be added as they can simply reuse one of the
> existing ids even for a new controller. Server software RAID features
> continue to be supported on Linux. Client software RAID features
> continue to be not supported and the recommendation there remains to set
> the device to AHCI mode in platform firmware.

I thought client switched to vmd as well now?

Either way the patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
