From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] Fix build errors when BLOCK=n
Date: Wed, 19 Sep 2007 14:49:11 +1000
Message-ID: <18160.43591.441863.931220@cargo.ozlabs.ibm.com>
References: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:34745 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbXISFgb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Sep 2007 01:36:31 -0400
In-Reply-To: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
Cc: kumar.gala@Freescale.com, linuxppc-dev@ozlabs.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

Emil Medve writes:

> The fix tries to use the smallest scope CONFIG_* symbols that will fix the build
> problem. In this case <linux/ide.h> needs to be included only if IDE=y or
> IDE=m were selected. Also, ppc_ide_md is needed only if BLK_DEV_IDE=y or
> BLK_DEV_IDE=m

It would be nicer to remove the ppc_ide_md stuff from ppc_ksyms.c
altogether and just put the EXPORT_SYMBOL in setup_32.c.

Paul.
