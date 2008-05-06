From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: again: [PATCH] libata: Add Intel SCH PATA Support
Date: Tue, 06 May 2008 10:18:37 -0400
Message-ID: <482068BD.3070006@pobox.com>
References: <20080505172356.636649e6@dxy.sh.intel.com> <481EE284.2010708@ru.mvista.com> <20080505224420.44730838@dxy.sh.intel.com> <481F2144.5000409@ru.mvista.com> <20080506094131.4bd70c8a@dxy.sh.intel.com> <48204A67.7070308@pobox.com> <20080506213141.06b86099@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39375 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799AbYEFOSr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 10:18:47 -0400
In-Reply-To: <20080506213141.06b86099@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Alek Du wrote:
> Hi Jeff, Alan, Sergei, Bartlomiej
> 
> Modified again according to your good comments! Hope this time it is ok. :-)
> 
> 
> From 7a7f6630e32b135f6d659db8e189748b4e7fd1a4 Mon Sep 17 00:00:00 2001
> From: Alek Du <alek.du@intel.com>
> Date: Mon, 5 May 2008 14:32:04 +0800
> Subject: [PATCH] libata: Add Intel SCH PATA Support
> 
> This patch adds Intel SCH chipsets (AF82US15W, AF82US15L, AF82UL11L) PATA controller
> support.
> 
> Signed-off-by: Alek Du <alek.du@intel.com>
> ---
>  drivers/ata/Kconfig    |    9 ++
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/pata_sch.c |  206 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/pata_sch.c

applied

for future reference, multiple revisions of patches are typically done like

   Subject: [PATCH v2] libata: Add Intel SCH PATA Support
   Subject: [PATCH v3] libata: Add Intel SCH PATA Support
   etc.


