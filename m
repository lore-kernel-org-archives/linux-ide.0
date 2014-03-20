From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 4/4] ata: add new-style AHCI platform driver for ST
 SPEAr1340 AHCI controller
Date: Thu, 20 Mar 2014 12:51:32 +0100
Message-ID: <3482323.3pWPcG8rCe@amdc1032>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
 <1395081118-15248-5-git-send-email-b.zolnierkie@samsung.com>
 <20140320085717.GC4607@pratyush-vbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27686 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757082AbaCTLvv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2014 07:51:51 -0400
In-reply-to: <20140320085717.GC4607@pratyush-vbox>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pratyush Anand <pratyush.anand@st.com>
Cc: Tejun Heo <tj@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@gmail.com>, Mohit Kumar <mohit.kumar@st.com>, Arnd Bergmann <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, spear-devel <spear-devel@list.st.com>


Hi,

On Thursday, March 20, 2014 02:27:17 PM Pratyush Anand wrote:
> On Tue, Mar 18, 2014 at 02:31:58AM +0800, Bartlomiej Zolnierkiewicz wrote:
> > The new driver is named ahci_spear1340 and is only compile tested.  Once
> > it is tested on the real hardware and verified to work correctly, the legacy
> > platform code (which depends on the deprecated struct ahci_platform_data)
> > can be removed.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> This patch will not be needed any more, since SPEAr sata platform code has
> already been cleaned up.
> 
> See:
> https://lkml.org/lkml/2014/2/28/174

OK.  Conversion of SPEAr1340 AHCI platform code to PHY driver is even better
than adding custom AHCI driver.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

