From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] palm_bk3710: fix IDECLK period calculation
Date: Tue, 8 Jul 2008 19:18:38 +0200
Message-ID: <200807081918.41190.bzolnier@gmail.com>
References: <200807081829.06199.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:32570 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbYGHRlM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2008 13:41:12 -0400
Received: by mu-out-0910.google.com with SMTP id w8so821610mue.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jul 2008 10:41:09 -0700 (PDT)
In-Reply-To: <200807081829.06199.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, mcherkashin@ru.mvista.com

On Tuesday 08 July 2008, Sergei Shtylyov wrote:
> The driver uses completely bogus rounding formula for calculating period from
> the IDECLK frequency which gives one-off period values (e.g. 11 ns with 100 MHz
> IDECLK) which in turn can lead to overclocked IDE transfer timings.  Actually,
> rounding is just wrong in this case, so use a mere division for a safe result.
> 
> While at it, also:
> 
> - give 'ide_palm_clk' variable a more suitable name;
> 
> - get rid of the useless 'ideclkp' variable;
> 
> - drop the LISP stype 'p' postfix from the 'clkp' variable's name. :-)
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied, thanks
