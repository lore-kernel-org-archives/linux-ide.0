From: Badalian Vyacheslav <slavon@bigtelecom.ru>
Subject: Re: Red leds at harddisk bays on SR1530HSH after update to 2.6.27.x
Date: Tue, 23 Dec 2008 09:32:25 +0300
Message-ID: <495085F9.5090805@bigtelecom.ru>
References: <494A34CA.9030906@bigtelecom.ru> <20081219223246.b0aea84d.akpm@linux-foundation.org> <494EF9A1.90002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.bigtelecom.ru ([87.255.0.61]:36800 "EHLO
	mail.bigtelecom.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbYLWGcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Dec 2008 01:32:31 -0500
In-Reply-To: <494EF9A1.90002@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Andrew Morton wrote:
>  =20
>> (cc linux-ide)
>>
>> On Thu, 18 Dec 2008 14:32:26 +0300 Badalian Vyacheslav <slavon@bigte=
lecom.ru> wrote:
>>
>>    =20
>>> Hello all.
>>> After update from 2.6.26 to 2.6.27 all leds at drive bays now red.
>>> SATA controller in AHCI mode.
>>> Platform is Intel SR1530HSH
>>>
>>> Config attached.
>>>
>>> Any patches for test? Any ideas? Any other info needed? Or i must g=
o to
>>> bugtracker? ;)
>>>      =20
>
> Does ahci.ahci_em_messages=3D0 help?
>
>  =20
All leds turned off. No green led at bay with hard disk.
