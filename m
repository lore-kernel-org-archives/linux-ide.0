From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 0/4] ata: ahci_platform related cleanups
Date: Tue, 25 Mar 2014 15:17:45 -0400
Message-ID: <20140325191745.GB3279@htj.dyndns.org>
References: <1395773501-6663-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63723 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271AbaCYTRt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2014 15:17:49 -0400
Content-Disposition: inline
In-Reply-To: <1395773501-6663-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, spear-devel@list.st.com

On Tue, Mar 25, 2014 at 07:51:37PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series:
> - fixes ahci_platform_data->suspend() handling
> - moves library AHCI platform code to its own file
> - adds a new-style AHCI platform driver for DaVinci DA850 AHCI controller
> - updates DaVinci DA850 platform code
> 
> Changes since v3:
> - updated for ahci_xgene

Aplied 1-4 to libata/for-3.15.

Thanks!

-- 
tejun
