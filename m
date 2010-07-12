From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: HDD not suspending properly / dead on resume
Date: Mon, 12 Jul 2010 17:35:06 +0200
Message-ID: <201007121735.07244.maciej.rutecki@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34285 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0GLPfZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jul 2010 11:35:25 -0400
In-Reply-To: <201007091750.05020.stephan.diestelhorst@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@lists.osdl.org, stephan.diestelhorst@gmail.com

On pi=C4=85tek, 9 lipca 2010 o 17:50:04 Stephan Diestelhorst wrote:
> Hi,
>   I have n issue with suepnd to RAM and I/O load on a disk. Symptoms
> are that the disk does not respond to requests when woken up, produci=
ng
> only I/O errors on all tested kernels (newest 2.6.35-rc4 (Ubuntu
> mainline PPA build)):
>=20

I created a Bugzilla entry at=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D16370
for your bug report, please add your address to the CC list in there, t=
hanks!

--=20
Maciej Rutecki
http://www.maciek.unixy.pl
