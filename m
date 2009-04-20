From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [bug#12874] Seagate STT20000A no longer works
Date: Mon, 20 Apr 2009 11:30:08 +0200
Message-ID: <9ea470500904200230k5f0ea050u7411b7c9d9be7098@mail.gmail.com>
References: <20090410174247.GA12885@liondog.tnic>
	 <20090414214137.GA7278@localhost>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f164.google.com ([209.85.220.164]:42973 "EHLO
	mail-fx0-f164.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZDTJaK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Apr 2009 05:30:10 -0400
Received: by fxm8 with SMTP id 8so1037011fxm.13
        for <linux-ide@vger.kernel.org>; Mon, 20 Apr 2009 02:30:08 -0700 (PDT)
In-Reply-To: <20090414214137.GA7278@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark de Wever <koraq@xs4all.nl>
Cc: sshtylyov@ru.mvista.com, bzolnier@gmail.com, linux-ide@vger.kernel.org

Hi,

sorry for the delay but I was busy with ide stuff. In the mean time, Tejun has
fixed some ide-tape bugs and has a git tree so if you don't want to wait for the
fixes to trickle upstream and are eager to test :) you could pull from

git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git ide-phase2

and give it a run. As always, please send full dmesg.

Thanks.


-- 
Regards/Gruss,
Boris
