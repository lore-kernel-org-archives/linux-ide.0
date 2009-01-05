From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 05 Jan 2009 13:44:19 -0500
Message-ID: <yq1wsd91tks.fsf@sermon.lab.mkp.net>
References: <49615667.9020408@iwl.com> <yq1vdsu317m.fsf@sermon.lab.mkp.net>
	<496200A3.2000906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet14.oracle.com ([148.87.113.126]:55276 "EHLO
	rgminet14.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830AbZAESxe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 13:53:34 -0500
Received: from rgminet13.oracle.com (rcsinet13.oracle.com [148.87.113.125])
	by rgminet14.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n05ItccT021385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2009 18:55:40 GMT
In-Reply-To: <496200A3.2000906@ru.mvista.com> (Sergei Shtylyov's message of "Mon\, 05 Jan 2009 15\:44\:19 +0300")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com

>>>>> "Sergei" == Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:

>> The driver was developed on a Soekris net5501.  To my knowledge it's
>> working fine on ALIX boards.  If that's not the case there may be a
>> problem with the ALIX BIOS VSA PCI config space emulation.  In that
>> case you can load the driver with msr=1 to force it to program the
>> IDE function using machine specific registers instead of relying on
>> PCI.
>> 

Sergei> It's stange that the driver is using CPI config. space by
Sergei> default which not even documented in the datasheet.

Using PCI config space was explicitly requested by AMD for the reasons
Alan pointed out.

-- 
Martin K. Petersen	Oracle Linux Engineering
