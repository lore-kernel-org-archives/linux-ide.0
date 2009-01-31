From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sat, 31 Jan 2009 07:53:21 -0500
Message-ID: <yq1pri31vsu.fsf@sermon.lab.mkp.net>
References: <20090131122500.f6817013.cjsthompson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet14.oracle.com ([148.87.113.126]:55136 "EHLO
	rgminet14.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbZAaMyi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jan 2009 07:54:38 -0500
Received: from rgminet13.oracle.com (rcsinet13.oracle.com [148.87.113.125])
	by rgminet14.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n0VCvOqP027051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Sat, 31 Jan 2009 12:57:26 GMT
In-Reply-To: <20090131122500.f6817013.cjsthompson@gmail.com> (Christoph's message of "Sat\, 31 Jan 2009 12\:25\:00 +0100")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Christoph .J Thompson" <cjsthompson@gmail.com>
Cc: linux-ide@vger.kernel.org

>>>>> "Christoph" == Christoph J Thompson <cjsthompson@gmail.com> writes:

Christoph> I'm having problems booting a kernel with pata_cs5536 on this
Christoph> box:

Christoph> [ 2.322395] VFS: Cannot open root device "LABEL=root"

Your initrd isn't set up correctly.  Probably missing the pata_cs5536
driver (or not there at all).  Either generate a suitable initrd or fix
lilo to boot with root=/dev/sdaN.

-- 
Martin K. Petersen	Oracle Linux Engineering

