From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 11/15] libata: preserve SATA SPD setting over hard resets
Date: Sat, 01 Apr 2006 14:52:20 -0500
Message-ID: <442ED9F4.8030004@pobox.com>
References: <11438230983250-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:21725 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751449AbWDATwX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 14:52:23 -0500
In-Reply-To: <11438230983250-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Don't overwrite SPD setting during hard reset.  This change has the
> (intended) side effect of honoring the BIOS configuration.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied


