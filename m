From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 52821] ata_piix ATA_HOST_IGNORE_ATA for Hyper-V also affects
 Virtual PC 7
Date: Sat, 19 Jan 2013 00:35:42 +0000 (UTC)
Message-ID: <20130119003542.15DA011F9D8@bugzilla.kernel.org>
References: <bug-52821-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55157 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab3ASAfq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2013 19:35:46 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5B184202D4
	for <linux-ide@vger.kernel.org>; Sat, 19 Jan 2013 00:35:44 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id C51FE202B6
	for <linux-ide@vger.kernel.org>; Sat, 19 Jan 2013 00:35:42 +0000 (UTC)
In-Reply-To: <bug-52821-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D52821





--- Comment #1 from Andreas <linuxuser330250@gmx.net>  2013-01-19 00:35=
:41 ---
I=E2=80=99ve just found that the kernel parameter ata_piix.prefer_ms_hy=
perv=3D0 works,
but it is a very inconvenient way to work around this problem.

On the other hand, who is still using PowerPC-based Macs with Microsoft=
 Virtual
PC 7.0 and with modern Linux distributions?

As long as this parameter to disable the Hyper-V patch is there, at lea=
st it
does work with a little extra work.

Still, if there is a way to cleanly identify Hyper-V but not Virtual PC=
 7, this
would be great!

--=20
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Demai=
l
------- You are receiving this mail because: -------
You are watching the assignee of the bug.