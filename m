From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: cosmetic changes in ata_bus_softreset()
Date: Fri, 24 Mar 2006 23:04:38 -0500
Message-ID: <4424C156.5080508@pobox.com>
References: <20060324034556.GF25706@htj.dyndns.org> <44240337.8030509@pobox.com> <20060324160211.GA2806@htj.dyndns.org> <44242B97.30706@pobox.com> <20060324175813.GA20709@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10646 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750764AbWCYEEl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 23:04:41 -0500
In-Reply-To: <20060324175813.GA20709@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_bus_softreset() should return AC_ERR_* on failure not arbitrary
> positive number.  While at it, reformat comment above it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Acked-by: Alan Cox <alan@redhat.com>

applied


