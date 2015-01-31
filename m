From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: linux-next: libahci_platform has undefined symbol on sparc
Date: Sat, 31 Jan 2015 17:25:43 +0100
Message-ID: <54CD0207.2090306@redhat.com>
References: <1422710050.3030.17.camel@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52067 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbbAaQZ5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2015 11:25:57 -0500
In-Reply-To: <1422710050.3030.17.camel@opteya.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Tejun Heo <tj@kernel.org>
Cc: linux-next@vger.kernel.org, linux-ide@vger.kernel.org, sparclinux@vger.kernel.org

Hi,

On 01/31/2015 02:14 PM, Yann Droneaud wrote:
> Hi,
> 
> I've seen another issue regarding commit c7d7ddee7e24eedde6149eefbcfbfbc7125b9ff0
> ("ata: libahci: Allow using multiple regulators") from linux-next:
> This commit modify ahci_platform_get_resources to use of_platform_device_create().
> 
> Unfortunately, it seems that of_platform_device_create() is not
> available on sparc (see CONFIG_OF_ADDRESS), so when built for sparc,
> the module libahci_platform.ko is rejected by modpost:
> 
>   ERROR: "of_platform_device_create" [drivers/ata/libahci_platform.ko] undefined!
>   ../scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>   make[2]: *** [__modpost] Error 1
>   src/linux/Makefile:1120: recipe for target 'modules' failed

Ah yes we had the same problem in simplefb, the example code for using
of_platform_device came from simplefb, and already had the fix, but it look
like Gregory did not include the bits fixing this in the ahci_platform code

Gregory, can you please submit a follow up patch fixing this? See simplefb.c
for the easiest way to fix this.

Regards,

Hans
