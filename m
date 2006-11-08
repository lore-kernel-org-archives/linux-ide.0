From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19-rc4-mm2] sata_sis: slave support on SiS965
Date: Wed, 08 Nov 2006 08:24:41 -0500
Message-ID: <4551DA99.1000401@garzik.org>
References: <200611080957.00349.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58500 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965728AbWKHNYp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 08:24:45 -0500
In-Reply-To: <200611080957.00349.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Uwe Koziolek wrote:
> SiS965 and SiS180 chips must support slave mode,
> SiS965L and SiS964 chips must not support slave mode.
> 
> SCR_STATUS for SATA ports in powerdown state fixed.
> Now returning 0x0113 instead of 0x0117. Avoids problem
> on detecting sata_sis controller.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

applied


