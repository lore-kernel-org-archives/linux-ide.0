From: Ian Pilcher <arequipeno@gmail.com>
Subject: Re: SATA backplane activity LEDs
Date: Tue, 06 Aug 2013 13:12:19 -0500
Message-ID: <ktre9s$va0$1@ger.gmane.org>
References: <ktp2k8$de0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56330 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139Ab3HFSMd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Aug 2013 14:12:33 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1V6lkG-0000Ew-AJ
	for linux-ide@vger.kernel.org; Tue, 06 Aug 2013 20:12:32 +0200
Received: from pool-71-252-209-206.dllstx.fios.verizon.net ([71.252.209.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 06 Aug 2013 20:12:32 +0200
Received: from arequipeno by pool-71-252-209-206.dllstx.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 06 Aug 2013 20:12:32 +0200
In-Reply-To: <ktp2k8$de0$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 08/05/2013 03:40 PM, Ian Pilcher wrote:
> I am trying to get the drive activity LEDs in my Thecus N5550 NAS
> working with a standard distribution kernel.  These LEDs are controlled
> by an NXP PCA9532 dimmer, rather than the SiI 3132 SATA controller.  I
> have been able to build the Thecus modules for a standard kernel, and I
> am able to control the LEDs manually (through their non-standard
> /proc/thecus_io interface).

I was wrong about the use of the SiI controller.  The backplane-
connected drives in this NAS are driven by the AHCI controller built in
to the ICH10R chipset.  (The SiI 3132 appears to be used only for the
eSATA port.)

All of which makes Thecus's modifications to libahci a lot more logical.

> Thecus uses a modified libata-core.c and libahci.c to control the LEDs,
> replacing ata_qc_new and ata_qc_free with variants that turn the LEDs
> on and off.  If at all possible, I would prefer not to be this
> intrusive.

I've come up with this approach, which allows me to "wrap" any of the
functions in ahci_ops:

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/libata.h>

extern struct ata_port_operations ahci_ops;

/* Original value of ahci_ops.qc_issue */
static unsigned int (*ahci_qc_issue)(struct ata_queued_cmd *);

static unsigned int thecus_qc_issue(struct ata_queued_cmd *qc)
{
        printk(KERN_INFO "thecus_qc_issue called\n");
        return ahci_qc_issue(qc);
}

static int __init thecus_ahci_init(void)
{
        ahci_qc_issue = ahci_ops.qc_issue;
        ahci_ops.qc_issue = thecus_qc_issue;
        return 0;
}

static void __exit thecus_ahci_exit(void)
{
        ahci_ops.qc_issue = ahci_qc_issue;
}

MODULE_AUTHOR("Ian Pilcher");
MODULE_DESCRIPTION("AHCI driver \"hooks\" for Thecus drive LEDs");
MODULE_LICENSE("GPL");

module_init(thecus_ahci_init);
module_exit(thecus_ahci_exit);

This appears to work in initial smoke testing, but it seems really
hackish and ugly.  OTOH, it's the only approach I can come up with that
will not require modifying/replacing the distro-provided drivers.

Is there a better way?

Thanks!

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
Sometimes there's nothing left to do but crash and burn...or die trying.
========================================================================

