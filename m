From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Mon, 03 Sep 2007 21:40:56 +0900
Message-ID: <46DC00D8.30205@gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>	 <46DAB5DD.80807@gmail.com>	 <6f9550040709021129m63b143f5jdda365f6042560d5@mail.gmail.com>	 <46DB755C.308@gmail.com>	 <6f9550040709030340h42dfbce4ud5919dafde4e5b69@mail.gmail.com>	 <46DBF430.1050508@gmail.com>	 <6f9550040709030503m1d0db50bo4266aed0475f951d@mail.gmail.com> <6f9550040709030520q1682ca06k99a2537cae847ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:32866 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbXICMlE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 08:41:04 -0400
Received: by rv-out-0910.google.com with SMTP id k20so945102rvb
        for <linux-ide@vger.kernel.org>; Mon, 03 Sep 2007 05:41:02 -0700 (PDT)
In-Reply-To: <6f9550040709030520q1682ca06k99a2537cae847ec6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eddie Hung <eddie.hung@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Eddie Hung wrote:
> I am pursuing another possibility: the CF card is not a genuine
> Sandisk one at all, especially as it was off eBay! I compared my
> hdparm -I with the one in the thread above (which as I've found out is
> a Sandisk Extreme II 4GB) and there are big differences, namely the
> model number, serial number and firmware version.
> 
> This might explain everything!

We still need to fix your device.  :-)

-- 
tejun
