From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Date: Sat, 1 Dec 2007 21:59:09 -0600
Message-ID: <20071202035909.GB3116@lixom.net>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153908.GB14183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:41629 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753998AbXLBDza (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 22:55:30 -0500
Content-Disposition: inline
In-Reply-To: <20071127153908.GB14183@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Tue, Nov 27, 2007 at 06:39:08PM +0300, Anton Vorontsov wrote:

> +static struct of_device_id pata_of_platform_match[] = {
> +	{ .compatible = "pata-platform", },
> +};

On top of previous comment about the compatible string being
inappropriate:

You should add a MODULE_DEVICE_TABLE() entry for this. Dave Woodhouse
pointed out it's needed for autoloading modules (i.e. by the fedora
installer, etc).


-Olof

