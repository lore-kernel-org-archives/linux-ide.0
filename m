From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: kernel 2.6.25 with ide driver cs5520 does not boot.
Date: Fri, 9 May 2008 11:27:53 +0200
Message-ID: <200805091127.53737.bzolnier@gmail.com>
References: <20080508.165814.197343623.takada@mbf.nifty.com> <58cb370e0805080607n4f5de192o5a7371fd0fb1e9f8@mail.gmail.com> <20080509.112220.74748072.takada@mbf.nifty.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:35984 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbYEIJL6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 May 2008 05:11:58 -0400
Received: by nf-out-0910.google.com with SMTP id d3so574261nfc.21
        for <linux-ide@vger.kernel.org>; Fri, 09 May 2008 02:11:56 -0700 (PDT)
In-Reply-To: <20080509.112220.74748072.takada@mbf.nifty.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: TAKADA Yoshihito <takada@mbf.nifty.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 09 May 2008, TAKADA Yoshihito wrote:
> Thanks for quick reply.
> 
> I tried 2.6.26rc1. It hangs same as 2.6.25.
> kernel 2.6.26rc1 with cs5520 cannot boot. cs5520 scans ide0 and ide1.
> It seems 2nd port DMA base issue was solved.

[...]

Thanks.

The following patch for 2.6.26-rc1 disables VDMA, please give it a try
(I haven't time to fully audit VDMA support yet but lets see if it is
the main source of the problems).

---
 drivers/ide/pci/cs5520.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -119,6 +119,7 @@ static const struct ide_dma_ops cs5520_d
 	.dma_timeout		= ide_dma_timeout,
 };
 
+/* FIXME: VDMA is disabled because it caused problems */
 #define DECLARE_CS_DEV(name_str)				\
 	{							\
 		.name		= name_str,			\
@@ -126,7 +127,6 @@ static const struct ide_dma_ops cs5520_d
 		.dma_ops	= &cs5520_dma_ops,		\
 		.host_flags	= IDE_HFLAG_ISA_PORTS |		\
 				  IDE_HFLAG_CS5520 |		\
-				  IDE_HFLAG_VDMA |		\
 				  IDE_HFLAG_NO_ATAPI_DMA |	\
 				  IDE_HFLAG_ABUSE_SET_DMA_MODE, \
 		.pio_mask	= ATA_PIO4,			\
