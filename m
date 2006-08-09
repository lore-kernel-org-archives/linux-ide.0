From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.17] atiixp & ahci: ATI SB600 SATA/IDE support for
 various modes
Date: Wed, 9 Aug 2006 12:22:40 -0700
Message-ID: <20060809122240.94bb00f5.akpm@osdl.org>
References: <B63F95CBF8A45E4293F8825849B30BF41171A6@TORCAEXMB3.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:33226 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751325AbWHITW5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 15:22:57 -0400
In-Reply-To: <B63F95CBF8A45E4293F8825849B30BF41171A6@TORCAEXMB3.atitech.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anatoli Antonovitch <antonovi@ati.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, 9 Aug 2006 13:54:06 -0400
"Anatoli Antonovitch" <antonovi@ati.com> wrote:

> Description
> 1. Support SB600 SATA legacy IDE (DMA enable).
> 2. Automatically match the proper driver for different SATA/IDE modes of
> SB600 SATA controller: ahci for SATA/Native IDE/RAID modes and
> ATIIXP_IDE for legacy mode.
> 
> Signed-off-by: Anatoli Antonovitch <antonovi@ati.com>

This patch affects two separate subsystems which have different
maintainers.  So I split into two and fudged the changelogs - please check
that I got it right.

Also, the patch was severely wordwrapped.  Please fix the email client for
next time, thanks.
