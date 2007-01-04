From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive
 0x0) r0xj0
Date: Thu, 04 Jan 2007 12:18:20 +0900
Message-ID: <459C71FC.3010503@gmail.com>
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>	 <45933A53.1090702@gmail.com> <loom.20070103T020347-255@post.gmane.org>	 <459B140C.1060401@gmail.com>	 <Pine.LNX.4.64.0701030334460.12309@dolores.legate.org>	 <459B2DEA.8080202@gmail.com>	 <Pine.LNX.4.64.0701031733001.1969@dolores.legate.org> <f4527be0701031701q4eaafe63sfd5dcbbfddc89f51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:13656 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbXADDS1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jan 2007 22:18:27 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2993188nze
        for <linux-ide@vger.kernel.org>; Wed, 03 Jan 2007 19:18:26 -0800 (PST)
In-Reply-To: <f4527be0701031701q4eaafe63sfd5dcbbfddc89f51@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: bbee <bumble.bee@xs4all.nl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andrew Lyon wrote:
> Is there anything more I can do to assist? I plan to upgrade to
> 2.6.19/latest at the weekend, let me know if there is anything more i
> can do.

WD740ADFD-00 is blacklisted for NCQ in .20-rcX kernels, so you won't see
the problem anymore there.  If you're gonna use 2.6.19, you probably
wanna patch it.

-- 
tejun
