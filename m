From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: OCZ Vertex can't do HPA
Date: Wed, 12 Aug 2009 06:25:49 -0400
Message-ID: <4A8298AD.1040704@garzik.org>
References: <4A7B0BE3.9050707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52528 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932464AbZHLKZv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Aug 2009 06:25:51 -0400
In-Reply-To: <4A7B0BE3.9050707@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, probe@spray.se, stable@kernel.org

Tejun Heo wrote:
> OCZ Vertex SSD can't do HPA and not in a usual way.  It reports HPA,
> allows unlocking but then fails all IOs which fall in the unlocked
> area.  Quirk it so that HPA unlocking is not used for the device.
> 
> Reported by Daniel Perup in bnc#522414.
> 
>  https://bugzilla.novell.com/show_bug.cgi?id=522414
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Daniel Perup <probe@spray.se>
> ---
>  drivers/ata/libata-core.c |    3 +++
>  1 file changed, 3 insertions(+)

applied


