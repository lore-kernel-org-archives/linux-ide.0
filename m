From: Tejun Heo <tj@kernel.org>
Subject: Weird ahci init failure possibly caused by PCI layer
Date: Wed, 28 Apr 2010 16:30:53 +0200
Message-ID: <4BD8469D.6080409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39782 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab0D1Oa5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Apr 2010 10:30:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Reinhard Max <max@novell.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Jesse.

There is a pretty weird ahci init failure[1] reported by Reinhard Max
against openSUSE 11.3 on Dell Optiplex 960[2].  It looks like
something between the cpu and the controller isn't properly set up and
register reads on the controller return garbage values.  The problem
appeared somewhere between 2.6.33 and 2.6.34-rc3 and is still present
in -rc5.

The following log from -rc3 seemed :-) relevant to me.

 <3>pci 0000:00:1f.2: no compatible bridge window for [mem 0xff970000-0xff9707ff]
 <4>Expanded resource reserved due to conflict with PCI Bus 0000:00
 <7>reserve RAM buffer: 000000000009e400 - 000000000009ffff
 <7>reserve RAM buffer: 00000000cfdffc00 - 00000000cfffffff

The full log from -rc3 is available[3].  Any ideas?

Thanks.

-- 
tejun

[1] https://bugzilla.novell.com/show_bug.cgi?id=598520
[2] https://bugzillafiles.novell.org/attachment.cgi?id=356199
[3] https://bugzillafiles.novell.org/attachment.cgi?id=356197
