From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
Date: Wed, 15 Jan 2014 07:44:40 -0500
Message-ID: <20140115124440.GA7950@htj.dyndns.org>
References: <1389726281-8731-1-git-send-email-simon.guinot@sequanux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:37491 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbaAOMor (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jan 2014 07:44:47 -0500
Content-Disposition: inline
In-Reply-To: <1389726281-8731-1-git-send-email-simon.guinot@sequanux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, stable@vger.kernel.org

On Tue, Jan 14, 2014 at 08:04:38PM +0100, Simon Guinot wrote:
> Hello,
> 
> This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
> SoCs: once a disk is removed from a SATA port, then the re-plug events
> are not detected by the sata_mv driver.
> 
> As this hotplug issue have been emphasized by 9ae6f740b49f
> "arm: mach-mvebu: add support for Armada 370 and Armada XP with DT",
> then this patches should be applied to the -stable kernels 3.6 and
> onwards.

Applied to libata/for-3.14.

Thanks.

-- 
tejun
