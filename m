From: David Miller <davem@davemloft.net>
Subject: Re: drivers/ide/ide_platform.c: use resource_size()
Date: Mon, 23 Nov 2009 10:30:44 -0800 (PST)
Message-ID: <20091123.103044.203046617.davem@davemloft.net>
References: <BD79186B4FD85F4B8E60E381CAEE190901EE5C04@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58676
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165AbZKWSa0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 13:30:26 -0500
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901EE5C04@mi8nycmail19.Mi8.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hartleys@visionengravers.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Date: Mon, 23 Nov 2009 13:24:20 -0500

> Use resource_size() for devm_{ioremap/io_port_map}.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Also applied to ide-next-2.6, thanks.
