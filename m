From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sun, 04 Jan 2009 22:01:49 -0500
Message-ID: <yq1vdsu317m.fsf@sermon.lab.mkp.net>
References: <49615667.9020408@iwl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet14.oracle.com ([141.146.126.236]:41950 "EHLO
	acsinet14.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbZAEDDO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Jan 2009 22:03:14 -0500
Received: from acsinet11.oracle.com (acsinet11.oracle.com [141.146.126.233])
	by acsinet14.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n0536reD025170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2009 03:06:54 GMT
In-Reply-To: <49615667.9020408@iwl.com> (Karl Auerbach's message of "Sun\, 04 Jan 2009 16\:37\:59 -0800")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karl Auerbach <karl@iwl.com>
Cc: linux-ide@vger.kernel.org, karl@cavebear.com

>>>>> "Karl" == Karl Auerbach <karl@iwl.com> writes:

Karl> 2. The cs5535 ide driver doesn't seem to be able to recognize the
Karl> newer CS5536 controller for IDE.

The IDE interface of the Geode CS5536 companion chip is a completely
different beast.  It's a more or less standard AMD 8111 PCI IDE device
with slightly different timings.  There's a dedicated driver called
pata_cs5536.c (CONFIG_PATA_CS5536).

The driver was developed on a Soekris net5501.  To my knowledge it's
working fine on ALIX boards.  If that's not the case there may be a
problem with the ALIX BIOS VSA PCI config space emulation.  In that case
you can load the driver with msr=1 to force it to program the IDE
function using machine specific registers instead of relying on PCI.

Let me know how it goes.

-- 
Martin K. Petersen	Oracle Linux Engineering

