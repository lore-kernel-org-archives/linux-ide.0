From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [BUID_FAILURE] next-20080215 Build failure caused by ide: rework
 PowerMac media-bay support
Date: Fri, 15 Feb 2008 23:24:11 +0530
Message-ID: <47B5D1C3.40702@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from E23SMTP03.au.ibm.com ([202.81.18.172]:56041 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294AbYBORyT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 12:54:19 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, michael@ellerman.id.au, Andy Whitcroft <apw@shadowen.org>

The linux-next-20080215 kernel build fails on the powerpc with
following error
 
  CC      arch/powerpc/platforms/powermac/setup.o
In file included from arch/powerpc/platforms/powermac/setup.c:66:
include/asm/mediabay.h:29: error: syntax error before 'ide_hwif_t'
include/asm/mediabay.h:29: warning: function declaration isn't a prototype
make[2]: *** [arch/powerpc/platforms/powermac/setup.o] Error 1
make[1]: *** [arch/powerpc/platforms/powermac] Error 2
make: *** [arch/powerpc/platforms] Error 2

This build failure is caused by the  ide: rework PowerMac media-bay support
patch.This problem was reported and solution suggested according to
http://lkml.org/lkml/2008/2/13/195 including the 

#include <linux/ide.h> after

#ifdef CONFIG_BLK_DEV_IDE_PMAC

helps in fixing the build failure.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
