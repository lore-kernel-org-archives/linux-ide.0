From: Michal Soltys <soltys@ziu.info>
Subject: Question regarding FUA state
Date: Wed, 22 Jul 2009 21:06:26 +0200
Message-ID: <4A676332.6080205@ziu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from drutsystem.com ([80.72.38.138]:4652 "EHLO drutsystem.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbZGVTGq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jul 2009 15:06:46 -0400
Received: from drutsystem.com (localhost.drutsystem.com [127.0.0.1])
	by drutsystem.com (Postfix) with ESMTP id DF29F948070
	for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2009 19:06:35 +0000 (GMT)
Received: from [10.0.0.2] (apn-77-114-138-129.dynamic.gprs.plus.pl [77.114.138.129])
	by drutsystem.com (Postfix) with ESMTP id 0C1B794806C
	for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2009 21:06:34 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

What is the current state of fua ?

While peeking over older (mainly 2007ish) threads, there was some 
discussion about it - whenever it should or shouldn't be enabled by 
default, automatic blacklisting for certain controllers (some SiI 3xxx, 
others ...).

http://marc.info/?l=git-commits-head&m=114110310308542&w=2
http://marc.info/?t=117125096400001&r=2&w=2
http://marc.info/?t=117193493900004&r=1&w=2
http://marc.info/?t=118243369000005&r=1&w=2

Current state is "disabled by default", but simple libata module 
parameter can enable it. How safe is that these days, and if enabled, 
will problematic chipsets be blacklisted automtically ? (I didn't find 
anything in the sources suggesting it happens, but I didn't look too 
thoroughly either).

How do the following chipsets handle it:

- ICH8R and newer ones
- ATI's SB700/SB800 ones
- JMB36x
- which (if any) SiI chipsets are ok
