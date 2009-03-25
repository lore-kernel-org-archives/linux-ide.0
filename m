From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-core More robust parsing for multi_count(v5)
Date: Tue, 24 Mar 2009 22:40:28 -0400
Message-ID: <49C9999C.8080707@pobox.com>
References: <49C1047D.4000008@rtr.ca> <49C11A0C.3070502@rtr.ca> <49C11ED4.2030307@rtr.ca> <49C19087.5000307@gmail.com> <49C190F1.7010202@kernel.org> <49C28133.8050401@rtr.ca> <49C281A5.5080404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36687 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102AbZCYCkm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 22:40:42 -0400
In-Reply-To: <49C281A5.5080404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

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
> ---
> 
> Fixed duplicate patch found in v4.
> Updated to use is_power_of_2() as suggested by Tejun.

applied


