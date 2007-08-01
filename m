From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: blacklist SAMSUNG HD401LJ / ZZ100-15 for NCQ
Date: Wed, 01 Aug 2007 10:02:16 -0400
Message-ID: <46B09268.2040203@garzik.org>
References: <20070728072525.GE22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41656 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932434AbXHAOCV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 10:02:21 -0400
In-Reply-To: <20070728072525.GE22374@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, stellplatz-nr.13a@datenparkplatz.de

Tejun Heo wrote:
> SAMSUNG HD401LJ / ZZ100-15 does spurious completion of NCQ commands.
> Disable NCQ.  Reported by Ulrich in bugzilla #8805.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Ulrich <stellplatz-nr.13a@datenparkplatz.de>
> ---
> And, finally one from samsung.  How come vendors got this right
> previously but screw up on new ones?
> 
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)

applied to #upstream-fixes


