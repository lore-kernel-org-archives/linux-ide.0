From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Fri, 07 Sep 2007 02:50:46 +0900
Message-ID: <46E03DF6.8090405@gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>	 <46DAB5DD.80807@gmail.com> <46DEE72B.2060702@rtr.ca> <6f9550040709051503k5b0a07b1x3e21bae3667ce17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:58480 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbXIFRwL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 13:52:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so255533wah
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 10:52:11 -0700 (PDT)
In-Reply-To: <6f9550040709051503k5b0a07b1x3e21bae3667ce17@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eddie Hung <eddie.hung@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Eddie Hung wrote:
> However, I think we can conclude that ICH6M (which on the X41, has a
> SATA-PATA bridge to connect a PATA drive) does not seem to support
> MWDMA

It isn't clear whether the fault is at the driver or the CF device.

> (especially as it is not completely supported under Windows
> either - it is *incredibly* slow but does not give the same timeout
> problems as with libata),

Please verify which mode is in use in Windows.  Just watching cpu usage
in the task manager while transferring data should give you a pretty
good idea.

> nor does libata it drop down gracefully to
> PIO4 when it detects these timeouts.

Yeah, this is a bug to fix.

Thanks.

-- 
tejun
