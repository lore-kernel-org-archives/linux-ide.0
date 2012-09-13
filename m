From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [libata:NEXT 14/21] ERROR: "ata_dev_set_feature" [drivers/ata/libahci.ko]
 undefined!
Date: Thu, 13 Sep 2012 01:43:06 -0400
Message-ID: <5051726A.8090708@pobox.com>
References: <20120913053915.GA23363@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:59129 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab2IMFnO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Sep 2012 01:43:14 -0400
In-Reply-To: <20120913053915.GA23363@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Shane Huang <shane.huang@amd.com>, kernel-janitors@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org

On 09/13/2012 01:39 AM, Fengguang Wu wrote:
> Hi Shane,
>
> FYI, kernel build failed on
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git NEXT
> head:   633de4cc2c049949459dd0b73d78576cd23906b5
> commit: 65fe1f0f66a57380229a4ced844188103135f37b [14/21] ahci: implement aggressive SATA device sleep support
> config: x86_64-randconfig-s313 (attached as .config)
>
> All related error/warning messages:
>
> drivers/ata/libata-core.c: In function 'ata_hpa_resize':
> drivers/ata/libata-core.c:1396:3: warning: 'native_sectors' may be used uninitialized in this function [-Wmaybe-uninitialized]
> ERROR: "ata_dev_set_feature" [drivers/ata/libahci.ko] undefined!
>
> ---
> 0-DAY kernel build testing backend         Open Source Technology Centre
> Fengguang Wu <wfg@linux.intel.com>                     Intel Corporation
>

This should already be fixed by

commit 633de4cc2c049949459dd0b73d78576cd23906b5
Author: Jeff Garzik <jeff@garzik.org>
Date:   Thu Sep 13 01:12:29 2012 -0400

     [libata] export ata_dev_set_feature()

     Signed-off-by: Jeff Garzik <jgarzik@redhat.com>


