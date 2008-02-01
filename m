From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 2/2 v3] sata_mv: Support SoC controllers
Date: Sat, 2 Feb 2008 03:15:57 +0900
Message-ID: <20080201181557.GA5999@linux-sh.org>
References: <1201733446499-git-send-email-saeed.bishara@gmail.com> <12017334492566-git-send-email-saeed.bishara@gmail.com> <47A34E8A.6020007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pip15.gyao.ne.jp ([61.122.117.253]:18498 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753414AbYBASsP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 13:48:15 -0500
Content-Disposition: inline
In-Reply-To: <47A34E8A.6020007@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: saeed.bishara@gmail.com, linux-ide@vger.kernel.org, saeed@marvell.com, htejun@gmail.com, liml@rtr.ca, Saeed Bishara <saeed@il.marvell.com>

On Fri, Feb 01, 2008 at 11:53:30AM -0500, Jeff Garzik wrote:
> saeed.bishara@gmail.com wrote:
> >--- /dev/null
> >+++ b/include/linux/sata_mv.h
> >@@ -0,0 +1,21 @@
> >+/*
> >+ * Marvell integrated SATA platfrom device data definition file.
> >+ *
> >+ * Saeed Bishara <saeed@marvell.com>
> >+ *
> >+ * This file is licensed under the terms of the GNU General Public
> >+ * License version 2. This program is licensed "as is" without any
> >+ * warranty of any kind, whether express or implied.
> >+ */
> >+
> >+#ifndef __LINUX_SATA_MV_H__
> >+#define __LINUX_SATA_MV_H__
> >+
> >+/*
> >+ * Sata private data
> >+ */
> >+struct mv_sata_platform_data {
> >+	int	n_ports; /* number of sata ports */
> >+};
> >+
> >+#endif
> 
> Overall, the patch is OK, but I fear adding way too many of these tiny 
> includes, for each platform.
> 
> Unless Paul M objects (pata_platform maintainer), I will rename 
> linux/pata_platform.h to linux/ata_platform.h, and we can put your 
> mv_sata_platform_data structure in there.
> 
No objections from me, feel free to make the best use you can out of
what's there.
