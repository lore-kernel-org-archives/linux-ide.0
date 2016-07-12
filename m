From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-scsi: fix D_SENSE bit relection in control mode
 page
Date: Tue, 12 Jul 2016 14:39:05 -0400
Message-ID: <20160712183905.GA3190@htj.duckdns.org>
References: <57852a86.460b420a.faeba.0b28@mx.google.com>
 <CAGnHSEkwRipQ2ibUfPO1gr-Y7OQCsfyx=AuDbE1DaW-G1idCtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36268 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcGLSjP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 14:39:15 -0400
Content-Disposition: inline
In-Reply-To: <CAGnHSEkwRipQ2ibUfPO1gr-Y7OQCsfyx=AuDbE1DaW-G1idCtA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Yan <tom.ty89@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On Wed, Jul 13, 2016 at 01:45:21AM +0800, Tom Yan wrote:
> Btw, why is the MODE SELECT function called ata_mselect_control()
> while the MODE SENSE function is called ata_msense_ctl_mode()?
> Shouldn't we make their names consistent?

Sure, please go ahead.

Thanks.

-- 
tejun
