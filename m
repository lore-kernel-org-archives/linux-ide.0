From: Justin Maggard <jmaggard10@gmail.com>
Subject: Re: Hotplug issue with Marvell 6121
Date: Thu, 11 Mar 2010 10:42:35 -0800
Message-ID: <150c16851003111042r1ccc5e2bv3649f9817c36ad9a@mail.gmail.com>
References: <150c16851003091651r4ce4259v693f1310d0aa95ef@mail.gmail.com>
	 <150c16851003101446m633ad174tc784a94e2a2a5a5b@mail.gmail.com>
	 <4B983F08.6080701@gmail.com> <4B9840D3.7050109@kernel.org>
	 <150c16851003101832o358a8b4aj760384020658d1fc@mail.gmail.com>
	 <4B98647C.6010604@teksavvy.com> <4B986745.305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:58056 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758054Ab0CKSmg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 13:42:36 -0500
Received: by pzk32 with SMTP id 32so189439pzk.4
        for <linux-ide@vger.kernel.org>; Thu, 11 Mar 2010 10:42:35 -0800 (PST)
In-Reply-To: <4B986745.305@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <kernel@teksavvy.com>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On Wed, Mar 10, 2010 at 7:45 PM, Tejun Heo <tj@kernel.org> wrote:
> On 03/11/2010 12:33 PM, Mark Lord wrote:
>> If it's like their non-AHCI controllers (sata_mv), then the chipset/=
phy
>> could be very particular about the sequence/timing used when changin=
g
>> speeds.

This is certainly possible.  The 6121 has a PATA port, and can be used
with the sata_mv driver also.

> BTW, if not allowing PHY speed adjustment is necessary, the correct
> way to implement that is in ->port_start() by modifying
> link->hw_sata_spd_limit. =A0But I really hope there's some other way =
to
> solve this.

I assume you're talking about setting hw_sata_spd_limit to 1.5Gbps so
that sata_down_spd_limit() doesn't do anything?  That will work, but
it would still be nice to be able to run at 3.0Gbps on these ports.

If anyone has any more elegant solutions they would like me to test,
just let me know.

Thanks,
-Justin
