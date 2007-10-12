From: "mike zheng" <mail4mz@gmail.com>
Subject: Marvell SATA 88SE61xx support
Date: Fri, 12 Oct 2007 11:37:29 -0400
Message-ID: <5c9cd53b0710120837m3c2cca0ue7168eab1bc4dfbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:17362 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbXJLPha (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Oct 2007 11:37:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so828178rvb
        for <linux-ide@vger.kernel.org>; Fri, 12 Oct 2007 08:37:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

Does kernel2.6 support Marvell's 88SE6121 device? I can not find it in
mv_chip_id() in stat_mv.c. If not, is there any patch I can apply to
support it?

By the way, is there any similar support on kernel2.4? I am doing
development on kernel2.4 without atalib.

Thanks for your help,

Mike Zheng
