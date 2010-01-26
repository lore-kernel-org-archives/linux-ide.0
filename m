From: Alexey Lobanov <A.Lobanov@gctrials.com>
Subject: Re: sata_via.c next-20100125 unsuccess report
Date: Tue, 26 Jan 2010 15:57:22 +0300
Message-ID: <4B5EE6B2.5000908@gctrials.com>
References: <4B5EDC61.4050004@gctrials.com> <7eb6a4d81001260450j2351f3b4i3e91eb6602330c53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cro-rct.ru ([83.136.242.126]:51219 "EHLO rct.gctrials.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412Ab0AZM5Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jan 2010 07:57:24 -0500
In-Reply-To: <7eb6a4d81001260450j2351f3b4i3e91eb6602330c53@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart Hartgers <bart.hartgers@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello Bart,

Bart Hartgers =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> The change you refer to only affects the PATA-part of the vt6421, and
> you're trouble seems to be with the SATA port.=20

Yes. I see it now. My fail.

As far as I understand, the SATA issue is frosen since October 2009.

http://lkml.org/lkml/2009/10/11/36
http://lkml.org/lkml/2009/10/14/186

Alexey
