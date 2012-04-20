From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Support for 4 KiB disk sectors in Linux kernel
Date: Fri, 20 Apr 2012 12:13:07 -0400
Message-ID: <yq17gxa1iwc.fsf@sermon.lab.mkp.net>
References: <4F9170FB.7080208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:50909 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab2DTQNL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 12:13:11 -0400
In-Reply-To: <4F9170FB.7080208@intel.com> (Lukasz Dorau's message of "Fri, 20
	Apr 2012 16:21:47 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lukasz Dorau <lukasz.dorau@intel.com>
Cc: linux-ide@vger.kernel.org

>>>>> "Lukasz" == Lukasz Dorau <lukasz.dorau@intel.com> writes:

Lukasz> Where can I find information about current status of support for
Lukasz> 4 KiB disk sectors in Linux kernel?  Is there a
Lukasz> leader/maintainer of this issue in community?

We have supported 4Kn for a decade. 512e obviously works out of the
box. However, filesystem/partition/DM tooling has been updated to align
correctly on 512e devices.

See:

	http://oss.oracle.com/~mkp/docs/linux-advanced-storage.pdf

-- 
Martin K. Petersen	Oracle Linux Engineering
