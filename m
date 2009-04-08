From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: libata errors
Date: Wed, 8 Apr 2009 10:14:31 +0200
Message-ID: <18908.23783.745239.601473@pilspetsen.it.uu.se>
References: <4b215b9d0904071340w16a65b5bs64f6161b6042b4f1@mail.gmail.com>
	<49DBC889.3080304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:39398 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757618AbZDHIOl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 04:14:41 -0400
In-Reply-To: <49DBC889.3080304@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matt Grice <mcjgrice@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik writes:
 > If its ahci, try using ata_piix.  I am beginning to think that ATAPI on 
 > AHCI is broken.

I use a SATAPI DVD-writer on AHCI (Intel 965) on a semi-regular
basis, and it's never had any issues with recent 2.6.2x kernels.
