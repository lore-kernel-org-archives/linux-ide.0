From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: How does libata handles an 'ATA_ABORTED' error?
Date: Fri, 16 Dec 2011 20:41:08 -0600
Message-ID: <CADLC3L1nLgM=f2YXf39s20N_JiLy8YZs=eO4kOtf3pvhFOA6iA@mail.gmail.com>
References: <201112140948.03859.jbe@pengutronix.de>
	<4EE98AF4.7090509@gmail.com>
	<201112151201.15044.jbe@pengutronix.de>
	<CADLC3L2MbPsoDuEMHeOiitU_NvARasKgaBCxdijgX=F744XyGA@mail.gmail.com>
	<4EEAC85C.1080501@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65109 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab1LQClJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Dec 2011 21:41:09 -0500
Received: by ghbz12 with SMTP id z12so2769332ghb.19
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2011 18:41:08 -0800 (PST)
In-Reply-To: <4EEAC85C.1080501@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Juergen Beisert <jbe@pengutronix.de>, linux-ide@vger.kernel.org

On Thu, Dec 15, 2011 at 10:26 PM, Mark Lord <kernel@teksavvy.com> wrote:
> On 11-12-15 01:38 PM, Robert Hancock wrote:
>> On Thu, Dec 15, 2011 at 5:01 AM, Juergen Beisert <jbe@pengutronix.de> wrote:
> ..
>>> As far as I understand the problem of this kind of errors is for the multi
>>> sector write case. The framework does not know what sectors fails, so the
>>> question is: does it repeat the whole multi sector sequence or what else it
>>> does?
>>
>> The entire request should get retried.
>
> I'm not so sure that is correct.
>
> The Linux IDE stack will not retry the completed sectors
> (those which were successfully transfered in multiple-sector blocks).
>
> Not sure what libata does here.

I don't know of any logic in libata that tries to do selective
retries. In many cases we wouldn't know where in the request it failed
in any case. There's no real reason to do this anyway as redoing a bit
of I/O after a device error shouldn't be a big deal.
