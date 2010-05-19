From: Jayaraman Thiruvady <jayaraman.tg@gmail.com>
Subject: SATA in Target Mode
Date: Wed, 19 May 2010 14:12:07 +0800
Message-ID: <AANLkTimLUIShHybcy51NThd2gtkQxFtXWCyVY2iee_c6@mail.gmail.com>
References: <AANLkTinSg70pTj2uwnHuB4xT1I88nNU06l080_m9vngl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40993 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab0ESGM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 02:12:29 -0400
Received: by iwn6 with SMTP id 6so2610699iwn.19
        for <linux-ide@vger.kernel.org>; Tue, 18 May 2010 23:12:28 -0700 (PDT)
In-Reply-To: <AANLkTinSg70pTj2uwnHuB4xT1I88nNU06l080_m9vngl@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jayaraman Thiruvady <jayaraman.tg@gmail.com>

Hi,

=A0=A0=A0=A0=A0 I am trying to make vdisk ( file disk ) to emulate as a=
 SATA
drive. To do so, i thought of making a SATA port to target mode and
cross wire it with another SATA port ( initiator) and by mapping the
SATA target mode port with vdisk, the SATA initiator must detect the
vdisk as some SATA device to perform further. Is such scenario doable?

Is the place where i can find more details on how much scenario is
achievable and the details Marvell SATA support as target mode in
kernel-tree and its info supported chipsets?.

Regards,
Jayaraman.T
