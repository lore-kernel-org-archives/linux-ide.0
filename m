From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: fix ARASAN CompactFlash PATA driver dependencies
Date: Wed, 26 Mar 2014 10:35:08 -0400
Message-ID: <20140326143508.GE7171@htj.dyndns.org>
References: <1565826.7Ejj6LS6x7@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:46508 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbaCZOfM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2014 10:35:12 -0400
Content-Disposition: inline
In-Reply-To: <1565826.7Ejj6LS6x7@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, linux-ide@vger.kernel.org, spear-devel@list.st.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Mar 26, 2014 at 03:33:37PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Make pata_arasan_cf host driver depend on ARCH_SPEAR13XX config
> option as ARASAN CompactFlash PATA support is specific to ST
> SPEAr13xx SoCs and the driver to work requires suitable device
> tree node (or platform device) to be defined.  Additionally
> allow the driver build if COMPILE_TEST config option is set.
> 
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.  Thanks.

-- 
tejun
