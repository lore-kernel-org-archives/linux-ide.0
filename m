From: "Oliver Bardenheier \(obardenh\)" <obardenh@cisco.com>
Subject: Promise_FastTrack_PDC20378_PATA
Date: Fri, 1 Dec 2006 14:59:22 +0100
Message-ID: <7FA4B8777C810C4B8F3ABBB47DF0F37503DF85BD@xmb-ams-332.emea.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ams-iport-1.cisco.com ([144.254.224.140]:9250 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S936502AbWLAN7v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Dec 2006 08:59:51 -0500
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id kB1Dxjt3027251
	for <linux-ide@vger.kernel.org>; Fri, 1 Dec 2006 14:59:45 +0100
Received: from xbh-ams-331.emea.cisco.com (xbh-ams-331.cisco.com [144.254.231.71])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id kB1DxJAR013331
	for <linux-ide@vger.kernel.org>; Fri, 1 Dec 2006 14:59:45 +0100 (MET)
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi All,

Can someone please check if the changes for  sata_promise.c - Promise
SATA
mentioned under the following link would make sense to be implemented in
vanilla ?

http://www.linuxquestions.org/linux/answers/Hardware/Promise_FastTrack_P
DC20378_PATA_or_RAID

I've tried the changes in 2.6.18 and was able afterwards to access all
drives on the SATA as well as the PATA on the Promise.
I'm currently trying to patch 2.6.19 and saw that some files have
changed location, so it would be a good idea to get this in the original
kernel.

cheers
Oliver
