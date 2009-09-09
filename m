From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] libata: fix off-by-one error in ata_tf_read_block()
Date: Tue, 08 Sep 2009 21:19:33 -0400
Message-ID: <4AA702A5.9090800@pobox.com>
References: <20090815.224843.240484147.anemo@mba.ocn.ne.jp>	<4A876BC3.3020407@gmail.com> <20090816.183355.89035427.anemo@mba.ocn.ne.jp> <4A87F9C1.5090601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51565 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbZIIBTj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Sep 2009 21:19:39 -0400
In-Reply-To: <4A87F9C1.5090601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

On 08/16/2009 08:21 AM, Tejun Heo wrote:
> ata_tf_read_block() has off-by-one error when converting CHS address
> to LBA.  The bug isn't very visible because ata_tf_read_block() is
> used only when generating sense data for a failed RW command and CHS
> addressing isn't used too often these days.
>
> This problem was spotted by Atsushi Nemoto.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Atsushi Nemoto<anemo@mba.ocn.ne.jp>
> ---
>> Well, I expect fix by you (or other libata hackers) since I think you
>> can write better warning message and changelog than me ;)
>
> In that case, sure.  Thanks a lot for the nice spotting.  :-)
>
>   drivers/ata/libata-core.c |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

applied


