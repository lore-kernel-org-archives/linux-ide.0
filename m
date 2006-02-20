From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: blacklist update
Date: Mon, 20 Feb 2006 22:57:49 +0000
Message-ID: <1140476269.26526.45.camel@localhost.localdomain>
References: <1140449118.26526.21.camel@localhost.localdomain>
	 <43FA28CD.8080603@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:206 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932697AbWBTWyA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Feb 2006 17:54:00 -0500
In-Reply-To: <43FA28CD.8080603@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Llu, 2006-02-20 at 15:38 -0500, Jeff Garzik wrote:
> Could you gin up the same patch for libata?

Have done although its rather more invasive as the existing libata code
doesn't handle versions. Will push it when I've done some testing.


