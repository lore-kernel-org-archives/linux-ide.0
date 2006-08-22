From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Some questions about new EH in libata
Date: Mon, 21 Aug 2006 22:54:08 -0600
Message-ID: <8202f4270608212154k787f63a1k15ed3dcfff0624c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:10839 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932104AbWHVEyJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 00:54:09 -0400
Received: by py-out-1112.google.com with SMTP id n25so2788414pyg
        for <linux-ide@vger.kernel.org>; Mon, 21 Aug 2006 21:54:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, htejun@gmail.com

Hi Folks,

I just upgraded to the libata with new EH and I have some questions
about the new error handler:
1. In several occasions, I saw a port being disable, under what kind
of conditions will new EH disable a port?
2. For user space program, is there any way to checked the state of a
port/drive? I noticed that dmesg has some printout but that could be
wiped out by other traces or errors.
3. Does libata allow user space code to reset host/bus/drive or only
libata itself has the privilege? I tried sg reset IOCTL interface on
SATA Sil3124, it seems not working.
4. How to reenable a port/drive after it's disabled without rebooting?
Any API or command from user space?

Thanks,
Fajun
