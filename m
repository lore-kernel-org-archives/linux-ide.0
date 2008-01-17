From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] ata_piix: Add Toshiba Satellite R20 and
 Tecra M6 to broken suspend list.
Date: Thu, 17 Jan 2008 12:46:45 +0900
Message-ID: <478ECFA5.3040009@gmail.com>
References: <478EC3C1.8070007@bluetoad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:32395 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbYAQDqx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 22:46:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so415101rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 19:46:51 -0800 (PST)
In-Reply-To: <478EC3C1.8070007@bluetoad.com.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Schwenke <peter@bluetoad.com.au>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Peter Schwenke wrote:
> From: Peter Schwenke <peter@bluetoad.com.au>
> 
> Add Toshiba Satellite R20 and Tecra M6 to broken suspend list.  This is
> from OSDL bug 7780.
> 
> Signed-off-by: Peter Schwenke <peter@bluetoad.com.au>

Acked-by: Tejun Heo <htejun@gmail.com>

If Toshiba is still doing this for their new products.  We either need a
better way to blacklist them or contact and tell them to stop what
they're doing.  Does anyone have a Toshiba contact?

Thanks.

-- 
tejun
