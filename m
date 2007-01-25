From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: share PIO limits among devices sharing a channel
Date: Thu, 25 Jan 2007 22:30:07 +0900
Message-ID: <45B8B0DF.4080602@gmail.com>
References: <20070125112947.GC8606@htj.dyndns.org> <20070125123030.3093fb32@localhost.localdomain> <45B8A63F.8060305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:8297 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965152AbXAYNaQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 08:30:16 -0500
Received: by an-out-0708.google.com with SMTP id b33so331259ana
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 05:30:15 -0800 (PST)
In-Reply-To: <45B8A63F.8060305@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Alan wrote:
>> On Thu, 25 Jan 2007 20:29:47 +0900
>> Tejun Heo <htejun@gmail.com> wrote:
>>
>>> PIO xfermask limits should be shared by all devices on the same
>>> channel to avoid violating device selection timing.  libata used to
>>
>> NAK, this is totally wrong

Eek.. You actually said this is/was documented and relied upon all over.

http://thread.gmane.org/gmane.linux.ide/13184/focus=14486

(searching mailboxes more...)  Oh, and the dropping of common PIO mode
selection was agreed upon by Jeff and Alan.

One way or the other, this only affects PATA devices and as long as all
PATA LLDs guarantee that selection timing isn't violated, this can go.
I thought PATA drivers still relied on this common denominator PIO mode
configuration.  I think it's Alan's call.

> I'm curious what the motivation of this patch was?

Hope my intentions are explained.

Thanks.

-- 
tejun
