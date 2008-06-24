From: "Richard Genoud" <richard.genoud@gmail.com>
Subject: PLEXTOR DVDR PX-740A drive not ready for command
Date: Tue, 24 Jun 2008 19:11:49 +0200
Message-ID: <80b317760806241011u24642294tadbfb81977f2328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:44707 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275AbYFXRLu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2008 13:11:50 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2543932wfd.4
        for <linux-ide@vger.kernel.org>; Tue, 24 Jun 2008 10:11:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

hi Bartlomiej !

I've revert-the-revert on a 2.6.26-rc7 kernel and the "drive not ready
for command" message comes again.

ref : http://bugzilla.kernel.org/show_bug.cgi?id=10239

richard.
