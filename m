From: Andrew Victor <avictor.za@gmail.com>
Subject: Re: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Tue, 3 Feb 2009 22:27:04 +0200
Message-ID: <cd73a99e0902031227x678ebfa3h14207aeaf00a406c@mail.gmail.com>
References: <200902031147.41822.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:42263 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZBCU1I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Feb 2009 15:27:08 -0500
Received: by ewy14 with SMTP id 14so2828376ewy.13
        for <linux-ide@vger.kernel.org>; Tue, 03 Feb 2009 12:27:05 -0800 (PST)
In-Reply-To: <200902031147.41822.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

hi Stanislaw,

> +void __init at91_add_device_ide(struct at91_ide_data *data)
> +{

This platform initialization code is virtually identical to the
at91_cf version submitted by Uros Bizjak, albeit for the SAM9260.
Similarly the "at91_cf_data" and "at91_ide_data" structs.

Wouldn't it be better to have a single CF initialization function, and
you specify whether you want "plain CF" mode or True-IDE mode?
You could even pass the same platform-resources structure (ie,
base-address of CF region), and have at91_ide setup the location of
the task-file and control registers from that base address.


Regards,
  Andrew Victor
