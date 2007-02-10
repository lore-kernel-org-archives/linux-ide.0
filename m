From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [git patches] libata updates 1 of 3
Date: Sat, 10 Feb 2007 06:46:29 +0100
Message-ID: <20070210054629.GA4395@gentoox2.trippelsdorf.de>
References: <20070210010914.GA19717@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out-45.synserver.de ([217.119.50.45]:60080 "HELO
	smtp-out-45.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752711AbXBJFxX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Feb 2007 00:53:23 -0500
Content-Disposition: inline
In-Reply-To: <20070210010914.GA19717@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

This update breaks sata_via on my VIA K8T800Pro machine:
 
 sata_via 0000:00:0f.0 : failed to iomap PCI BAR 0
 sata_via 0000:00:0f.0 : out of memory
 sata_via probe of 0000:00:0f.0 failed with error -12
-- 
Markus
