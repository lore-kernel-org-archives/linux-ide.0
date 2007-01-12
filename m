From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
	libata-core.c
Date: Fri, 12 Jan 2007 11:55:44 +1100
Message-ID: <1168563344.22458.430.camel@localhost.localdomain>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
	 <200701111008.34866.arnd@arndb.de>
	 <200701110928.l0B9SUri015056@toshiba.co.jp>
	 <20070111171706.GG6177@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55879 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbXALA6K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jan 2007 19:58:10 -0500
In-Reply-To: <20070111171706.GG6177@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org


> Why is it that other drivers did not need this functions? Did they
> copy them?  Or maybe they don't need them?

Most drivers can use the common functions as is. The problem starts when
you need special mecanisms to access the taskfile registers.

Ben.


