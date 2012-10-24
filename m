From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Wed, 24 Oct 2012 06:43:10 +0000 (UTC)
Message-ID: <20121024064310.A9A5211FC43@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42818 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab2JXGnN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2012 02:43:13 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4E9B6202AF
	for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2012 06:43:12 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 75A022022B
	for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2012 06:43:11 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D49151





--- Comment #23 from Anton Boyarshinov <boyarsh@altlinux.org>  2012-10-=
24 06:43:10 ---
Hello

=D0=92 Tue, 23 Oct 2012 18:12:16 +0200
Borislav Petkov wrote:

> @Tejun: so basically there are two people with oopses when using
> pata_acpi
Not two. We have two boxes in our office (about 20 boxes) and more then
ten reports from our users (only from early adopters yet). It seems
that this problem doesn't exists when someone build kernel for his own
box, but will be triggered very often when 3.6 will be wide used distro
kernel.

--=20
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Demai=
l
------- You are receiving this mail because: -------
You are watching the assignee of the bug.