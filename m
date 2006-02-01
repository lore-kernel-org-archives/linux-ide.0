From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: various fixes related to EH, take #3
Date: Thu, 2 Feb 2006 00:56:10 +0900
Message-ID: <11388093703495-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.203]:54071 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161102AbWBAP4R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Feb 2006 10:56:17 -0500
Received: by xproxy.gmail.com with SMTP id s14so125971wxc
        for <linux-ide@vger.kernel.org>; Wed, 01 Feb 2006 07:56:17 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: htejun@gmail.com


Hello, Jeff.

This patchset is what's left of the previous take [1].  From the
previous take, patch #9 and #10 were rejected and #11 and #13 were
accepted but failed to apply due to the earlier rejection.  I still
think patch #9 and #10 are correct and gave my rationale in the
original thread [2].

This patchset contains those same patches - #9, #10, #11 and #13, but
they have been reordered to ease integration.  #11 and #13 are now at
the head.

Thanks.

--
tejun

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=113798939526779&w=2
[2] http://marc.theaimsgroup.com/?l=linux-ide&m=113880834210485&w=2

