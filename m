From: Mathieu GELI <mathieu.geli@gmail.com>
Subject: Re: CF to SATA bridge support
Date: Sat, 8 Aug 2009 20:35:46 +0200
Message-ID: <43479bc90908081135i229d4061k9d461444d3600645@mail.gmail.com>
References: <43479bc90908071059o2ce5ac94v1d9d959e3af44326@mail.gmail.com>
	 <4A7CEF3B.9090506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:28093 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbZHHSfp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Aug 2009 14:35:45 -0400
Received: by qw-out-2122.google.com with SMTP id 8so881115qwh.37
        for <linux-ide@vger.kernel.org>; Sat, 08 Aug 2009 11:35:46 -0700 (PDT)
In-Reply-To: <4A7CEF3B.9090506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

> Hmm.. err_mask 0x2 seems to be HSM violation, and edma_err_cause=00001000
> seems to be.. IORDY timeout? Not sure what that is supposed to indicate on
> this controller..

Not sure what to think about the HSM violation but about the IORDY
timeout, does that [1] ring a bell ?
I think the clock is 150Mhz though.

[1] http://patchwork.ozlabs.org/patch/29080/

-- 
Mathieu
