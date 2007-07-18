From: Tejun Heo <htejun@gmail.com>
Subject: Re: Recommendations on user-space soft/hardreset
Date: Wed, 18 Jul 2007 13:15:47 +0900
Message-ID: <469D93F3.8030707@gmail.com>
References: <6b01c6170707171723p4fdae403hf5b605fce4595b7@mail.gmail.com>	 <6b01c6170707171734l12af7fbdt43c28edd32776858@mail.gmail.com>	 <469D8A99.8050102@gmail.com> <6b01c6170707172104s62408da6yc11f239cc2a37860@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:51147 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbXGREPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jul 2007 00:15:52 -0400
Received: by nz-out-0506.google.com with SMTP id s18so54535nze
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 21:15:52 -0700 (PDT)
In-Reply-To: <6b01c6170707172104s62408da6yc11f239cc2a37860@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: flyashi@gmail.com
Cc: linux-ide@vger.kernel.org

Yasha Okshtein wrote:
> Well ideally this should work with a port multiplier to soft/hardreset
> only one disk behind the multiplier.

You can do that too.  Just do 'echo x - -' where x corresponds to the
PMP port number.  On older versions it's 'echo - x -'.

> Also, this again doesn't allow
> the user to specify soft or hard reset - I believe rescanning forces
> hardresets. Fully implementing the SATA spec, which should eventually
> be done anyway, seems like a cleaner solution.

It defaults to softreset.

-- 
tejun
