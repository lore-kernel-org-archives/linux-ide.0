From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA PMP for 2.6.20
Date: Tue, 06 Feb 2007 03:48:27 +0900
Message-ID: <45C77BFB.5010907@gmail.com>
References: <e532144c0702050923p3f699325k7fd805550508ba06@mail.gmail.com> <45C76B00.4070806@gmail.com> <20070205184251.GT23455@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:49079 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933331AbXBESsc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 13:48:32 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1673840wxd
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 10:48:32 -0800 (PST)
In-Reply-To: <20070205184251.GT23455@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: John Eckhart <jweckhart@gmail.com>, linux-ide@vger.kernel.org

Robin H. Johnson wrote:
> I did it for 2.6.20-rc2:
> http://dev.gentoo.org/~robbat2/libata-development/
> 
> The original message id with instructions is:
> <20061228113446.GI28939@curie-int.orbis-terrarum.net>

Yeap, you're the one I was looking for.  :-)

> There are 5 sets of patches in total of Tejun's work, named the same as
> Tejun's branches:
> hp_poll
> vt8261_ahci
> link
> pmp_prep
> pmp
> 
> I do have it in my git tree, so I should be able to rebase against
> 2.6.20 and export again.
> 
> Is there an actual merge plan for this stuff, esp. the hp_poll and
> ata_link stuff?

Yes, there definitely is.  As you can probably tell from the git history
and posted patches, libata is still under great flux.  There are three
major changes - EH improvements (under review), new init model, and
sysfs support - I wanna get in before hp_poll and pmp stuff.  So, can't
exactly tell when but it's in foreseeable future, sorry about repeated
delays.

-- 
tejun
