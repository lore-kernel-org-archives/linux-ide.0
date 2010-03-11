From: Justin Maggard <jmaggard10@gmail.com>
Subject: Re: WDC WD15EARS-00Z5B1: harddrive which does crazy unloading
Date: Thu, 11 Mar 2010 11:10:41 -0800
Message-ID: <150c16851003111110v558e852al78934cd200cb57ca@mail.gmail.com>
References: <201002081933.10144.suse-linux@ml082.pinguin.uni.cc>
	 <4B96013F.1050904@kernel.org> <4B965DE7.7000109@teksavvy.com>
	 <4B9881C8.10506@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50728 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758070Ab0CKTKm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 14:10:42 -0500
Received: by pwi1 with SMTP id 1so194789pwi.19
        for <linux-ide@vger.kernel.org>; Thu, 11 Mar 2010 11:10:41 -0800 (PST)
In-Reply-To: <4B9881C8.10506@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <kernel@teksavvy.com>, Al Bogner <suse-linux@ml082.pinguin.uni.cc>, linux-ide@vger.kernel.org

On Wed, Mar 10, 2010 at 9:38 PM, Tejun Heo <tj@kernel.org> wrote:
> On 03/09/2010 11:40 PM, Mark Lord wrote:
>> The wdidle3-1.03 DOS tool can fix that. =A0Google it.
>>
>> I have disassembled that tool here, and found a few
>> vendor-unique commands inside it. =A0But thus far have
>> not managed to get them working natively in Linux.
>>
>> I really need a SATA tracer/analyser..
>
> Hmmm... so they don't respond to ATA APM command?

I believe only the enterprise-class models do.  The desktop class
drives, from what I've seen, don't.

-Justin
