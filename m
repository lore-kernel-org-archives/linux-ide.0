From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [git patches] libata updates
Date: Tue, 1 May 2007 14:34:39 -0700
Message-ID: <200705011434.40440.jesse.barnes@intel.com>
References: <20070429161542.GA12501@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47629 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423684AbXEAVeb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 17:34:31 -0400
In-Reply-To: <20070429161542.GA12501@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sunday, April 29, 2007 9:15 am Jeff Garzik wrote:
> Noteworthy changes:
> * remove combined mode PCI quirk.  IDE driver selection (libata or
>   old-IDE) is now determined purely by module load order.
> * new driver API, that is far more like other kernel APIs:
>   alloc...register...unregister...free.
> * More Alan PATA work
> * Lots of other little bits.

>  drivers/pci/quirks.c                |  113 ----

Looks like you removed the combined_mode quirk (yay!) but didn't update
kernel-parameters.txt...  might confuse people.  Here's a patch to remove
mention of it from the documentation.

Signed-off-by:  Jesse Barnes <jesse.barnes@intel.com>

Thanks,
Jesse

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 84c3bd0..49b1ea3 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -722,14 +722,6 @@ and is between 256 and 4096 characters. It is defined in the file
 	inport.irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
 			Format: <irq>
 
-	combined_mode=	[HW] control which driver uses IDE ports in combined
-			mode: legacy IDE driver, libata, or both
-			(in the libata case, libata.atapi_enabled=1 may be
-			useful as well).  Note that using the ide or libata
-			options may affect your device naming (e.g. by
-			changing hdc to sdb).
-			Format: combined (default), ide, or libata
-
 	inttest=	[IA64]
 
 	io7=		[HW] IO7 for Marvel based alpha systems
