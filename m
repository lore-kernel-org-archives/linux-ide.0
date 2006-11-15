From: Pavel Roskin <proski@gnu.org>
Subject: Re: ata_piix on Thinkpad T30 - qc timeout on boot
Date: Wed, 15 Nov 2006 15:00:56 -0500
Message-ID: <1163620856.19441.1.camel@dv>
References: <1163563453.3100.24.camel@dv> <1163569390.4410.8.camel@dv>
	 <455AF614.1090109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:37833 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030720AbWKOUA7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 15:00:59 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1GkQwM-0003pu-MK
	for linux-ide@vger.kernel.org; Wed, 15 Nov 2006 15:00:58 -0500
In-Reply-To: <455AF614.1090109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 2006-11-15 at 20:12 +0900, Tejun Heo wrote:
> Fixed in libata-dev#upstream and will soon be included in -mm.  Please 
> read the following thread.

libata-dev#upstream is working fine for me.  No more delays on startup.
Thank you!

I hope it will get into 2.6.19.

-- 
Regards,
Pavel Roskin


