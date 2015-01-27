From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] ata: Use 64-bit timekeeping
Date: Tue, 27 Jan 2015 11:08:02 -0500
Message-ID: <20150127160802.GA12314@htj.dyndns.org>
References: <20150127101948.GA5656@tinar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:42836 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639AbbA0QIH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2015 11:08:07 -0500
Received: by mail-qc0-f182.google.com with SMTP id l6so12676436qcy.13
        for <linux-ide@vger.kernel.org>; Tue, 27 Jan 2015 08:08:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150127101948.GA5656@tinar>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tina Ruchandani <ruchandani.tina@gmail.com>
Cc: linux-ide@vger.kernel.org, arnd@arndb.de

On Tue, Jan 27, 2015 at 03:49:48PM +0530, Tina Ruchandani wrote:
> Function pdc_detect_pll_input_clock uses 'struct timeval'
> to measure start and end times, used to compute the pll_clock value.
> 'struct timeval' on 32-bit systems will have its tv_sec field
> overflow in year 2038 and beyond. This patch uses 'ktime_t'
> (which uses 64 bits for seconds) for start and end times instead.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>

Applied to libata/for-3.20 w/ subject updated to indicate that its
scope is pata_pdc2027x.

Thanks.

-- 
tejun
