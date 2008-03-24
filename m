From: "Gregor Jasny" <gjasny@googlemail.com>
Subject: Burning CDs as user produces coasters (Plextor drive)
Date: Mon, 24 Mar 2008 18:39:22 +0100
Message-ID: <9d2cd630803241039m79c47754v6562404133a61274@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:36912 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760085AbYCXRja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2008 13:39:30 -0400
Received: by ug-out-1314.google.com with SMTP id z38so2166475ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 10:39:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hi,

since some time burning ISO CD images as user fails.
Wodim stops during OPC and the kernel prints some messages:

scsi: unknown opcode 0xe9
scsi: unknown opcode 0xed
scsi: unknown opcode 0xf5
scsi: unknown opcode 0xeb

If I burn as root, everything works fine. The used CD writer is a
"PLEXTOR  DVDR   PX-712A   1.09". I've seen in the wodim/cdrecord
sources that plextor drives are handled different from other drives.

Do you know what the above listed commands are for?
Maybe they could be included in blk_verify_command?
If your'e not sure about the dangerousness maybe as a config option?

Thanks,
Gregor
