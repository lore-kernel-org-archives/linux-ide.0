From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: reorder ata_queued_cmd to remove alignment padding
 on 64 bit builds
Date: Fri, 17 Sep 2010 02:13:19 -0400
Message-ID: <4C9306FF.70202@pobox.com>
References: <1284117583.1903.8.camel@castor.rsk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34952 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab0IQGNX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2010 02:13:23 -0400
In-Reply-To: <1284117583.1903.8.camel@castor.rsk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Kennedy <richard@rsk.demon.co.uk>
Cc: Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On 09/10/2010 07:19 AM, Richard Kennedy wrote:
> Reorder structure ata_queued_cmd to remove 8 bytes of alignment padding
> on 64 bit builds&  therefore reduce the size of structure ata_port by
> 256 bytes.
>
> Overall this will have little impact, other than reducing the amount of
> memory that is cleared when allocating ata_ports.
>
> Signed-off-by: Richard Kennedy<richard@rsk.demon.co.uk>
> ----
> patch against 2.6.36-rc3
> compiled&  tested on x86_64
>
> I've been running this patch for a couple of weeks with no apparent
> issues.
>
> regards

applied


