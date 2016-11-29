From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_mv: check for errors when parsing nr-ports
 from dt
Date: Tue, 29 Nov 2016 11:36:42 -0500
Message-ID: <20161129163642.GA19454@htj.duckdns.org>
References: <20161129111338.19389-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35411 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbcK2Qgo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Nov 2016 11:36:44 -0500
Received: by mail-yw0-f196.google.com with SMTP id b66so12653105ywh.2
        for <linux-ide@vger.kernel.org>; Tue, 29 Nov 2016 08:36:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161129111338.19389-1-u.kleine-koenig@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-ide@vger.kernel.org, kernel@pengutronix.de

On Tue, Nov 29, 2016 at 12:13:38PM +0100, Uwe Kleine-König wrote:
> If the nr-ports property is missing ata_host_alloc_pinfo is called with
> n_ports = 0. This results in host->ports[0] = NULL which later makes
> mv_init_host() oops when dereferencing this pointer.
> 
> Instead be a bit more cooperative and fail the probing with an error
> message.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied to libata/for-4.9-fixes.

Thanks.

-- 
tejun
