From: Alex Goller <alex@vivien.franken.de>
Subject: Time spent waiting for uncorrectable errors
Date: Mon, 16 Feb 2004 09:21:58 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040216082157.GK57556@vivien.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from decay.franken.de ([194.94.249.92]:12999 "EHLO vivien.franken.de")
	by vger.kernel.org with ESMTP id S265415AbUBPIWA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2004 03:22:00 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

is there any data regarding how long current disks try to read a
sector before quitting with an uncorrectable error? The problem is,
that i have no reliable way to reproduce the error, i will try to read
from a hopefully (!) broken disk this afternoon and try to measure the
time spent for that.

bye, alex
-- 
alexander goller		alex@vivien.franken.de
