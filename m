From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC 7/9] libata: pdc_freeze() semantic change
Date: Mon, 18 Jun 2007 14:14:55 +0900
Message-ID: <467614CF.5070006@gmail.com>
References: <46720353.90209@tw.ibm.com> <467207BF.9020409@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:16283 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbXFRFPA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 01:15:00 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2037580wah
        for <linux-ide@vger.kernel.org>; Sun, 17 Jun 2007 22:15:00 -0700 (PDT)
In-Reply-To: <467207BF.9020409@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, Mikael Pettersson <mikpe@it.uu.se>

Albert Lee wrote:
> Patch 7/9:
> 
>  After checking the current implementations of freeze()/thaw(), it seems only pdc_freeze()
> do more than simple irq masking. Remove the DMA disable code from pdc_freeze().
> 
> The question is the design/semantic of freeze()/thaw().
> Maybe we should limit them to simple irq on/off?

Yeap, we can do that but if we do so it would be better to use
->irq_off/->irq_on hooks and kill ->freeze/->thaw.

-- 
tejun
