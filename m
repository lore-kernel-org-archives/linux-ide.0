From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Why do I see reads when writing to the disk?
Date: Thu, 26 Feb 2004 19:23:56 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1077823436.2789.51.camel@cambridge.braddahead.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:58845 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S262930AbUBZTa4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Feb 2004 14:30:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by cambridge.braddahead.com (Postfix) with ESMTP id 5A3BE1C201
	for <linux-ide@vger.kernel.org>; Thu, 26 Feb 2004 19:23:57 +0000 (GMT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've been adding DMA support to my IDE driver. I've gotten DMA Read
working fine but I've been having problems getting DMA writes working.
In the process of debugging I've noticed what seems like odd behaviour.

I'm doing writes straight to the disk with a:

dd if=testfile of=/dev/hda

testfile resides on NFS, nothing is mounted on disks yet.

However I see 8 dma_read operations before the dma_write operation. Why
is this? Am I missing some subtle point with the system cache or
something?

Please cc any responses to me as I don't seem to be able to subscribe to
the ide list.

Cheers,

-- 
Alex, homepage: http://www.bennee.com/~alex/
He who laughs last -- missed the punch line.

