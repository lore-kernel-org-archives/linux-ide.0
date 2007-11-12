From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc1: pata_amd fails to detect 80-pin wire
Date: Mon, 12 Nov 2007 12:27:22 +0900
Message-ID: <4737C81A.5040506@gmail.com>
References: <3d08dbff0711070714m32bd0abcg5906fdfe09d633d1@mail.gmail.com> <20071107122100.d203968f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:22245 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbXKLD1b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Nov 2007 22:27:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1055235rvb
        for <linux-ide@vger.kernel.org>; Sun, 11 Nov 2007 19:27:31 -0800 (PST)
In-Reply-To: <20071107122100.d203968f.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Lindroth <thomas.lindroth@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hello,

Cable detection has always been broken for pata_amd.  Recent changes
seem to have broken some other subset tho.  The following patchset to
get it fixed once and for all is pending.

 http://thread.gmane.org/gmane.linux.ide/24524

Thanks.

-- 
tejun
