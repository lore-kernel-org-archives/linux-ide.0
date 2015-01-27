From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] ata: Use 64-bit timekeeping
Date: Tue, 27 Jan 2015 11:42:59 +0100
Message-ID: <2129071.xymq3JjTtL@wuerfel>
References: <20150127101948.GA5656@tinar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:60826 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbbA0KnG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2015 05:43:06 -0500
In-Reply-To: <20150127101948.GA5656@tinar>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tina Ruchandani <ruchandani.tina@gmail.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org

On Tuesday 27 January 2015 15:49:48 Tina Ruchandani wrote:
> Function pdc_detect_pll_input_clock uses 'struct timeval'
> to measure start and end times, used to compute the pll_clock value.
> 'struct timeval' on 32-bit systems will have its tv_sec field
> overflow in year 2038 and beyond. This patch uses 'ktime_t'
> (which uses 64 bits for seconds) for start and end times instead.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>

Looks great,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
