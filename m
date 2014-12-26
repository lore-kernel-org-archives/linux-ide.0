From: "tj@kernel.org >> Tejun Heo" <tj@kernel.org>
Subject: Re: Question about mv_print_info in sata_mv.c in sata_mv.c
Date: Fri, 26 Dec 2014 16:11:14 -0500
Message-ID: <20141226211114.GA10889@htj.dyndns.org>
References: <5498E9E4.4040308@gmail.com>
 <CAL_JsqKQYuZJBCPO7KTS3C=ef3_Z3KjMsJ4Foo=zJhS-XT+DMw@mail.gmail.com>
 <549DCDC3.3040207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:57339 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbaLZVLS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Dec 2014 16:11:18 -0500
Content-Disposition: inline
In-Reply-To: <549DCDC3.3040207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: Rob Herring <robherring2@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello, Nick.

On Fri, Dec 26, 2014 at 04:06:11PM -0500, nick wrote:
> I am assuming after reading this function's code, that this function is completed and no longer
> needs a fix me comment above it to be completed.

I do appreciate that you're studying the FIXME comments but at this
point I'm not sure whether blindly chasing them and asking people
whether they're still necessary is a productive thing to do.  If
they're actively misleading, sure, let's remove them, but FIXME in a
sata_mv function which prints some controller identification
information just doesn't matter.  If you can assert that the comment
is no longer necessary and misleading, please submit a patch with
backing rationale; otherwise, obsessing with each instance of FIXME
comment doesn't seem to be a particularly productive way of
participating in kernel development.

Thanks.

-- 
tejun
