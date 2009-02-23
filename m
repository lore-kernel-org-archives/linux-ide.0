From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] hdparm: Show form factor and media rotation rate
Date: Mon, 23 Feb 2009 11:14:10 -0500
Message-ID: <yq11vtpuo4t.fsf@sermon.lab.mkp.net>
References: <yq1fxi8eh7e.fsf@sermon.lab.mkp.net>
	<49A08310.8020100@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from acsinet11.oracle.com ([141.146.126.233]:27471 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbZBWQPo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Feb 2009 11:15:44 -0500
In-Reply-To: <49A08310.8020100@msgid.tls.msk.ru> (Michael Tokarev's message of "Sun\, 22 Feb 2009 01\:41\:20 +0300")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

>>>>> "Michael" == Michael Tokarev <mjt@tls.msk.ru> writes:

Michael> How about printing the actual (unrecognized) value here?  Like
Michael> this:

Michael>   + default:
Michael>   + printf("unknown (raw value = %d)", val[FORM_FACTOR]);
Michael>   + break;

I'm ok with that.  Mark?

-- 
Martin K. Petersen	Oracle Linux Engineering
