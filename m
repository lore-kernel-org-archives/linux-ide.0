From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Thu, 8 Apr 2010 23:00:25 -0300
Message-ID: <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<20100408144525.2f3f5718@lxorguk.ukuu.org.uk>
	<4bbdde49.e302be0a.3106.0220@mx.google.com>
	<20100408145916.50dbe8de@lxorguk.ukuu.org.uk>
	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	<20100408150920.5689564b@lxorguk.ukuu.org.uk>
	<4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	<4BBE6CA6.1010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54864 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab0DICBR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 22:01:17 -0400
Received: by gwb19 with SMTP id 19so1527635gwb.19
        for <linux-ide@vger.kernel.org>; Thu, 08 Apr 2010 19:01:16 -0700 (PDT)
In-Reply-To: <4BBE6CA6.1010808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Thu, 08 Apr 2010 17:54:14 -0600
Robert Hancock <hancockrwd@gmail.com> wrote:

> Depends on a lot of things, and what you mean by "significant". You 
> don't get NCQ in legacy mode, and you also don't get 64-bit DMA support, 
> which gets more significant the more RAM you have.

	I understand Robert. Ok, by significant I mean "better" and
"faster".

	So there's no NCQ in legacy mode? But you wrote that
regarding just the ICH chipset or all chipsets? Because I remember when
I used the forcedeth driver there was NCQ.

	Thank you very much.

-- 
