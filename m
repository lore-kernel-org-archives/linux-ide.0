From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: 'hdparm -C' problems with libata-dev
Date: Tue, 12 Apr 2005 10:00:03 -0400
Message-ID: <20050412140002.GC27920@tuxdriver.com>
References: <42568F29.6020800@nv-systems.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:15632 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262354AbVDLOAL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Apr 2005 10:00:11 -0400
Content-Disposition: inline
In-Reply-To: <42568F29.6020800@nv-systems.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gerald Hopf <linux-ide@nv-systems.net>
Cc: linux-ide@vger.kernel.org

On Fri, Apr 08, 2005 at 04:03:21PM +0200, Gerald Hopf wrote:

> Is there anything i can do to make this ('hdparm -C') work? Is this a 
> libata bug or missing feature? A Seagate Firmware bug? A hdparm problem? 
> Or just not possible with SATA Drives?

Sounds like a bug w/ my implementation of HDIO_DRIVE_CMD for libata.
However, I have yet to take the opportunity to track it down.  Plus,
I'll be taking a little vacation over the coming weekend, so I likely
won't get to this until sometime next week... :-(

Until then, please feel free to experiment more w/ hdparm to see if
there are any other problems w/ hdparm on SATA.  Please copy me on
reports of any such problems (or send them to me directly).  Thanks!

John
-- 
John W. Linville
linville@tuxdriver.com
