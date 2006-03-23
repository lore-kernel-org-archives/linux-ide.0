From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: do not ignore PIO-only devices
Date: Wed, 22 Mar 2006 19:58:26 -0500
Message-ID: <4421F2B2.5000700@pobox.com>
References: <4420B439.6000608@comcast.net> <20060322114818.GA23515@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57243 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932108AbWCWA63 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2006 19:58:29 -0500
In-Reply-To: <20060322114818.GA23515@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ed Sweetman <safemode@comcast.net>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> As libata now can do PIO, don't ignore PIO-only devices.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


