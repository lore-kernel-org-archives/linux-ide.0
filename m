From: diego torres <dtorres@coral.dnsalias.org>
Subject: Re[2]: blacklisting ST3500630AS as not able to do NCQ
Date: Tue, 30 Oct 2007 01:06:37 +0100
Message-ID: <1132881530.20071030010637@coral.dnsalias.org>
References: <1993911428.20071007225627@coral.dnsalias.org> <47257A4A.1000806@gmail.com>
Reply-To: diego torres <dtorres@coral.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 198.Red-217-127-201.staticIP.rima-tde.net ([217.127.201.198]:48003
	"EHLO anthalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbXJ3AGr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 20:06:47 -0400
In-Reply-To: <47257A4A.1000806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

> diego torres wrote:
>> Hi there,
>> 
>> After cheking the seagate website, there is no mention to NCQ in the
>> spec sheet of this drive, although there are models tagged as using
>> NCQ interface, for example ST3500620AS

> How reproducible is the problem?

It always happens under heavy load, or when using smartmontools when
depth_queue is > 1. I've 2 drives and both of them have the same
problem (different firmware versions).

#hdparm -i /dev/sda
Model=ST3500630AS                             , FwRev=3.AAD   , SerialNo=            6QG0FMYJ
#hdparm -i /dev/sdb
Model=ST3500630AS                             , FwRev=3.AAE   , SerialNo=            5QG0QM7A

Test in a ICH7 controller that can do ncq sucessfully (tested) with
other drives (for example, Maxtor 6V250F0)

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)

-- 
Saludos,
 diego                            mailto:dtorres@coral.dnsalias.org

