From: Tejun Heo <htejun@gmail.com>
Subject: Re: ahci rmmodable and shouldn't
Date: Sun, 19 Sep 2010 14:32:36 +0200
Message-ID: <4C9602E4.4090007@gmail.com>
References: <201009162256.04765.pedrogfrancisco@gmail.com> <47010.148.87.67.141.1284674336.squirrel@www.xenotime.net> <4C933A8F.2080305@gmail.com> <1284892106.2650.4.camel@sundae-v2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34009 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab0ISMbJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Sep 2010 08:31:09 -0400
In-Reply-To: <1284892106.2650.4.camel@sundae-v2>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pedro Francisco <pedrogfrancisco@gmail.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On 09/19/2010 12:28 PM, Pedro Francisco wrote:
> On Sex, 2010-09-17 at 11:53 +0200, Tejun Heo wrote:
>> Just don't rmmod a module which is serving a live filesystem.  Why
>> does it even matter?
>=20
> ... Ok, let me argue another way. What if my mail was called: =C2=ABl=
smod
> shows false values ("Used by: 0") for module 'ahci'=C2=BB, would you =
agree it
> was an error and should therefore be fixed?

I think it works the same way for any other SCSI driver and it's
pretty convenient during development.  You can unload any network
driver module while the network is still up too.  Module reference
count doesn't have any specific meaning of 'use' preassigned other
than it's there to prevent unloading module while the code and data
are being actively used by the processor.  It's unfortunate that the
way module reference count is used for libata is causing discomfort to
you but I need much better reason to change it.

Thanks.

--=20
tejun
