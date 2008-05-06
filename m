From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add Intel SCH PATA Support
Date: Tue, 6 May 2008 12:44:48 +0100
Message-ID: <20080506124448.1415c17c@core>
References: <20080505172356.636649e6@dxy.sh.intel.com>
	<481EE284.2010708@ru.mvista.com>
	<20080505224420.44730838@dxy.sh.intel.com>
	<481F2144.5000409@ru.mvista.com>
	<20080506094131.4bd70c8a@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36860 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750869AbYEFLyC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 07:54:02 -0400
In-Reply-To: <20080506094131.4bd70c8a@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org

> +	/* no hotplugging support (FIXME) */
> +	if (!in_module_init)
> +		return -ENODEV;

I see no reason for this check ? AHCI/PIIX sometimes need this because
they rely on BIOS set values [and nobody has fixed it to only check on
those chips]. Your new driver seems clean of such cases.

Alan
