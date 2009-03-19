From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Fri, 20 Mar 2009 08:33:22 +0900
Message-ID: <49C2D642.90706@kernel.org>
References: <49C1047D.4000008@rtr.ca> <49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca> <49C19087.5000307@gmail.com> <49C190F1.7010202@kernel.org> <49C28133.8050401@rtr.ca> <49C281A5.5080404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33174 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757457AbZCSXdj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Mar 2009 19:33:39 -0400
In-Reply-To: <49C281A5.5080404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Mark.

Mark Lord wrote:
> Make libata more robust when parsing the multi_count
> field from a drive's identify data.  This prevents us from
> attempting to use dubious multi_count values ad infinitum.
> 
> Reset dev->multi_count to zero and reprobe it each time
> through this routine, as it can change on device reset.
> 
> Also ensure that the reported "maximum" value is valid
> and is a power of two, and that the reported "count" value
> is valid and also a power of two.  And that the "count"
> value is not greater than the "maximum" value.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

Acked-by: Tejun Heo <tj@kernel.org>

The patch looks safe to me although requiring power_of_2 on max seems
a bit too strict.  For configuration, ata_dev_configure() is the right
place.  I think the following should work.

* add dev->multi_limit which is initialized to -1 on ata_dev_init().

* during ata_dev_configure() if multi_limit < 0, set it to device max.

* set dev->multi to rounddown_pow_of_two(multi_limit) and issue
  SET_MULTI.

On EH side, ata_eh_speed_down() is the place to handle it.  It can
probably piggy back on ATA_EH_SPDN_SPEED_DOWN block.  All it has to do
is reducing dev->multi_limit.  dev_config will run later and apply it.
I'm not sure how the speed down strategy should exactly be tho.  It is
distinguisible from regular transfer errors?

Thanks.

-- 
tejun
