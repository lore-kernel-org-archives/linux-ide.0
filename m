From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata#upstream] sata_promise: fix error decode regression
Date: Mon, 09 Apr 2007 16:52:53 +0900
Message-ID: <4619F0D5.1020908@gmail.com>
References: <200704071229.l37CTp6M010861@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:48572 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbXDIHw7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 03:52:59 -0400
Received: by nz-out-0506.google.com with SMTP id s1so973660nze
        for <linux-ide@vger.kernel.org>; Mon, 09 Apr 2007 00:52:59 -0700 (PDT)
In-Reply-To: <200704071229.l37CTp6M010861@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Promise ATA ports should always be reset by pdc_reset_port()
> when errors are detected, but the recent error reason decoding
> update to sata_promise replaced that reset with a freeze.
> 
> This patch changes the error detection to do a reset again.
> This makes the error decoding update safer, as it now only
> adds error decoding without changing any other behaviour.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Not necessarily NAK'ing but I think it's better to do things like that
in EH thread not in the interrupt handler.  Isn't freezing enough in the
interrupt handler?

Thanks.

-- 
tejun
