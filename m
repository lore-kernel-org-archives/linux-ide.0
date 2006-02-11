From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: kill assert
Date: Sat, 11 Feb 2006 19:11:13 +0900
Message-ID: <11396526734098-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:12440 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751332AbWBKKLQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 05:11:16 -0500
Received: by zproxy.gmail.com with SMTP id k1so618606nzf
        for <linux-ide@vger.kernel.org>; Sat, 11 Feb 2006 02:11:16 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com


Hello, Jeff.

This patchset replaces assert()'s with WARN_ON()'s as you suggested[1].
#01 converts assert()'s in libata core layer, #02 in low level drivers,
and #03 kills the macro itself.  I've lightly tested converted code and
double-checked every conversion.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/7928

