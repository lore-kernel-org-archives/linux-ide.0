From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 0/3] ATA/ARM: convert ARM/DaVinci to use libata PATA
 drivers
Date: Tue, 21 Mar 2017 14:09:54 +0530
Message-ID: <969837fd-a5a6-5583-f463-60cf924a4372@ti.com>
References: <CGME20170314163738epcas5p3db719229d59550476c918a15d8c16d63@epcas5p3.samsung.com>
 <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:60509 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756786AbdCUIkr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2017 04:40:47 -0400
In-Reply-To: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tuesday 14 March 2017 10:06 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patchset adds Palmchip BK3710 IDE controller driver to
> libata and switches ARM/DaVinci to use it (instead of the old
> IDE driver).
> 
> Sekhar, please check that it still works after changes, thanks.

It looks like there are some comments pending. I would like to test
again after those are dispositioned. Hope thats fine.

Thanks,
Sekhar
