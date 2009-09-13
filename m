From: "Christoph .J Thompson" <cjsthompson@gmail.com>
Subject: Re: Can't burn CDs/DVDs
Date: Sun, 13 Sep 2009 18:48:40 +0200
Message-ID: <20090913184840.96784a39.cjsthompson@gmail.com>
References: <20090911193017.d47e167e.cjsthompson@gmail.com>
	<4AABD55A.9030800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:40788 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbZIMQrz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Sep 2009 12:47:55 -0400
Received: by fxm17 with SMTP id 17so392992fxm.37
        for <linux-ide@vger.kernel.org>; Sun, 13 Sep 2009 09:47:57 -0700 (PDT)
In-Reply-To: <4AABD55A.9030800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Switching to libata + via_pata fixed the problem :)

So for the record:

Dear Google reader if you are using Slackware (even up to 13.0) with a PC that has a VT823x based IDE ATA controller and that burning CDs/DVDs fails horribly, then switching to libata+via_pata will fix this.

Thanks again,

-- 
PGP: 0xC189F229
