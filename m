From: "Ryan Earl" <heretic@clanhk.org>
Subject: siimage.c -serious- error fixed.  Performance/stability issues
     resolved.
Date: Tue, 2 Dec 2003 04:36:20 -0600 (CST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <62925.67.101.15.58.1070361380.squirrel@mail.clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palace.clanhk.org ([64.5.48.96]:39399 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S261776AbTLBKkW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Dec 2003 05:40:22 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Let me preface this by saying I'm new to the list and that I hope this is
the right place for this message.  I run a production server that utilizes
the Silicon Image 3112A SerialATA interface.  After doing research and
reading back through the kernel logs I saw there was a stability issue
being worked around by turning the request buffer down to 15KBytes from
128KByte.  While this fixed some symptoms to the problem, it did not fix
the problem and resulted in horrible perforance especially in terms of CPU
utilization.


