From: Tejun Heo <tj@kernel.org>
Subject: Re: System lockup with misc ATAPI commands on VT6415
Date: Mon, 1 Aug 2016 11:01:30 -0400
Message-ID: <20160801150130.GC2542@mtj.duckdns.org>
References: <20160801002718.38a0d88d@raspberrypi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34963 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbcHAPB6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Aug 2016 11:01:58 -0400
Received: by mail-qk0-f180.google.com with SMTP id s63so147965197qkb.2
        for <linux-ide@vger.kernel.org>; Mon, 01 Aug 2016 08:01:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160801002718.38a0d88d@raspberrypi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Kandaurov <aakandaurov@yandex.ru>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Alexander.

On Mon, Aug 01, 2016 at 12:27:18AM +0500, Alexander Kandaurov wrote:
> A possible fix to this issue could be using PIO for the misc ATAPI
> commands for this controller as is done in sata_promise.c, but what
> confuses me here is that two other systems perform well in similar
> conditions, so this could possibly be specifically some Linux bug.

Thanks a lot for the detailed investigation.  It could well be some
peculiarities from the way linux driver behave but given how long the
controller has been out of production, I'd be completely happy with a
crude PIO hammer fix.  It's not like these misc commands benefit a lot
from DMA anyway.

Thanks.

-- 
tejun
