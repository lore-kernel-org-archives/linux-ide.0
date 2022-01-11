Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C47C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 11 Jan 2022 08:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348812AbiAKIKC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 11 Jan 2022 03:10:02 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:50397 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235115AbiAKIJ7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 11 Jan 2022 03:09:59 -0500
Received: from [192.168.0.5] (ip5f5aed25.dynamic.kabel-deutschland.de [95.90.237.37])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D400D61EA191E;
        Tue, 11 Jan 2022 09:09:58 +0100 (CET)
Message-ID: <2bc4b609-2111-34b1-8c0c-b69eca600c3e@molgen.mpg.de>
Date:   Tue, 11 Jan 2022 09:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: sata_link_debounce: Delays boot by 100 ms, hard coded as minimal
 debounce duration
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Dear Linux folks,


Trying to decrease Linux’ overall boot time, tracing 
`sata_link_resume()` with ftrace, it calls  `sata_link_debounce()` also 
in `drivers/ata/libata-sata.c`

     if ((rc = sata_link_debounce(link, params, deadline)))
     		return rc;

which runs a while loop, and takes the parameters defined in arrays at 
the top of the file.

     /* debounce timing parameters in msecs { interval, duration, 
timeout } */
     const unsigned long sata_deb_timing_normal[]            = {   5, 
100, 2000 };
     EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
     const unsigned long sata_deb_timing_hotplug[]           = {  25, 
500, 2000 };
     EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
     const unsigned long sata_deb_timing_long[]              = { 100, 
2000, 5000 };
     EXPORT_SYMBOL_GPL(sata_deb_timing_long);

const unsigned long sata_deb_timing_normal[]            = {   5,  100, 
2000 };

So the duration is set to 100 ms, which is quite a long time on current 
systems. At least on the Asus F2A85-M PRO that does not seem to be 
necessary. The motivation for adding these delays seems to be again 
broken controllers:

> Make sure SStatus of @link reaches stable state, determined by
> holding the same value where DET is not 1 for @duration polled every
> @interval, before @timeout.  Timeout constraints the beginning of the
> stable state.  Because DET gets stuck at 1 on some controllers after
> hot unplugging, this functions waits until timeout then returns 0 if
> DET is stable at 1.

As I neither know the SATA standard nor the Linux code well, do you have 
a suggestion how to improve that on controllers not needing such a long 
delay? Make the duration value configurable on Linux’ command line?


Kind regards,

Paul
