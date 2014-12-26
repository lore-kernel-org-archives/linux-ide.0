From: Rob Herring <robherring2@gmail.com>
Subject: Re: Question about mv_print_info in sata_mv.c in sata_mv.c
Date: Fri, 26 Dec 2014 14:55:40 -0600
Message-ID: <CAL_JsqKQYuZJBCPO7KTS3C=ef3_Z3KjMsJ4Foo=zJhS-XT+DMw@mail.gmail.com>
References: <5498E9E4.4040308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:49064 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbaLZU4D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Dec 2014 15:56:03 -0500
In-Reply-To: <5498E9E4.4040308@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: "tj@kernel.org >> Tejun Heo" <tj@kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Dec 22, 2014 at 10:04 PM, nick <xerofoify@gmail.com> wrote:
> Greetings Tejuin,Grant and Rob,
> Hope you are having a good holidays. I am wondering if there is
> anything we need to add to this function as stated in a fix me above it.I am pretty certain
> there isn't but as the maintainers, I am double checking first with you:). Please let me
> known if you think of something.

Grant and I are not actually maintainers of this driver.
get_maintainer.pl is somewhat wrong here because it matches on regex
that is present in about every driver that is DT enabled. I've sent a
patch now to change that.

It would help also if you paste in the actually code you are referring to.

Rob

> Regards and Have a Great Holidays :),
> Nick
