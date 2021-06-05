Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F75C48BC2
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 00:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7D261208
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 00:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhFEA0I (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Jun 2021 20:26:08 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47850 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhFEA0E (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2021 20:26:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 903B723F62;
        Fri,  4 Jun 2021 20:24:15 -0400 (EDT)
Date:   Sat, 5 Jun 2021 10:24:26 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
In-Reply-To: <3ee560b9-2f87-5cf8-cc6-e1c34eea7cef@linux-m68k.org>
Message-ID: <9f98cf13-169a-b7e-b594-8bba9bc9a0fc@linux-m68k.org>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com> <1622611267-15825-1-git-send-email-schmitzmic@gmail.com> <1622611267-15825-2-git-send-email-schmitzmic@gmail.com> <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com> <CAMuHMdU5ebmsErLdy6EykCHNULsBVFCpVsz0H3gpTLUmH1tt7g@mail.gmail.com> <28042fd1-4a54-af21-347f-165b8e4e63b4@gmail.com> <3ee560b9-2f87-5cf8-cc6-e1c34eea7cef@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Sat, 5 Jun 2021, I wrote:

> 
> Anyway, I see that we can already write this:
> 
> #define IS_MULTI(a,b) __or(IS_ENABLED(a), IS_ENABLED(b))
> 

Oops. The 2-way case would be,
#define IS_MULTI(a,b) __and(IS_ENABLED(a), IS_ENABLED(b))

> So maybe we just need an exclusive-OR macro to go with the other operators 
> defined in include/linux/kconfig.h? Then we could write this:
> 
> #define IS_SINGLE(a,b) __xor(IS_ENABLED(a), IS_ENABLED(b))
> 
> But these only work for a 2-way group. Extending them to N-way groups is 
> beyond my CPP abilities. It probably requires N-way __or() and __xor()...
> 

For the 3 way case, 
#define IS_SINGLE(a,b,c) (__xor(IS_ENABLED(a), IS_ENABLED(b), IS_ENABLED(c)) &&
                          !__and(IS_ENABLED(a), IS_ENABLED(b), IS_ENABLED(c)))
#define IS_MULTI(a,b,c) (!IS_SINGLE(a,b,c) &&
                         __or(IS_ENABLED(a), IS_ENABLED(b), IS_ENABLED(c)))
