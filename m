From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Bigger discard payloads
Date: Fri, 26 Nov 2010 10:18:58 -0500
Message-ID: <yq1aakwm7tp.fsf@sermon.lab.mkp.net>
References: <yq1mxown6t7.fsf@sermon.lab.mkp.net>
	<4CEFBBB3.4090508@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:16806 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab0KZPUR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Nov 2010 10:20:17 -0500
In-Reply-To: <4CEFBBB3.4090508@teksavvy.com> (Mark Lord's message of "Fri, 26
	Nov 2010 08:52:51 -0500")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org

>>>>> "Mark" == Mark Lord <kernel@teksavvy.com> writes:

Mark> Most of the drives I have here advertise max payload of 512 bytes.

Mark> Given this, and that the kernel won't actually use more than one
Mark> range today (except for sequential/adjacent ranges), do we think
Mark> that supporting more than 512 bytes will be useful?

I was just trying to see if I could make your wipe-partition-before-mkfs
case go faster.

-- 
Martin K. Petersen	Oracle Linux Engineering
